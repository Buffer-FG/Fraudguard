import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class StatusHeaderWidget extends StatelessWidget {
  final String lastSyncTime;
  final bool isConnected;

  const StatusHeaderWidget({
    Key? key,
    required this.lastSyncTime,
    this.isConnected = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'security',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 28,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'FraudGuard',
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 2.w,
                      height: 2.w,
                      decoration: BoxDecoration(
                        color: isConnected
                            ? AppTheme.successColor(true)
                            : AppTheme.lightTheme.colorScheme.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      isConnected ? 'Secure' : 'Offline',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: isConnected
                            ? AppTheme.successColor(true)
                            : AppTheme.lightTheme.colorScheme.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'sync',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 14,
                ),
                SizedBox(width: 1.w),
                Text(
                  'Last sync: $lastSyncTime',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
