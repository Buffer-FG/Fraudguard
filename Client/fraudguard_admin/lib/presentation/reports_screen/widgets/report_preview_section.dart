import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ReportPreviewSection extends StatefulWidget {
  final String reportType;
  final DateTimeRange? dateRange;

  const ReportPreviewSection({
    Key? key,
    required this.reportType,
    required this.dateRange,
  }) : super(key: key);

  @override
  State<ReportPreviewSection> createState() => _ReportPreviewSectionState();
}

class _ReportPreviewSectionState extends State<ReportPreviewSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final summaryData = _generateSummaryData();
    final tableData = _generateTableData();

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
                'Report Preview',
                style: AppTheme.lightTheme.textTheme.titleMedium,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color:
                      AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  widget.reportType,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          _buildSummaryCards(summaryData),
          SizedBox(height: 2.h),
          GestureDetector(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Data Preview',
                  style: AppTheme.lightTheme.textTheme.titleSmall,
                ),
                CustomIconWidget(
                  iconName: _isExpanded ? 'expand_less' : 'expand_more',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 24,
                ),
              ],
            ),
          ),
          if (_isExpanded) ...[
            SizedBox(height: 1.h),
            _buildPreviewTable(tableData),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryCards(List<Map<String, dynamic>> summaryData) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 2.w,
        mainAxisSpacing: 1.h,
        childAspectRatio: 1.5,
      ),
      itemCount: summaryData.length,
      itemBuilder: (context, index) {
        final data = summaryData[index];
        return Container(
          padding: EdgeInsets.all(3.w),
          decoration: BoxDecoration(
            color: AppTheme.lightTheme.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppTheme.lightTheme.dividerColor,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data['value'],
                style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                  color: data['color'],
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 0.5.h),
              Text(
                data['label'],
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface
                      .withValues(alpha: 0.7),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPreviewTable(List<Map<String, dynamic>> tableData) {
    return Container(
      height: 25.h,
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppTheme.lightTheme.dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface
                  .withValues(alpha: 0.5),
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    'User ID',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Risk Score',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Status',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Date',
                    style: AppTheme.lightTheme.textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: tableData.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                color: AppTheme.lightTheme.dividerColor,
              ),
              itemBuilder: (context, index) {
                final data = tableData[index];
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          data['userId'],
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 1.w, vertical: 0.2.h),
                          decoration: BoxDecoration(
                            color: _getRiskColor(data['riskScore'])
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            data['riskScore'].toString(),
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: _getRiskColor(data['riskScore']),
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          data['status'],
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          data['date'],
                          style: AppTheme.lightTheme.textTheme.bodySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _generateSummaryData() {
    return [
      {
        'label': 'Total Investigations',
        'value': '1,247',
        'color': AppTheme.lightTheme.primaryColor,
      },
      {
        'label': 'Resolution Rate',
        'value': '94.2%',
        'color': AppTheme.successColor(true),
      },
      {
        'label': 'False Positive Rate',
        'value': '8.3%',
        'color': AppTheme.warningColor(true),
      },
      {
        'label': 'Avg Response Time',
        'value': '2.4h',
        'color': AppTheme.lightTheme.colorScheme.secondary,
      },
    ];
  }

  List<Map<String, dynamic>> _generateTableData() {
    return [
      {
        'userId': 'USR-2024-001',
        'riskScore': 95,
        'status': 'Flagged',
        'date': '07/16/2025',
      },
      {
        'userId': 'USR-2024-002',
        'riskScore': 78,
        'status': 'Under Review',
        'date': '07/16/2025',
      },
      {
        'userId': 'USR-2024-003',
        'riskScore': 45,
        'status': 'Cleared',
        'date': '07/15/2025',
      },
      {
        'userId': 'USR-2024-004',
        'riskScore': 89,
        'status': 'Flagged',
        'date': '07/15/2025',
      },
      {
        'userId': 'USR-2024-005',
        'riskScore': 62,
        'status': 'Monitoring',
        'date': '07/14/2025',
      },
    ];
  }

  Color _getRiskColor(int score) {
    if (score >= 80) return AppTheme.lightTheme.colorScheme.error;
    if (score >= 60) return AppTheme.warningColor(true);
    return AppTheme.successColor(true);
  }
}
