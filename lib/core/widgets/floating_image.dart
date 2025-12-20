import 'dart:math';
import 'package:flutter/material.dart';

class FloatingImageWave extends StatefulWidget {
  final String imagePath;

  const FloatingImageWave({
    super.key,
    required this.imagePath,
  });

  @override
  State<FloatingImageWave> createState() => _FloatingImageWaveState();
}

class _FloatingImageWaveState extends State<FloatingImageWave>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(); // تشتغل على طول بدون توقف
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, child) {
        // قيمة بين 0 و 2π (حركة موجية)
        double waveValue = _controller.value * 2 * pi;

        // حركة موجية (يمين/شمال + فوق/تحت)
        double dx = sin(waveValue) * 8;  // موجة بسيطة أفقية
        double dy = cos(waveValue) * 5;  // موجة بسيطة رأسية

        // نبض خفيف
        double scale = 1 + sin(waveValue) * 0.02; // 3% نبض

        return Transform.translate(
          offset: Offset(dx, dy),
          child: Transform.scale(
            scale: scale,
            child: child,
          ),
        );
      },
      child: Image.asset(
        widget.imagePath,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
