import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class RiskFactorsTab extends StatelessWidget {
  final Map<String, dynamic> userData;

  const RiskFactorsTab({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final riskFactors =
        (userData['riskFactors'] as List).cast<Map<String, dynamic>>();

    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Flagging Reasons',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 2.h),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: riskFactors.length,
            separatorBuilder: (context, index) => SizedBox(height: 2.h),
            itemBuilder: (context, index) {
              final factor = riskFactors[index];
              return _buildRiskFactorCard(factor);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRiskFactorCard(Map<String, dynamic> factor) {
    final severity = factor['severity'] as String;
    final severityData = _getSeverityData(severity);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: severityData['color'].withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: severityData['color'],
                      width: 1,
                    ),
                  ),
                  child: Text(
                    severity.toUpperCase(),
                    style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                      color: severityData['color'],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _formatDateTime(factor['timestamp'] as String),
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomIconWidget(
                  iconName: severityData['icon'],
                  color: severityData['color'],
                  size: 24,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        factor['title'] as String,
                        style: AppTheme.lightTheme.textTheme.titleSmall,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        factor['description'] as String,
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (factor['details'] != null) ...[
                        SizedBox(height: 1.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppTheme.lightTheme.colorScheme.outline,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            factor['details'] as String,
                            style: AppTheme.dataTextStyle(
                                isLight: true, fontSize: 12),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                CustomIconWidget(
                  iconName: 'trending_up',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 16,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Risk Impact: ${factor['riskImpact']}%',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                CustomIconWidget(
                  iconName: 'person',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 16,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Detected by: ${factor['detectedBy']}',
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getSeverityData(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return {
          'color': AppTheme.lightTheme.colorScheme.error,
          'icon': 'error',
        };
      case 'high':
        return {
          'color': AppTheme.warningLight,
          'icon': 'warning',
        };
      case 'medium':
        return {
          'color': Color(0xFFFF9800),
          'icon': 'info',
        };
      case 'low':
        return {
          'color': AppTheme.successLight,
          'icon': 'check_circle',
        };
      default:
        return {
          'color': AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          'icon': 'help',
        };
    }
  }

  String _formatDateTime(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }
}
