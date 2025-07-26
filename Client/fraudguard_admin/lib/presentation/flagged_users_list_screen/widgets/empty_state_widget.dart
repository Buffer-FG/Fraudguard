import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onClearFilters;
  final bool hasActiveFilters;

  const EmptyStateWidget({
    Key? key,
    required this.onClearFilters,
    required this.hasActiveFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary
                    .withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomIconWidget(
                  iconName: hasActiveFilters ? 'filter_alt_off' : 'security',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 60,
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              hasActiveFilters ? 'No Results Found' : 'No Flagged Users',
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            Text(
              hasActiveFilters
                  ? 'No users match your current filter criteria. Try adjusting your filters or clearing them to see all flagged users.'
                  : 'Great news! There are currently no flagged users in the system. All users have passed fraud detection checks.',
              style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 4.h),
            if (hasActiveFilters)
              ElevatedButton.icon(
                onPressed: onClearFilters,
                icon: CustomIconWidget(
                  iconName: 'clear_all',
                  color: AppTheme.lightTheme.colorScheme.onPrimary,
                  size: 20,
                ),
                label: Text('Clear All Filters'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                ),
              )
            else
              OutlinedButton.icon(
                onPressed: () {
                  // Navigate to dashboard or refresh
                },
                icon: CustomIconWidget(
                  iconName: 'refresh',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 20,
                ),
                label: Text('Refresh'),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                ),
              ),
            SizedBox(height: 2.h),
            if (!hasActiveFilters)
              Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: AppTheme.successLight.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppTheme.successLight.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'check_circle',
                      color: AppTheme.successLight,
                      size: 24,
                    ),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        'System Status: All Clear',
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.successLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
