import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class UserHeaderCard extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserHeaderCard({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final riskScore = (userData['riskScore'] as num).toDouble();
    final riskLevel = _getRiskLevel(riskScore);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline,
                      width: 2,
                    ),
                  ),
                  child: CustomImageWidget(
                    imageUrl: 'assets/images/user_placeholder.png', // this should be your default image
                    width: 20.w,
                    height: 20.w,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userData['name'] as String? ?? 'Unknown',
                        style: AppTheme.lightTheme.textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        userData['email'] as String? ?? 'Unknown',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        userData['phone'] as String? ?? 'Unknown',
                        style: AppTheme.lightTheme.textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: riskLevel['color'].withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: riskLevel['color'],
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Risk Score',
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: riskLevel['color'],
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        '${riskScore.toInt()}%',
                        style:
                            AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                          color: riskLevel['color'],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        riskLevel['label'],
                        style:
                            AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                          color: riskLevel['color'],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    'Account ID',
                    userData['accountId'] as String,
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    'Status',
                    userData['status'] as String,
                  ),
                ),
                Expanded(
                  child: _buildInfoItem(
                    'Flagged Date',
                    _formatDate(userData['flaggedDate'] as String),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          value,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Map<String, dynamic> _getRiskLevel(double score) {
    if (score >= 80) {
      return {
        'label': 'High',
        'color': AppTheme.lightTheme.colorScheme.error,
      };
    } else if (score >= 50) {
      return {
        'label': 'Medium',
        'color': AppTheme.warningLight,
      };
    } else {
      return {
        'label': 'Low',
        'color': AppTheme.successLight,
      };
    }
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
