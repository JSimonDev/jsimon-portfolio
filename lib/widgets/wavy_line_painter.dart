import 'dart:math' as math;

import 'package:flutter/material.dart';

// Define un enum para las direcciones
enum LineDirection { ltr, rtl }

class WavyLinePainter extends CustomPainter {
  final Color color; // Color de la línea
  final double thickness; // Grosor de la línea
  final StrokeCap strokeCap; // Estilo de la línea
  final PaintingStyle style; // Estilo de pintura
  final double waveHeight; // Altura de las ondas
  final double waveLength; // Longitud de las ondas
  final LineDirection direction; // Dirección de la línea

  WavyLinePainter({
    this.color = Colors.black,
    this.thickness = 2,
    this.strokeCap = StrokeCap.round,
    this.style = PaintingStyle.stroke,
    this.waveHeight = 5,
    this.waveLength = 10,
    this.direction = LineDirection
        .ltr, // Por defecto, la dirección es de izquierda a derecha
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = style
      ..strokeCap = strokeCap;

    final Path path = Path();

    // Comenzar el path
    path.moveTo(
        direction == LineDirection.ltr ? 0 : size.width, size.height / 2);

    // Dibujar ondas a lo largo del ancho del canvas
    for (double i = 0; i < size.width; i += waveLength) {
      final double x1 = direction == LineDirection.ltr ? i : size.width - i;
      final double y1 =
          size.height / 2 + waveHeight * math.sin(i * math.pi / waveLength);
      final double x2 = direction == LineDirection.ltr
          ? i + waveLength / 2
          : size.width - (i + waveLength / 2);
      final double y2 =
          size.height / 2 + waveHeight * math.cos(i * math.pi / waveLength);
      final double x3 = direction == LineDirection.ltr
          ? i + waveLength
          : size.width - (i + waveLength);
      final double y3 =
          size.height / 2 + waveHeight * math.sin(i * math.pi / waveLength);

      // Usar curvas cúbicas para suavizar las ondas
      path.cubicTo(x1, y1, x2, y2, x3, y3);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
