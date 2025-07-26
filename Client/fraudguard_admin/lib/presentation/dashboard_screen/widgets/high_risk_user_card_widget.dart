import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class HighRiskUserCardWidget extends StatelessWidget {
  final Map<String, dynamic> userData;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const HighRiskUserCardWidget({
    Key? key,
    required this.userData,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  Color _getRiskColor(double riskScore) {
    if (riskScore >= 80) return AppTheme.lightTheme.colorScheme.error;
    if (riskScore >= 60) return AppTheme.warningColor(true);
    return AppTheme.successColor(true);
  }

  String _getRiskLevel(double riskScore) {
    if (riskScore >= 80) return 'Critical';
    if (riskScore >= 60) return 'High';
    return 'Medium';
  }

  @override
  Widget build(BuildContext context) {
    final String name = userData['name'] as String? ?? 'Unknown User';
    final String email = userData['email'] as String? ?? '';
    final double riskScore = (userData['riskScore'] as num?)?.toDouble() ?? 0.0;
    final String profileImage = userData['profileImage'] as String? ?? '';
    final String flagDate = userData['flagDate'] as String? ?? '';

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppTheme.lightTheme.colorScheme.shadow,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: Row(
            children: [
              // Profile Image
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _getRiskColor(riskScore),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: profileImage.isNotEmpty
                      ? CustomImageWidget(
                          imageUrl: profileImage,
                          width: 12.w,
                          height: 12.w,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color:
                              AppTheme.lightTheme.colorScheme.primaryContainer,
                          child: Center(
                            child: CustomIconWidget(
                              iconName: 'person',
                              color: AppTheme.lightTheme.colorScheme.primary,
                              size: 24,
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(width: 3.w),
              // User Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: AppTheme.lightTheme.textTheme.titleSmall
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
                            color:
                                _getRiskColor(riskScore).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            _getRiskLevel(riskScore),
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: _getRiskColor(riskScore),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    if (email.isNotEmpty)
                      Text(
                        email,
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'security',
                              color: _getRiskColor(riskScore),
                              size: 16,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              'Risk: ${riskScore.toStringAsFixed(1)}%',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: _getRiskColor(riskScore),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        if (flagDate.isNotEmpty)
                          Text(
                            'Flagged: $flagDate',
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
              SizedBox(width: 2.w),
              // Action Button
              Container(
                width: 8.w,
                height: 8.w,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'arrow_forward_ios',
                    color: AppTheme.lightTheme.colorScheme.primary,
                    size: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
