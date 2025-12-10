import 'package:flutter/material.dart';
import 'dart:math' as math;

class GlitterParticles extends StatefulWidget {
  final int particleCount;
  final Color color;
  final double speed;

  const GlitterParticles({
    super.key,
    this.particleCount = 20,
    this.color = Colors.white,
    this.speed = 1.0,
  });

  @override
  State<GlitterParticles> createState() => _GlitterParticlesState();
}

class _GlitterParticlesState extends State<GlitterParticles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _particles = [];
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    for (int i = 0; i < widget.particleCount; i++) {
      _particles.add(Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: _random.nextDouble() * 4 + 2,
        speed: _random.nextDouble() * widget.speed + 0.5,
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
        return CustomPaint(
          painter: GlitterPainter(_particles, widget.color, _controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class Particle {
  final double x;
  final double y;
  final double size;
  final double speed;
  final double delay;

  Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.delay,
  });
}

class GlitterPainter extends CustomPainter {
  final List<Particle> particles;
  final Color color;
  final double animationValue;

  GlitterPainter(this.particles, this.color, this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    for (final particle in particles) {
      final progress = (animationValue + particle.delay) % 1.0;
      final y = (particle.y + progress * particle.speed) % 1.0;
      final opacity = (math.sin(progress * math.pi * 2) + 1) / 2;
      
      paint.color = color.withOpacity(opacity * 0.8);
      
      canvas.drawCircle(
        Offset(particle.x * size.width, y * size.height),
        particle.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(GlitterPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}


