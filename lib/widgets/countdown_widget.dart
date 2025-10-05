import 'dart:async';
import 'dart:ui' show FontFeature;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:invitacion_web/widgets/golden_text_widget.dart';

class Countdown extends StatefulWidget {
  final DateTime target;
  final TextStyle style;

  /// Opcional: ancho fijo de cada bloque de números/etiquetas.
  final double? itemWidth;

  /// Opcional: ancho fijo de cada separador “:”.
  final double? colonWidth;

  const Countdown({
    super.key,
    required this.target,
    required this.style,
    this.itemWidth,
    this.colonWidth,
  });

  @override
  State<Countdown> createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late Timer _timer;
  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();
    _tick();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _tick());
  }

  void _tick() {
    final diff = widget.target.difference(DateTime.now());
    setState(() => _remaining = diff.isNegative ? Duration.zero : diff);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _two(int n) => n.toString().padLeft(2, '0');

  ({int d, int h, int m, int s}) _parts() {
    final days = _remaining.inDays;
    final hours = _remaining.inHours % 24;
    final minutes = _remaining.inMinutes % 60;
    final seconds = _remaining.inSeconds % 60;
    return (d: days, h: hours, m: minutes, s: seconds);
  }

  @override
  Widget build(BuildContext context) {
    final baseFamily = GoogleFonts.playfairDisplay().fontFamily;
    final fs = widget.style.fontSize ?? 40;

    // Anchos fijos (puedes ajustar si lo deseas desde props)
    final itemW = widget.itemWidth ?? fs * 2.0;   // ancho de DÍAS / HORAS / etc.
    final colonW = widget.colonWidth ?? fs * .55; // ancho del “:”

    final digitsStyle = widget.style.copyWith(
      fontFamily: baseFamily,
      fontWeight: FontWeight.w600,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
    final labelStyle = widget.style.copyWith(
      fontFamily: baseFamily,
      fontSize: fs * 0.33,
      fontWeight: FontWeight.w400,
    );
    final colonStyle = widget.style.copyWith(
      fontFamily: baseFamily,
      fontWeight: FontWeight.w400,
    );

    final p = _parts();
    final dStr = '${p.d}';      // si quieres 2 dígitos: _two(p.d)
    final hStr = _two(p.h);
    final mStr = _two(p.m);
    final sStr = _two(p.s);

    Widget numBox(String t) => SizedBox(
      width: itemW,
      child: Center(child: Text(
        t,
        style: digitsStyle,
        textAlign: TextAlign.center
      )),
    );

    Widget labelBox(String t) => SizedBox(
      width: itemW,
      child: Center(child: Text(t, style: labelStyle, textAlign: TextAlign.center)),
    );

    Widget colonBox() => SizedBox(
      width: colonW,
      child: Center(child: Text(':', style: colonStyle, textAlign: TextAlign.center)),
    );

    Widget colonSpacer() => SizedBox(width: colonW); // mismo ancho que el “:”

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // FILA 1: CANTIDADES + SEPARADORES
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            numBox(dStr),
            colonBox(),
            numBox(hStr),
            colonBox(),
            numBox(mStr),
            colonBox(),
            numBox(sStr),
          ],
        ),
        const SizedBox(height: 4),
        // FILA 2: ETIQUETAS (los “:” se sustituyen por espaciadores del mismo ancho)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            labelBox('DÍAS'),
            colonSpacer(),
            labelBox('HORAS'),
            colonSpacer(),
            labelBox('MINUTOS'),
            colonSpacer(),
            labelBox('SEGUNDOS'),
          ],
        ),
      ],
    );
  }
}
