import 'package:flutter/material.dart';

class BrandSplash extends StatefulWidget {
  const BrandSplash({super.key, this.status = 'Connecting to greenhouse...'});

  final String status;

  @override
  State<BrandSplash> createState() => _BrandSplashState();
}

class _BrandSplashState extends State<BrandSplash>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);
    _pulse = CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _pulse,
      builder: (context, _) {
        final pulse = _pulse.value;

        return DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFEAF7ED), Color(0xFFD7F0DD), Color(0xFFB7E2C1)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: -72 + (pulse * 10),
                right: -48,
                child: _GlowOrb(
                  size: 190,
                  color: const Color(0xFF43A047).withValues(alpha: 0.18),
                ),
              ),
              Positioned(
                bottom: -92 - (pulse * 8),
                left: -64,
                child: _GlowOrb(
                  size: 230,
                  color: const Color(0xFF1B5E20).withValues(alpha: 0.13),
                ),
              ),
              Positioned(
                top: 96,
                left: 28,
                child: Transform.rotate(
                  angle: -0.25,
                  child: Icon(
                    Icons.spa_rounded,
                    size: 42,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),
              ),
              SafeArea(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Transform.scale(
                          scale: 1 + (pulse * 0.045),
                          child: Container(
                            width: 154,
                            height: 154,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.9),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF2E7D32,
                                  ).withValues(alpha: 0.22),
                                  blurRadius: 34,
                                  offset: const Offset(0, 18),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.8),
                                width: 3,
                              ),
                            ),
                            child: Image.asset(
                              'assets/img/6609077.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),
                        const Text(
                          'Smart Greenhouse',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF123524),
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.6,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.status,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: const Color(
                              0xFF2E4D38,
                            ).withValues(alpha: 0.72),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 26),
                        _LoadingBar(progress: 0.46 + (pulse * 0.28)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _LoadingBar extends StatelessWidget {
  const _LoadingBar({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 172,
      height: 7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: Stack(
          fit: StackFit.expand,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.5),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: progress.clamp(0.0, 1.0),
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF66BB6A), Color(0xFF1B5E20)],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
