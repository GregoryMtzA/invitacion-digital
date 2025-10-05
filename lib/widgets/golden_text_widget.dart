import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class GoldenText extends StatelessWidget {
  const GoldenText(
      this.text, {
        super.key,
        required this.style,
      });

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GoldenTextPainter(
        text: text,
        style: style
      ),
    );
  }
}

class _GoldenTextPainter extends CustomPainter {
  _GoldenTextPainter({
    required this.text,
    required this.style
  });

  final String text;
  final TextStyle style;

  @override
  void paint(Canvas canvas, Size _) {
    // 1) Medimos el texto una sola vez
    final baseStyle = style;

    TextPainter _tp(TextStyle s) => TextPainter(
      text: TextSpan(text: text, style: s),
      textDirection: TextDirection.ltr,
    )..layout();

    // Preparar rect para shaders
    final layoutTP = _tp(baseStyle);
    final rect = Offset.zero & layoutTP.size;

    // 2) Pinturas
    // Degradado metálico (relleno)
    final goldGradient = ui.Gradient.linear(
      rect.topLeft,
      rect.bottomRight,
      const [
        Color(0xFFFFF6C2), // brillo alto
        Color(0xFFFFD700), // dorado puro
        Color(0xFFC9A94E), // dorado oscuro
        Color(0xFFFFE477), // rebote cálido
      ],
      const [0.0, 0.35, 0.7, 1.0],
    );

    final fillPaint = Paint()..shader = goldGradient;

    // Borde exterior oscuro (profundidad)
    final outerStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = style.fontSize! * 0.10
      ..strokeJoin = StrokeJoin.round
      ..color = const Color(0xFF6C4A1A); // marrón-dorado profundo

    // Borde interior claro (bisel)
    final innerStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = style.fontSize! * 0.05
      ..strokeJoin = StrokeJoin.round
      ..color = const Color(0xFFFFEFB0);

    // Capa de glow (suave, cálida)
    final glowPaint = Paint()
      ..color = const Color(0xFFFFE08A).withOpacity(0.75)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14);

    // 3) Diferentes "TextPainter" para cada pasada
    // Glow (se pinta debajo)
    final glowTP = _tp(baseStyle.copyWith(
      color: const Color(0xFFFFE08A), // color base para el blur
    ));

    // Borde exterior
    final strokeOuterTP = _tp(baseStyle.copyWith(
      foreground: outerStroke,
    ));

    // Borde interior
    final strokeInnerTP = _tp(baseStyle.copyWith(
      foreground: innerStroke,
    ));

    // Relleno con gradiente
    final fillTP = _tp(baseStyle.copyWith(
      foreground: fillPaint,
    ));

    // 4) Pintamos en orden para simular el metal
    // 4.1 Glow sutil bajo el texto
    // pintamos el texto con blur (glowPaint se aplica en layer)
    canvas.saveLayer(rect.inflate(40), Paint());
    glowTP.paint(canvas, const Offset(0, 0));
    // Convertimos esa capa a un glow usando un rectángulo pintado encima con dstIn
    final glowRectPaint = Paint()
      ..blendMode = BlendMode.srcIn
      ..maskFilter = glowPaint.maskFilter
      ..color = glowPaint.color;
    canvas.drawRect(rect.inflate(20), glowRectPaint);
    canvas.restore();

    // 4.2 Stroke exterior (oscuro)
    strokeOuterTP.paint(canvas, const Offset(0, 0));

    // 4.3 Stroke interior (claro)
    strokeInnerTP.paint(canvas, const Offset(0, 0));

    // 4.4 Relleno dorado
    fillTP.paint(canvas, const Offset(0, 0));

    // 4.5 Destello especular (radial) para hotspot
    final spotCenter = Offset(rect.width * 0.42, rect.height * 0.45);
    final spotRadius = rect.shortestSide * 0.28;
    final specular = ui.Gradient.radial(
      spotCenter,
      spotRadius,
      [
        const Color(0xFFFFFFFF).withOpacity(0.85),
        const Color(0xFFFFF3C0).withOpacity(0.55),
        Colors.transparent,
      ],
      const [0.0, 0.35, 1.0],
    );
    final specPaint = Paint()
      ..shader = specular
      ..blendMode = BlendMode.softLight;
    canvas.drawCircle(spotCenter, spotRadius, specPaint);

    // 4.6 Línea de brillo superior (reflejo tipo “corte”)
    final highlight = Paint()
      ..shader = ui.Gradient.linear(
        rect.topLeft,
        rect.centerLeft,
        [
          Colors.white.withOpacity(0.60),
          Colors.white.withOpacity(0.0),
        ],
        const [0.0, 1.0],
      )
      ..blendMode = BlendMode.screen;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, rect.height * 0.12, rect.width, style.fontSize! * 0.07),
        const Radius.circular(8),
      ),
      highlight,
    );
  }

  @override
  bool shouldRepaint(covariant _GoldenTextPainter oldDelegate) {
    return text != oldDelegate.text;
  }

  @override
  bool shouldRebuildSemantics(covariant _GoldenTextPainter oldDelegate) => false;

  @override
  Size computeDryLayout(BoxConstraints constraints, TextStyle style) {
    final tp = TextPainter(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: constraints.maxWidth);
    // margen extra por el glow
    return (tp.size + const Offset(40, 40));
  }
}
