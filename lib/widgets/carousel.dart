import 'dart:async';
import 'package:flutter/material.dart';

class InfiniteAssetCarousel extends StatefulWidget {
  const InfiniteAssetCarousel({
    super.key,
    required this.assets,
    this.height = 280,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 3),
    this.viewportFraction = 0.86, // < 1.0 para ver orillas
    this.showIndicators = true,
    this.indicatorActiveColor,
    this.indicatorInactiveColor,
    this.fit = BoxFit.cover,
    this.radius = 16,          // redondeado SOLO en cada imagen
    this.enableTransform = true,
    this.parallax = 24.0,
    this.sideScale = 0.86,     // tamaño en orillas (< 1.0)
    this.sideOpacity = 0.85,   // opacidad en orillas (< 1.0)
  });

  final List<String> assets;
  final double height;
  final bool autoPlay;
  final Duration autoPlayInterval;
  final double viewportFraction;
  final bool showIndicators;
  final Color? indicatorActiveColor;
  final Color? indicatorInactiveColor;
  final BoxFit fit;
  final double radius;
  final bool enableTransform;
  final double parallax;
  final double sideScale;
  final double sideOpacity;

  @override
  State<InfiniteAssetCarousel> createState() => _InfiniteAssetCarouselState();
}

class _InfiniteAssetCarouselState extends State<InfiniteAssetCarousel> {
  static const int _kLoopMultiplier = 10000;
  late final int _initialPage;
  late final PageController _controller;
  Timer? _timer;
  int _logicalIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.assets.isEmpty) return;

    _initialPage = (widget.assets.length * _kLoopMultiplier) ~/ 2;
    _controller = PageController(
      initialPage: _initialPage,
      viewportFraction: widget.viewportFraction.clamp(0.6, 1.0),
    );
    _logicalIndex = _initialPage % widget.assets.length;
    _maybeStartAutoplay();
  }

  void _maybeStartAutoplay() {
    if (!widget.autoPlay || widget.assets.length <= 1) return;
    _timer?.cancel();
    _timer = Timer.periodic(widget.autoPlayInterval, (_) {
      if (!mounted || _controller.positions.isEmpty) return;
      _controller.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  void didUpdateWidget(covariant InfiniteAssetCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.autoPlay != widget.autoPlay ||
        oldWidget.autoPlayInterval != widget.autoPlayInterval) {
      _maybeStartAutoplay();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.assets.isEmpty) return const SizedBox.shrink();

    final activeColor =
        widget.indicatorActiveColor ?? Theme.of(context).colorScheme.primary;
    final inactiveColor = widget.indicatorInactiveColor ??
        Theme.of(context).colorScheme.onSurface.withOpacity(0.35);

    return SizedBox(
      height: widget.height,
      width: double.infinity,
      child: Column(
        children: [
          // Padre SIN redondeado
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (int page) {
                if (!mounted) return;
                setState(() => _logicalIndex = page % widget.assets.length);
              },
              itemBuilder: (context, index) {
                final asset = widget.assets[index % widget.assets.length];

                // Cada item se redibuja con el scroll gracias a AnimatedBuilder
                return AnimatedBuilder(
                  animation: _controller,
                  builder: (_, __) {
                    final double page = _controller.hasClients
                        ? (_controller.page ?? _controller.initialPage.toDouble())
                        : _controller.initialPage.toDouble();

                    // Distancia al centro (-1..1): 0 centro; ±1 orillas inmediatas
                    final double off = ((index - page).clamp(-1.0, 1.0)) as double;

                    // t = 1 en el centro, 0 en orillas
                    final double t = 1.0 - off.abs();

                    // Centro grande / orillas chicas
                    final double scale = widget.enableTransform
                        ? (widget.sideScale + (1.0 - widget.sideScale) * t)
                        : 1.0;

                    // Centro opaco / orillas tenues
                    final double opacity = widget.enableTransform
                        ? (widget.sideOpacity + (1.0 - widget.sideOpacity) * t)
                        : 1.0;

                    // Parallax por alignment (no cambia tamaño)
                    final double alignX = widget.enableTransform ? (off * 0.20) : 0.0;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Align(
                        alignment: Alignment.center,
                        child: Transform.scale(
                          alignment: Alignment.center,
                          scale: scale,
                          child: Opacity(
                            opacity: opacity,
                            child: _RoundedAlignedSlide(
                              asset: asset,
                              fit: widget.fit,
                              radius: widget.radius,
                              alignX: alignX,
                              onTap: () => _openFullScreen(context, asset),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          if (widget.showIndicators && widget.assets.length > 1) ...[
            const SizedBox(height: 10),
            _DotsIndicator(
              count: widget.assets.length,
              index: _logicalIndex,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
            ),
          ],
        ],
      ),
    );
  }

  void _openFullScreen(BuildContext context, String asset) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (_, __, ___) => _FullScreenImagePage(asset: asset),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
      ),
    );
  }
}

class _RoundedAlignedSlide extends StatelessWidget {
  const _RoundedAlignedSlide({
    required this.asset,
    required this.fit,
    required this.radius,
    required this.alignX,
    required this.onTap,
  });

  final String asset;
  final BoxFit fit;
  final double radius;
  final double alignX; // -1.0 .. 1.0
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const ColoredBox(color: Colors.black),
            // Parallax interno por alignment: no rompe radio ni centrado
            Image.asset(
              asset,
              fit: fit,
              alignment: Alignment(alignX, 0),
            ),
          ],
        ),
      ),
    );
  }
}

class _DotsIndicator extends StatelessWidget {
  const _DotsIndicator({
    required this.count,
    required this.index,
    required this.activeColor,
    required this.inactiveColor,
  });

  final int count;
  final int index;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isActive = i == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: isActive ? 18 : 8,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(99),
          ),
        );
      }),
    );
  }
}

class _FullScreenImagePage extends StatelessWidget {
  const _FullScreenImagePage({required this.asset});
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.98),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: InteractiveViewer(
                minScale: 0.8,
                maxScale: 4.0,
                child: Image.asset(asset, fit: BoxFit.contain),
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).maybePop(),
                tooltip: 'Cerrar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
