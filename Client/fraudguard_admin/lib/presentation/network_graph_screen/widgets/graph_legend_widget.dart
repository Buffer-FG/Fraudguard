import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GraphLegendWidget extends StatelessWidget {
  final bool isVisible;
  final VoidCallback onToggle;

  const GraphLegendWidget({
    Key? key,
    required this.isVisible,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: isVisible ? 12.h : -20.h,
      right: 4.w,
      child: Container(
        width: 60.w,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Legend',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
                GestureDetector(
                  onTap: onToggle,
                  child: CustomIconWidget(
                    iconName: 'close',
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                    size: 5.w,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            _buildNodeLegendSection(),
            SizedBox(height: 2.h),
            _buildEdgeLegendSection(),
            SizedBox(height: 2.h),
            _buildRiskLegendSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildNodeLegendSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Node Types',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        _buildLegendItem(
          shape: BoxShape.circle,
          color: AppTheme.lightTheme.colorScheme.secondary,
          icon: 'person',
          label: 'User',
        ),
        _buildLegendItem(
          shape: BoxShape.rectangle,
          color: AppTheme.lightTheme.colorScheme.secondary,
          icon: 'router',
          label: 'IP Address',
        ),
        _buildLegendItem(
          shape: BoxShape.rectangle,
          color: AppTheme.lightTheme.colorScheme.secondary,
          icon: 'devices',
          label: 'Device',
        ),
        _buildLegendItem(
          shape: BoxShape.rectangle,
          color: AppTheme.lightTheme.colorScheme.secondary,
          icon: 'email',
          label: 'Email',
        ),
      ],
    );
  }

  Widget _buildEdgeLegendSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connection Types',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        _buildEdgeLegendItem('Shared IP', EdgeType.solid),
        _buildEdgeLegendItem('Reused Phone', EdgeType.dashed),
        _buildEdgeLegendItem('Linked Address', EdgeType.dotted),
      ],
    );
  }

  Widget _buildRiskLegendSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Risk Levels',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        _buildRiskLegendItem(
            'High Risk', AppTheme.lightTheme.colorScheme.error),
        _buildRiskLegendItem('Medium Risk', const Color(0xFFF57C00)),
        _buildRiskLegendItem(
            'Low Risk', AppTheme.lightTheme.colorScheme.secondary),
      ],
    );
  }

  Widget _buildLegendItem({
    required BoxShape shape,
    required Color color,
    required String icon,
    required String label,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: color,
              shape: shape,
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: icon,
                color: Colors.white,
                size: 3.w,
              ),
            ),
          ),
          SizedBox(width: 3.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEdgeLegendItem(String label, EdgeType type) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        children: [
          SizedBox(
            width: 8.w,
            height: 2.h,
            child: CustomPaint(
              painter: LegendEdgePainter(type: type),
            ),
          ),
          SizedBox(width: 3.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRiskLegendItem(String label, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        children: [
          Container(
            width: 4.w,
            height: 4.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 3.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}

enum EdgeType { solid, dashed, dotted }

class LegendEdgePainter extends CustomPainter {
  final EdgeType type;

  LegendEdgePainter({required this.type});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final start = Offset(0, size.height / 2);
    final end = Offset(size.width, size.height / 2);

    switch (type) {
      case EdgeType.solid:
        canvas.drawLine(start, end, paint);
        break;
      case EdgeType.dashed:
        _drawDashedLine(canvas, start, end, paint);
        break;
      case EdgeType.dotted:
        _drawDottedLine(canvas, start, end, paint);
        break;
    }
  }

  void _drawDashedLine(Canvas canvas, Offset start, Offset end, Paint paint) {
    const dashWidth = 4.0;
    const dashSpace = 2.0;

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
    const dotRadius = 1.0;
    const dotSpace = 3.0;

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
