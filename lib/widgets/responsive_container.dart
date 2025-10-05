import 'package:flutter/material.dart';

import '../core/consts.dart';

/// 📱 Contenedor para pantallas móviles
class MobileContainer extends StatelessWidget {
  final bool border;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const MobileContainer({
    super.key,
    required this.child,
    this.border = true,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 320),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
            borderRadius: border ? BorderRadius.circular(8) : null,
            border: border ? BoxBorder.all(color: AppColors.neutralLight, width: 3) : null
        ),
        child: child,
      ),
    );
  }
}

/// 💻 Contenedor para pantallas de tablet
class TabletContainer extends StatelessWidget {
  final Widget child;

  const TabletContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 700),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}

/// 🖥️ Contenedor para pantallas de escritorio
class DesktopContainer extends StatelessWidget {
  final bool border;
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const DesktopContainer({
    super.key,
    required this.child,
    this.border = true,
    this.padding
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1366),
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
            borderRadius: border ? BorderRadius.circular(8) : null,
            border: border ? BoxBorder.all(color: AppColors.neutralLight, width: 3) : null
        ),
        child: child,
      ),
    );
  }
}
