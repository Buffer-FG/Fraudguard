import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class DateRangePicker extends StatelessWidget {
  final DateTimeRange? selectedRange;
  final Function(DateTimeRange?) onRangeSelected;

  const DateRangePicker({
    Key? key,
    required this.selectedRange,
    required this.onRangeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> presetOptions = [
      {'label': 'Today', 'days': 0},
      {'label': 'Week', 'days': 7},
      {'label': 'Month', 'days': 30},
      {'label': 'Quarter', 'days': 90},
    ];

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
          Text(
            'Date Range',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 2.w,
            runSpacing: 1.h,
            children: presetOptions.map((option) {
              final isSelected = _isPresetSelected(option['days']);
              return GestureDetector(
                onTap: () => _selectPreset(option['days']),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.8.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.lightTheme.primaryColor
                            .withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected
                          ? AppTheme.lightTheme.primaryColor
                          : AppTheme.lightTheme.dividerColor,
                      width: 1,
                    ),
                  ),
                  child: Text(
                    option['label'],
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? AppTheme.lightTheme.primaryColor
                          : AppTheme.lightTheme.colorScheme.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _showCustomDatePicker(context),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
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
                        CustomIconWidget(
                          iconName: 'calendar_today',
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                          size: 20,
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          selectedRange != null
                              ? '${_formatDate(selectedRange!.start)} - ${_formatDate(selectedRange!.end)}'
                              : 'Custom Range',
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bool _isPresetSelected(int days) {
    if (selectedRange == null) return false;
    final now = DateTime.now();
    final startDate = days == 0
        ? DateTime(now.year, now.month, now.day)
        : now.subtract(Duration(days: days));
    final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

    return selectedRange!.start.isAtSameMomentAs(startDate) &&
        selectedRange!.end.day == endDate.day;
  }

  void _selectPreset(int days) {
    final now = DateTime.now();
    final startDate = days == 0
        ? DateTime(now.year, now.month, now.day)
        : now.subtract(Duration(days: days));
    final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

    onRangeSelected(DateTimeRange(start: startDate, end: endDate));
  }

  void _showCustomDatePicker(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(Duration(days: 365)),
      lastDate: DateTime.now(),
      initialDateRange: selectedRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: AppTheme.lightTheme.colorScheme,
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onRangeSelected(picked);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
  }
}
