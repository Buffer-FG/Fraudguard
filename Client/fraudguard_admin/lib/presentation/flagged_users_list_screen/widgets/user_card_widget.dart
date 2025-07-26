import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class UserCardWidget extends StatelessWidget {
  final Map<String, dynamic> userData;
  final VoidCallback onTap;
  final VoidCallback? onReview;
  final VoidCallback? onClearFlag;
  final VoidCallback? onExport;
  final VoidCallback? onAddNote;

  const UserCardWidget({
    Key? key,
    required this.userData,
    required this.onTap,
    this.onReview,
    this.onClearFlag,
    this.onExport,
    this.onAddNote,
  }) : super(key: key);

  Color _getRiskScoreColor(double riskScore) {
    if (riskScore >= 80) return AppTheme.lightTheme.colorScheme.error;
    if (riskScore >= 60) return AppTheme.warningLight;
    return AppTheme.successLight;
  }

  String _getRiskScoreLabel(double riskScore) {
    if (riskScore >= 80) return 'HIGH';
    if (riskScore >= 60) return 'MEDIUM';
    return 'LOW';
  }

  @override
  Widget build(BuildContext context) {
    final riskScore = (userData['riskScore'] as num).toDouble();
    final flagDate = userData['flagDate'] as DateTime;

    return Dismissible(
      key: Key(userData['id'].toString()),
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.successLight.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'visibility',
              color: AppTheme.successLight,
              size: 24,
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Review',
              style: TextStyle(
                color: AppTheme.successLight,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      secondaryBackground: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 6.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomIconWidget(
              iconName: 'file_download',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 24,
            ),
            SizedBox(height: 0.5.h),
            Text(
              'Export',
              style: TextStyle(
                color: AppTheme.lightTheme.colorScheme.primary,
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onReview?.call();
        } else if (direction == DismissDirection.endToStart) {
          onExport?.call();
        }
        return false;
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            onLongPress: () {
              _showContextMenu(context);
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.lightTheme.colorScheme.outline
                      .withValues(alpha: 0.2),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.shadowLight,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Hero(
                    tag: 'user_avatar_${userData['id']}',
                    child: Container(
                      width: 15.w,
                      height: 15.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _getRiskScoreColor(riskScore)
                              .withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: ClipOval(
                        child: CustomImageWidget(
                          imageUrl: userData['avatar'] as String,
                          width: 15.w,
                          height: 15.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                userData['name'] as String,
                                style: AppTheme.lightTheme.textTheme.titleMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: _getRiskScoreColor(riskScore)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _getRiskScoreColor(riskScore)
                                      .withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                _getRiskScoreLabel(riskScore),
                                style: TextStyle(
                                  color: _getRiskScoreColor(riskScore),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          userData['email'] as String,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'warning',
                              color: _getRiskScoreColor(riskScore),
                              size: 16,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              'Risk Score: ${riskScore.toInt()}%',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: _getRiskScoreColor(riskScore),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Flagged ${_formatDate(flagDate)}',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'today';
    } else if (difference.inDays == 1) {
      return 'yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.month}/${date.day}/${date.year}';
    }
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              margin: EdgeInsets.only(top: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 2.h),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'checklist',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text('Bulk Select'),
              onTap: () {
                Navigator.pop(context);
                // Handle bulk select
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'priority_high',
                color: AppTheme.warningLight,
                size: 24,
              ),
              title: Text('Priority Flag'),
              onTap: () {
                Navigator.pop(context);
                // Handle priority flag
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'share',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 24,
              ),
              title: Text('Share'),
              onTap: () {
                Navigator.pop(context);
                // Handle share
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }
}
