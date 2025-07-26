import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/date_range_picker.dart';
import './widgets/export_options.dart';
import './widgets/recent_reports_section.dart';
import './widgets/report_preview_section.dart';
import './widgets/report_type_selector.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({Key? key}) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _selectedReportType = 'Daily Summary';
  DateTimeRange? _selectedDateRange;
  int _currentBottomNavIndex = 3; // Reports tab index

  @override
  void initState() {
    super.initState();
    // Set default date range to today
    final now = DateTime.now();
    _selectedDateRange = DateTimeRange(
      start: DateTime(now.year, now.month, now.day),
      end: DateTime(now.year, now.month, now.day, 23, 59, 59),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPageHeader(),
              SizedBox(height: 2.h),
              ReportTypeSelector(
                selectedType: _selectedReportType,
                onTypeSelected: (type) {
                  setState(() {
                    _selectedReportType = type;
                    // Reset date range when changing report type
                    if (type == 'Custom Range') {
                      _selectedDateRange = null;
                    } else {
                      _setDefaultDateRange(type);
                    }
                  });
                },
              ),
              SizedBox(height: 2.h),
              DateRangePicker(
                selectedRange: _selectedDateRange,
                onRangeSelected: (range) {
                  setState(() {
                    _selectedDateRange = range;
                  });
                },
              ),
              SizedBox(height: 2.h),
              ReportPreviewSection(
                reportType: _selectedReportType,
                dateRange: _selectedDateRange,
              ),
              SizedBox(height: 2.h),
              ExportOptions(
                reportType: _selectedReportType,
                dateRange: _selectedDateRange,
              ),
              SizedBox(height: 2.h),
              RecentReportsSection(),
              SizedBox(height: 10.h), // Extra space for FAB
            ],
          ),
        ),
      ),
      floatingActionButton: _buildScheduleReportFAB(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text(
        'Reports',
        style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
      ),
      backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
      elevation: AppTheme.lightTheme.appBarTheme.elevation,
      actions: [
        IconButton(
          onPressed: () => _showReportTemplates(),
          icon: CustomIconWidget(
            iconName: 'help_outline',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
          tooltip: 'Report Templates',
        ),
        IconButton(
          onPressed: () => _showReportSettings(),
          icon: CustomIconWidget(
            iconName: 'settings',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
          tooltip: 'Report Settings',
        ),
      ],
    );
  }

  Widget _buildPageHeader() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
            AppTheme.lightTheme.primaryColor.withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: CustomIconWidget(
              iconName: 'assessment',
              color: AppTheme.lightTheme.primaryColor,
              size: 32,
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Fraud Analysis Reports',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 0.5.h),
                Text(
                  'Generate comprehensive reports with export capabilities for compliance and documentation',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface
                        .withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScheduleReportFAB() {
    return FloatingActionButton.extended(
      onPressed: () => _showScheduleReportDialog(),
      backgroundColor: AppTheme.lightTheme.primaryColor,
      foregroundColor: AppTheme.lightTheme.colorScheme.onPrimary,
      icon: CustomIconWidget(
        iconName: 'schedule',
        color: AppTheme.lightTheme.colorScheme.onPrimary,
        size: 24,
      ),
      label: Text(
        'Schedule Report',
        style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
          color: AppTheme.lightTheme.colorScheme.onPrimary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentBottomNavIndex,
      onTap: (index) {
        setState(() {
          _currentBottomNavIndex = index;
        });
        _navigateToScreen(index);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.backgroundColor,
      selectedItemColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.selectedItemColor,
      unselectedItemColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.unselectedItemColor,
      elevation: AppTheme.lightTheme.bottomNavigationBarTheme.elevation,
      items: [
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'dashboard',
            color: _currentBottomNavIndex == 0
                ? AppTheme
                    .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                : AppTheme
                    .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
            size: 24,
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'flag',
            color: _currentBottomNavIndex == 1
                ? AppTheme
                    .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                : AppTheme
                    .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
            size: 24,
          ),
          label: 'Flagged Users',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'account_tree',
            color: _currentBottomNavIndex == 2
                ? AppTheme
                    .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                : AppTheme
                    .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
            size: 24,
          ),
          label: 'Network Graph',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'assessment',
            color: _currentBottomNavIndex == 3
                ? AppTheme
                    .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                : AppTheme
                    .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
            size: 24,
          ),
          label: 'Reports',
        ),
      ],
    );
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard-screen');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/flagged-users-list-screen');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/network-graph-screen');
        break;
      case 3:
        // Already on reports screen
        break;
    }
  }

  void _setDefaultDateRange(String reportType) {
    final now = DateTime.now();
    switch (reportType) {
      case 'Daily Summary':
        _selectedDateRange = DateTimeRange(
          start: DateTime(now.year, now.month, now.day),
          end: DateTime(now.year, now.month, now.day, 23, 59, 59),
        );
        break;
      case 'Weekly Analysis':
        _selectedDateRange = DateTimeRange(
          start: now.subtract(Duration(days: 7)),
          end: now,
        );
        break;
      case 'Monthly Trends':
        _selectedDateRange = DateTimeRange(
          start: now.subtract(Duration(days: 30)),
          end: now,
        );
        break;
      case 'Compliance Audit':
        _selectedDateRange = DateTimeRange(
          start: now.subtract(Duration(days: 90)),
          end: now,
        );
        break;
    }
  }

  void _showScheduleReportDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Schedule Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Set up automated report generation with notification preferences.'),
            SizedBox(height: 2.h),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Frequency',
                border: OutlineInputBorder(),
              ),
              items: ['Daily', 'Weekly', 'Monthly', 'Quarterly']
                  .map((freq) => DropdownMenuItem(
                        value: freq,
                        child: Text(freq),
                      ))
                  .toList(),
              onChanged: (value) {},
            ),
            SizedBox(height: 1.h),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Email Recipients',
                border: OutlineInputBorder(),
                hintText: 'Enter email addresses',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage('Report scheduled successfully');
            },
            child: Text('Schedule'),
          ),
        ],
      ),
    );
  }

  void _showReportTemplates() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Report Templates'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Available report templates:'),
            SizedBox(height: 1.h),
            _buildTemplateItem(
                'Executive Summary', 'High-level fraud overview'),
            _buildTemplateItem(
                'Detailed Analysis', 'Comprehensive investigation report'),
            _buildTemplateItem(
                'Compliance Report', 'Regulatory compliance documentation'),
            _buildTemplateItem('Risk Assessment', 'Risk scoring and analysis'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildTemplateItem(String title, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.lightTheme.textTheme.titleSmall,
          ),
          Text(
            description,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurface
                  .withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  void _showReportSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Report Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: Text('Include Charts'),
              subtitle: Text('Add visual charts to reports'),
              value: true,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: Text('Auto-Export'),
              subtitle: Text('Automatically export after generation'),
              value: false,
              onChanged: (value) {},
            ),
            SwitchListTile(
              title: Text('Email Notifications'),
              subtitle: Text('Send email when reports are ready'),
              value: true,
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessMessage('Settings saved successfully');
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.successColor(true),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
