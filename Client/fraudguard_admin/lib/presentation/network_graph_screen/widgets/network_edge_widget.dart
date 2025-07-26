import 'package:flutter/material.dart';

class NetworkEdgeWidget extends StatelessWidget {
  final Map<String, dynamic> edge;
  final Offset startPoint;
  final Offset endPoint;
  final bool isHighlighted;

  const NetworkEdgeWidget({
    Key? key,
    required this.edge,
    required this.startPoint,
    required this.endPoint,
    this.isHighlighted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final edgeType = edge['type'] as String;

    return CustomPaint(
      painter: EdgePainter(
        startPoint: startPoint,
        endPoint: endPoint,
        edgeType: edgeType,
        isHighlighted: isHighlighted,
      ),
    );
  }
}

class EdgePainter extends CustomPainter {
  final Offset startPoint;
  final Offset endPoint;
  final String edgeType;
  final bool isHighlighted;

  EdgePainter({
    required this.startPoint,
    required this.endPoint,
    required this.edgeType,
    required this.isHighlighted,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isHighlighted
          ? const Color(0xFF1565C0)
          : Colors.grey.withValues(alpha: 0.6)
      ..strokeWidth = isHighlighted ? 3.0 : 2.0;

    switch (edgeType.toLowerCase()) {
      case 'shared_ip':
        paint.style = PaintingStyle.stroke;
        canvas.drawLine(startPoint, endPoint, paint);
        break;
      case 'reused_phone':
        paint.style = PaintingStyle.stroke;
        _drawDashedLine(canvas, startPoint, endPoint, paint);
        break;
      case 'linked_address':
        paint.style = PaintingStyle.stroke;
        _drawDottedLine(canvas, startPoint, endPoint, paint);
        break;
      default:
        paint.style = PaintingStyle.stroke;
        canvas.drawLine(startPoint, endPoint, paint);
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 5.0;
    const dashSpace = 3.0;

    final distance = (end - start).distance;
    final dashCount = (distance / (dashWidth + dashSpace)).floor();

    for (int i = 0; i < dashCount; i++) {
      final startOffset =
          start + (end - start) * (i * (dashWidth + dashSpace) / distance);
      final endOffset = start +
          (end - start) *
              ((i * (dashWidth + dashSpace) + dashWidth) / distance);
      canvas.drawLine(startOffset, endOffset, paint);
    }
  }

  void _drawDottedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dotRadius = 1.5;
    const dotSpace = 4.0;

    final distance = (end - start).distance;
    final dotCount = (distance / dotSpace).floor();

    for (int i = 0; i < dotCount; i++) {
      final dotOffset = start + (end - start) * (i * dotSpace / distance);
      canvas.drawCircle(dotOffset, dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
