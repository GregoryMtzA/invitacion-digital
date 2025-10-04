import 'package:flutter/material.dart';

/// Enum para identificar el tipo de dispositivo
enum DeviceType { mobile, tablet, laptop, desktop}

/// Widget que te da el tipo de dispositivo en función del ancho
class ResponsiveLayout extends StatelessWidget {
  /// Builder que te entrega el [DeviceType] para decidir qué mostrar
  final Widget Function(BuildContext context, DeviceType type) builder;

  /// Puntos de quiebre personalizables (en píxeles)
  final double tabletBreakpoint;
  final double laptopBreakpoint;
  final double desktopBreakpoint;

  const ResponsiveLayout({
    super.key,
    required this.builder,
    this.tabletBreakpoint = 600,
    this.laptopBreakpoint = 1024,
    this.desktopBreakpoint = 1366,
  });

  /// Calcula el tipo de dispositivo a partir del ancho
  DeviceType _getDeviceType(double width) {
    if (width >= desktopBreakpoint) return DeviceType.desktop;
    if (width >= laptopBreakpoint) return DeviceType.laptop;
    if (width >= tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final type = _getDeviceType(constraints.maxWidth);
        return builder(context, type);
      },
    );
  }
}
