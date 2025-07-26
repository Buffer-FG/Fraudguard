import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecentReportsSection extends StatelessWidget {
  const RecentReportsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final recentReports = _generateRecentReports();

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Reports',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              TextButton(
                onPressed: () => _showAllReports(context),
                child: Text('View All'),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          recentReports.isEmpty
              ? _buildEmptyState()
              : ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: recentReports.length,
                  separatorBuilder: (context, index) => SizedBox(height: 1.h),
                  itemBuilder: (context, index) {
                    final report = recentReports[index];
                    return _buildReportItem(context, report);
                  },
                ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      height: 20.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: 'description',
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.3),
            size: 48,
          ),
          SizedBox(height: 2.h),
          Text(
            'Generate Your First Report',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Create comprehensive fraud analysis reports\nwith export capabilities',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.5),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildReportItem(BuildContext context, Map<String, dynamic> report) {
    return GestureDetector(
      onLongPress: () => _showContextMenu(context, report),
      child: Container(
        padding: EdgeInsets.all(3.w),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: AppTheme.lightTheme.dividerColor,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color:
                    _getReportTypeColor(report['type']).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: _getReportTypeIcon(report['type']),
                color: _getReportTypeColor(report['type']),
                size: 24,
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report['name'],
                    style: AppTheme.lightTheme.textTheme.titleSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 0.5.h),
                  Row(
                    children: [
                      Text(
                        report['type'],
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                        ),
                      ),
                      Text(
                        ' • ',
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onSurface
                              .withValues(alpha: 0.5),
                        ),
                      ),
                      Text(
                        report['date'],
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: _getStatusColor(report['status'])
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    report['status'],
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: _getStatusColor(report['status']),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  report['size'],
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context, Map<String, dynamic> report) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.dividerColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              report['name'],
              style: AppTheme.lightTheme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h),
            _buildContextMenuItem(
              icon: 'download',
              label: 'Re-download',
              onTap: () {
                Navigator.pop(context);
                _redownloadReport(report);
              },
            ),
            _buildContextMenuItem(
              icon: 'share',
              label: 'Share',
              onTap: () {
                Navigator.pop(context);
                _shareReport(report);
              },
            ),
            _buildContextMenuItem(
              icon: 'delete',
              label: 'Delete',
              onTap: () {
                Navigator.pop(context);
                _deleteReport(context, report);
              },
              isDestructive: true,
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildContextMenuItem({
    required String icon,
    required String label,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: icon,
        color: isDestructive
            ? AppTheme.lightTheme.colorScheme.error
            : AppTheme.lightTheme.colorScheme.onSurface,
        size: 24,
      ),
      title: Text(
        label,
        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
          color: isDestructive
              ? AppTheme.lightTheme.colorScheme.error
              : AppTheme.lightTheme.colorScheme.onSurface,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showAllReports(BuildContext context) {
    // Navigate to full reports list
  }

  void _redownloadReport(Map<String, dynamic> report) {
    // Implement re-download functionality
  }

  void _shareReport(Map<String, dynamic> report) {
    // Implement share functionality
  }

  void _deleteReport(BuildContext context, Map<String, dynamic> report) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Report'),
        content: Text('Are you sure you want to delete "${report['name']}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement delete functionality
            },
            child: Text(
              'Delete',
              style: TextStyle(color: AppTheme.lightTheme.colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _generateRecentReports() {
    return [
      {
        'name': 'Weekly Fraud Analysis - July 2025',
        'type': 'Weekly Analysis',
        'date': '07/16/2025',
        'status': 'Ready',
        'size': '2.4 MB',
      },
      {
        'name': 'Monthly Trends Report - June 2025',
        'type': 'Monthly Trends',
        'date': '07/01/2025',
        'status': 'Ready',
        'size': '5.1 MB',
      },
      {
        'name': 'Compliance Audit Q2 2025',
        'type': 'Compliance Audit',
        'date': '06/30/2025',
        'status': 'Processing',
        'size': '8.7 MB',
      },
    ];
  }

  Color _getReportTypeColor(String type) {
    switch (type) {
      case 'Daily Summary':
        return AppTheme.lightTheme.primaryColor;
      case 'Weekly Analysis':
        return AppTheme.successColor(true);
      case 'Monthly Trends':
        return AppTheme.warningColor(true);
      case 'Custom Range':
        return AppTheme.lightTheme.colorScheme.secondary;
      case 'Compliance Audit':
        return AppTheme.lightTheme.colorScheme.error;
      default:
        return AppTheme.lightTheme.colorScheme.onSurface;
    }
  }

  String _getReportTypeIcon(String type) {
    switch (type) {
      case 'Daily Summary':
        return 'today';
      case 'Weekly Analysis':
        return 'date_range';
      case 'Monthly Trends':
        return 'trending_up';
      case 'Custom Range':
        return 'tune';
      case 'Compliance Audit':
        return 'verified_user';
      default:
        return 'description';
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Ready':
        return AppTheme.successColor(true);
      case 'Processing':
        return AppTheme.warningColor(true);
      case 'Failed':
        return AppTheme.lightTheme.colorScheme.error;
      default:
        return AppTheme.lightTheme.colorScheme.onSurface;
    }
  }
}
