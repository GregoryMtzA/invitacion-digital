import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// Opcional: tus imports si navegas a una vista concreta
import 'package:invitacion_web/src/invitation_1.dart';
import '../core/consts.dart';

class SplashLottieView extends StatefulWidget {
  const SplashLottieView({
    super.key,
    required this.asset,            // URL o ruta local del Lottie
    required this.overlayAsset,     // Imagen asset que se muestra al final
    this.fit = BoxFit.contain,
    this.overlayFit = BoxFit.contain,
    this.backgroundColor = Colors.white,
    this.onFinished,                // Si lo usas, se llama después del delay
    this.delayBeforeNavigate = const Duration(seconds: 2),
    this.overlayFadeDuration = const Duration(milliseconds: 600),
    required this.allowed,
    required this.family
  });

  final String asset;
  final String overlayAsset;
  final BoxFit fit;
  final String family;
  final int allowed;
  final BoxFit overlayFit;
  final Color backgroundColor;

  final Duration delayBeforeNavigate;
  final Duration overlayFadeDuration;

  /// Callback opcional si prefieres manejar tú la navegación.
  final VoidCallback? onFinished;

  @override
  State<SplashLottieView> createState() => _SplashLottieViewState();
}

class _SplashLottieViewState extends State<SplashLottieView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _played = false;
  bool _showOverlay = false;
  bool _navigated = false;
  bool _showInvited = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Detén la animación en su último frame
        _controller.stop();

        // Muestra overlay con fade y programa navegación
        _onAnimationFinished();
      }
    });
  }

  Future<void> _onAnimationFinished() async {
    if (!mounted || _navigated) return;
    setState(() => _showOverlay = true);

    // Espera el tiempo solicitado (independiente de la duración del fade)
    await Future.delayed(widget.delayBeforeNavigate);
    if (!mounted || _navigated) return;

    _navigated = true;
    if (widget.onFinished != null) {
      widget.onFinished!();
    } else {
      _showInvited = true;
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    if (_played) return;
    _played = true;
    _controller.forward(from: 0);
  }

  Widget _buildLottie() {
    return Lottie.asset(
      widget.asset,
      controller: _controller,
      fit: widget.fit,
      onLoaded: (composition) {
        _controller.duration = composition.duration;
        _controller.value = 0;
        _controller.stop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: _showInvited
              ? Invitation1(
            portada: AppAssets.landscape1Cropped,
            portadaMovil: widget.overlayAsset,
            name: "Dora Elena Sánchez De Leija",
            fecha: DateTime(2025, 11, 8),
            available: widget.allowed,
            family: widget.family,
          )
              : GestureDetector(
            behavior: HitTestBehavior.opaque, // Toca en cualquier parte
            onTap: _handleTap,
            child: Container(
              color: widget.backgroundColor,
              alignment: Alignment.center,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    bottom: -35,
                    left: -25,
                    child: RotatedBox(
                        quarterTurns: 3,
                        child: Image.asset(AppAssets.rosas1, height: 150,)
                    ),
                  ),
                  Positioned(
                    bottom: -35,
                    right: -25,
                    child: RotatedBox(
                        quarterTurns: 2,
                        child: Image.asset(AppAssets.rosas1, height: 150,)
                    ),
                  ),
                  Positioned(
                    top: -35,
                    left: -25,
                    child: Image.asset(AppAssets.rosas1, height: 150,),
                  ),
                  Positioned(
                    top: -35,
                    right: -25,
                    child: RotatedBox(
                        quarterTurns: 1,
                        child: Image.asset(AppAssets.rosas1, height: 150,)
                    ),
                  ),

                  if (!_showOverlay)
                    Positioned(
                        top: size.height * 0.13,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 300),
                            child: Text(
                              "Dora Elena\nSánchez De Leija",
                              style: InvStyles.title.copyWith(color: AppColors.roseGold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                    ),

                  if (!_showOverlay)
                    Positioned(
                      top: size.height * 0.58,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: Text(
                            "Haz clic para abrir la invitación",
                            style: InvStyles.text.copyWith(fontSize: 12),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),

                  if (!_showOverlay)
                    Positioned(
                      top: size.height * 0.62,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 300),
                          child: Column(
                            spacing: 10,
                            children: [
                              AutoSizeText(
                                widget.family,
                                maxLines: 1,
                                minFontSize: 20,
                                maxFontSize: 40,
                                style: InvStyles.title.copyWith(color: Color(0xff9d853b)),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "Hemos reservado \n ${widget.allowed} lugares en su honor.",
                                style: InvStyles.text,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  // Lottie de fondo
                  Align(
                    alignment: Alignment.center,
                    child: _buildLottie(),
                  ),

                  // Overlay con fade-in al completar
                  AnimatedOpacity(
                    opacity: _showOverlay ? 1 : 0,
                    duration: widget.overlayFadeDuration,
                    curve: Curves.easeOut,
                    child: IgnorePointer(
                      ignoring: true, // solo visual
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            widget.overlayAsset,
                            fit: widget.overlayFit,
                            height: 600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}