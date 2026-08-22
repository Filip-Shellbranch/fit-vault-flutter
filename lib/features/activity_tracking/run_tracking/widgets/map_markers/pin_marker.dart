import 'package:flutter/material.dart';

class PinMarker extends StatelessWidget {
  final String text;
  final Color color;
  final Size size;

  const PinMarker({
    super.key,
    required this.text,
    this.color = Colors.blue,
    this.size = const Size(30, 50),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          CustomPaint(
            size: size,
            painter: PinMarkerPainter(color: color),
          ),
          Positioned(
            top: 3,
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PinMarkerPainter extends CustomPainter {
  final Color color;

  PinMarkerPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    final cornerRadius = w * 0.22;
    final pointX = w / 2;

    final path = Path();

    path.moveTo(cornerRadius, 0);

    // Top-left rounded corner
    path.quadraticBezierTo(0, 0, 0, cornerRadius);

    // Left side
    path.lineTo(0, h * 0.42);

    // Left side -> point
    path.cubicTo(0, h * 0.62, w * 0.25, h * 0.75, pointX, h);

    // Point -> right side
    path.cubicTo(w * 0.75, h * 0.75, w, h * 0.62, w, h * 0.42);

    // Right top rounded corner
    path.lineTo(w, cornerRadius);

    path.quadraticBezierTo(w, 0, w - cornerRadius, 0);

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant PinMarkerPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
