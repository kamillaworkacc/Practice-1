import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../theme/app_theme.dart';

class KawaiiPlanet extends StatelessWidget {
  final double size;
  final Color? planetColor;
  final bool hasFace;
  final String emoji;

  const KawaiiPlanet({
    super.key,
    this.size = 60,
    this.planetColor,
    this.hasFace = true,
    this.emoji = '🌍',
  });

  @override
  Widget build(BuildContext context) {
    final color = planetColor ?? AppTheme.spacePurple;
    
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            color.withOpacity(0.7),
            color.withOpacity(0.5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: size * 0.3,
            spreadRadius: size * 0.1,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: PixelPatternPainter(color),
          ),
          if (hasFace)
            Text(
              emoji,
              style: TextStyle(fontSize: size * 0.5),
            )
          else
            Text(
              emoji,
              style: TextStyle(fontSize: size * 0.6),
            ),
        ],
      ),
    );
  }
}

class PixelPatternPainter extends CustomPainter {
  final Color color;

  PixelPatternPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final random = math.Random(42);
    
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (random.nextBool()) {
          final x = (i / 8) * size.width;
          final y = (j / 8) * size.height;
          final pixelSize = size.width / 12;
          
          canvas.drawRect(
            Rect.fromLTWH(x, y, pixelSize, pixelSize),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(PixelPatternPainter oldDelegate) => false;
}

class FloatingPlanets extends StatefulWidget {
  final int planetCount;
  final List<String>? emojis;

  const FloatingPlanets({
    super.key,
    this.planetCount = 3,
    this.emojis,
  });

  @override
  State<FloatingPlanets> createState() => _FloatingPlanetsState();
}

class _FloatingPlanetsState extends State<FloatingPlanets>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final math.Random _random = math.Random();
  final List<PlanetData> _planets = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();

    final emojis = widget.emojis ?? ['🌍', '🌎', '🌏', '🪐', '⭐', '🌟', '💫', '✨'];
    final colors = [
      AppTheme.spacePurple,
      AppTheme.spacePink,
      AppTheme.spaceBlue,
      Colors.purple.shade300,
      Colors.pink.shade300,
    ];

    for (int i = 0; i < widget.planetCount; i++) {
      _planets.add(PlanetData(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 30 + 40,
        emoji: emojis[_random.nextInt(emojis.length)],
        color: colors[_random.nextInt(colors.length)],
        speed: _random.nextDouble() * 0.3 + 0.1,
        delay: _random.nextDouble() * 2,
      ));
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: _planets.map((planet) {
            final progress = (_controller.value + planet.delay) % 1.0;
            final y = (planet.y + progress * planet.speed) % 1.0;
            final opacity = (math.sin(progress * math.pi * 4) + 1) / 2 * 0.3 + 0.7;
            
            return Positioned(
              left: planet.x * MediaQuery.of(context).size.width,
              top: y * MediaQuery.of(context).size.height,
              child: Opacity(
                opacity: opacity,
                child: KawaiiPlanet(
                  size: planet.size,
                  planetColor: planet.color,
                  emoji: planet.emoji,
                  hasFace: true,
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class PlanetData {
  final double x;
  final double y;
  final double size;
  final String emoji;
  final Color color;
  final double speed;
  final double delay;

  PlanetData({
    required this.x,
    required this.y,
    required this.size,
    required this.emoji,
    required this.color,
    required this.speed,
    required this.delay,
  });
}

