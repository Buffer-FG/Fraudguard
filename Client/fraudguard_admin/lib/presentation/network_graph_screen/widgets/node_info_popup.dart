import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class NodeInfoPopup extends StatelessWidget {
  final Map<String, dynamic> node;
  final Offset position;
  final VoidCallback onClose;
  final VoidCallback? onViewDetails;

  const NodeInfoPopup({
    Key? key,
    required this.node,
    required this.position,
    required this.onClose,
    this.onViewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx - 40.w,
      top: position.dy - 15.h,
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: 80.w,
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHeader(),
              SizedBox(height: 2.h),
              _buildNodeInfo(),
              SizedBox(height: 2.h),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    final nodeType = node['type'] as String;
    final riskLevel = node['riskLevel'] as String;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                color: _getRiskColor(riskLevel),
                shape: nodeType.toLowerCase() == 'user'
                    ? BoxShape.circle
                    : BoxShape.rectangle,
                borderRadius: nodeType.toLowerCase() != 'user'
                    ? BorderRadius.circular(4)
                    : null,
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: _getNodeIcon(nodeType),
                  color: Colors.white,
                  size: 4.w,
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nodeType.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  node['label'] as String,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: onClose,
          child: Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline,
                width: 1,
              ),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'close',
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 3.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNodeInfo() {
    final nodeType = node['type'] as String;
    final riskLevel = node['riskLevel'] as String;
    final riskScore = node['riskScore'] as double;

    return Column(
      children: [
        _buildInfoRow('Risk Level', riskLevel, color: _getRiskColor(riskLevel)),
        _buildInfoRow('Risk Score', '${(riskScore * 100).toInt()}%'),
        if (nodeType.toLowerCase() == 'user') ...[
          _buildInfoRow('Email', node['email'] as String? ?? 'N/A'),
          _buildInfoRow(
              'Last Activity', _formatDate(node['lastActivity'] as DateTime?)),
        ] else if (nodeType.toLowerCase() == 'ip') ...[
          _buildInfoRow('IP Address', node['ipAddress'] as String? ?? 'N/A'),
          _buildInfoRow('Location', node['location'] as String? ?? 'Unknown'),
        ] else if (nodeType.toLowerCase() == 'device') ...[
          _buildInfoRow(
              'Device Type', node['deviceType'] as String? ?? 'Unknown'),
          _buildInfoRow('OS', node['os'] as String? ?? 'Unknown'),
        ] else if (nodeType.toLowerCase() == 'email') ...[
          _buildInfoRow('Domain', node['domain'] as String? ?? 'N/A'),
          _buildInfoRow(
              'Verified', (node['verified'] as bool? ?? false) ? 'Yes' : 'No'),
        ],
        _buildInfoRow('Connections', '${node['connectionCount'] as int? ?? 0}'),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, {Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.7),
            ),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
                color: color ?? AppTheme.lightTheme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.end,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onClose,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 1.5.h),
              side: BorderSide(
                color: AppTheme.lightTheme.colorScheme.outline,
                width: 1,
              ),
            ),
            child: Text(
              'Close',
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        if (onViewDetails != null) ...[
          SizedBox(width: 3.w),
          Expanded(
            child: ElevatedButton(
              onPressed: onViewDetails,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 1.5.h),
              ),
              child: Text(
                'View Details',
                style: TextStyle(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Color _getRiskColor(String riskLevel) {
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

  String _formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
