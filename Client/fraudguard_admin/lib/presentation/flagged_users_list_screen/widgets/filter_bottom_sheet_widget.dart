import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../theme/app_theme.dart';

class FilterBottomSheetWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onFiltersApplied;

  const FilterBottomSheetWidget({
    Key? key,
    required this.onFiltersApplied,
  }) : super(key: key);

  @override
  State<FilterBottomSheetWidget> createState() =>
      _FilterBottomSheetWidgetState();
}

class _FilterBottomSheetWidgetState extends State<FilterBottomSheetWidget> {
  String? _selectedRegion;
  RangeValues _riskScoreRange = const RangeValues(0, 100);
  DateTime? _startDate;
  DateTime? _endDate;
  String? _selectedDatePreset;

  final List<String> _regions = [
    'All Regions',
    'North America',
    'Europe',
    'Asia Pacific',
    'Latin America',
    'Middle East & Africa',
  ];

  final List<Map<String, dynamic>> _datePresets = [
    {'label': 'Today', 'days': 0},
    {'label': 'Last 7 Days', 'days': 7},
    {'label': 'Last 30 Days', 'days': 30},
    {'label': 'Last 90 Days', 'days': 90},
  ];

  @override
  void initState() {
    super.initState();
    _selectedRegion = _regions.first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHandle(),
          _buildHeader(),
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildRegionFilter(),
                  _buildRiskScoreFilter(),
                  _buildDateFilter(),
                  SizedBox(height: 2.h),
                ],
              ),
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHandle() {
    return Container(
      width: 12.w,
      height: 0.5.h,
      margin: EdgeInsets.only(top: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 1.h),
      child: Row(
        children: [
          Text(
            'Filter Options',
            style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          TextButton(
            onPressed: _resetFilters,
            child: Text(
              'Reset',
              style: TextStyle(
                color: AppTheme.lightTheme.colorScheme.primary,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegionFilter() {
    return ExpansionTile(
      title: Text(
        'Region',
        style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        _selectedRegion ?? 'Select region',
        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
          color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        ),
      ),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: _regions.map((region) {
              return RadioListTile<String>(
                title: Text(region),
                value: region,
                groupValue: _selectedRegion,
                onChanged: (value) {
                  setState(() {
                    _selectedRegion = value;
                  });
                },
                activeColor: AppTheme.lightTheme.colorScheme.primary,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildRiskScoreFilter() {
    return ExpansionTile(
      title: Text(
        'Risk Score Range',
        style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        '${_riskScoreRange.start.round()}% - ${_riskScoreRange.end.round()}%',
        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
          color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        ),
      ),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '0%',
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                  Text(
                    '100%',
                    style: AppTheme.lightTheme.textTheme.bodySmall,
                  ),
                ],
              ),
              RangeSlider(
                values: _riskScoreRange,
                min: 0,
                max: 100,
                divisions: 20,
                labels: RangeLabels(
                  '${_riskScoreRange.start.round()}%',
                  '${_riskScoreRange.end.round()}%',
                ),
                onChanged: (values) {
                  setState(() {
                    _riskScoreRange = values;
                  });
                },
                activeColor: AppTheme.lightTheme.colorScheme.primary,
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateFilter() {
    return ExpansionTile(
      title: Text(
        'Date Range',
        style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        _getDateRangeText(),
        style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
          color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
        ),
      ),
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Presets',
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 1.h),
              Wrap(
                spacing: 2.w,
                runSpacing: 1.h,
                children: _datePresets.map((preset) {
                  final isSelected = _selectedDatePreset == preset['label'];
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDatePreset = preset['label'];
                        final now = DateTime.now();
                        _endDate = now;
                        _startDate =
                            now.subtract(Duration(days: preset['days']));
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.lightTheme.colorScheme.primary
                            : AppTheme.lightTheme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.lightTheme.colorScheme.primary
                              : AppTheme.lightTheme.colorScheme.outline
                                  .withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        preset['label'],
                        style: TextStyle(
                          color: isSelected
                              ? AppTheme.lightTheme.colorScheme.onPrimary
                              : AppTheme.lightTheme.colorScheme.onSurface,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 2.h),
              Text(
                'Custom Range',
                style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 1.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _selectDate(context, true),
                      child: Text(
                        _startDate != null
                            ? '${_startDate!.month}/${_startDate!.day}/${_startDate!.year}'
                            : 'Start Date',
                      ),
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _selectDate(context, false),
                      child: Text(
                        _endDate != null
                            ? '${_endDate!.month}/${_endDate!.day}/${_endDate!.year}'
                            : 'End Date',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2.h),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 4.h),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: ElevatedButton(
              onPressed: _applyFilters,
              child: Text('Apply Filters'),
            ),
          ),
        ],
      ),
    );
  }

  String _getDateRangeText() {
    if (_selectedDatePreset != null) {
      return _selectedDatePreset!;
    }
    if (_startDate != null && _endDate != null) {
      return '${_startDate!.month}/${_startDate!.day} - ${_endDate!.month}/${_endDate!.day}';
    }
    return 'Select date range';
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
        _selectedDatePreset = null;
      });
    }
  }

  void _resetFilters() {
    setState(() {
      _selectedRegion = _regions.first;
      _riskScoreRange = const RangeValues(0, 100);
      _startDate = null;
      _endDate = null;
      _selectedDatePreset = null;
    });
  }

  void _applyFilters() {
    final filters = <String, dynamic>{
      'region': _selectedRegion,
      'riskScoreRange': _riskScoreRange,
      'startDate': _startDate,
      'endDate': _endDate,
      'datePreset': _selectedDatePreset,
    };

    widget.onFiltersApplied(filters);
    Navigator.pop(context);
  }
}
