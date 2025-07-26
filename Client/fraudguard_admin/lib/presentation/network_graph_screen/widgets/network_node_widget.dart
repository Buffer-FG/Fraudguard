import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NetworkNodeWidget extends StatelessWidget {
  final Map<String, dynamic> node;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final bool isSelected;
  final bool isHighlighted;

  const NetworkNodeWidget({
    Key? key,
    required this.node,
    this.onTap,
    this.onLongPress,
    this.isSelected = false,
    this.isHighlighted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nodeType = node['type'] as String;
    final riskLevel = node['riskLevel'] as String;
    final label = node['label'] as String;

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: 12.w,
        height: 12.w,
        decoration: BoxDecoration(
          color: _getNodeColor(riskLevel),
          shape: _getNodeShape(nodeType),
          border: Border.all(
            color: isSelected
                ? AppTheme.lightTheme.primaryColor
                : isHighlighted
                    ? AppTheme.lightTheme.colorScheme.secondary
                    : Colors.transparent,
            width: isSelected
                ? 3.0
                : isHighlighted
                    ? 2.0
                    : 0.0,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: _getNodeIcon(nodeType),
                color: Colors.white,
                size: 4.w,
              ),
              if (label.isNotEmpty)
                Padding(
                  padding: EdgeInsets.only(top: 0.5.h),
                  child: Text(
                    label.length > 8 ? '${label.substring(0, 8)}...' : label,
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getNodeColor(String riskLevel) {
    switch (riskLevel.toLowerCase()) {
      case 'high':
        return AppTheme.lightTheme.colorScheme.error;
      case 'medium':
        return const Color(0xFFF57C00);
      case 'low':
        return AppTheme.lightTheme.colorScheme.secondary;
      default:
        return Colors.grey;
    }
  }

  BoxShape _getNodeShape(String nodeType) {
    switch (nodeType.toLowerCase()) {
      case 'user':
        return BoxShape.circle;
      case 'ip':
      case 'device':
      case 'email':
      default:
        return BoxShape.rectangle;
    }
  }

  String _getNodeIcon(String nodeType) {
    switch (nodeType.toLowerCase()) {
      case 'user':
        return 'person';
      case 'ip':
        return 'router';
      case 'device':
        return 'devices';
      case 'email':
        return 'email';
      default:
        return 'help';
    }
  }
}
