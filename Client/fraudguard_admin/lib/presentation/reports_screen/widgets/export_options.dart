import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class ExportOptions extends StatefulWidget {
  final String reportType;
  final DateTimeRange? dateRange;

  const ExportOptions({
    Key? key,
    required this.reportType,
    required this.dateRange,
  }) : super(key: key);

  @override
  State<ExportOptions> createState() => _ExportOptionsState();
}

class _ExportOptionsState extends State<ExportOptions> {
  bool _isExporting = false;
  String _exportProgress = '';

  @override
  Widget build(BuildContext context) {
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
            'Export Options',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 2.h),
          if (_isExporting) ...[
            _buildExportProgress(),
            SizedBox(height: 2.h),
          ],
          Row(
            children: [
              Expanded(
                child: _buildExportButton(
                  label: 'Export PDF',
                  icon: 'picture_as_pdf',
                  onTap: () => _exportPDF(),
                  color: AppTheme.lightTheme.colorScheme.error,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: _buildExportButton(
                  label: 'Export CSV',
                  icon: 'table_chart',
                  onTap: () => _exportCSV(),
                  color: AppTheme.successColor(true),
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showPDFPreview(),
                  icon: CustomIconWidget(
                    iconName: 'preview',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 20,
                  ),
                  label: Text('PDF Preview'),
                  style: AppTheme.lightTheme.outlinedButtonTheme.style,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showCSVPreview(),
                  icon: CustomIconWidget(
                    iconName: 'view_list',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 20,
                  ),
                  label: Text('CSV Preview'),
                  style: AppTheme.lightTheme.outlinedButtonTheme.style,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExportButton({
    required String label,
    required String icon,
    required VoidCallback onTap,
    required Color color,
  }) {
    return ElevatedButton.icon(
      onPressed: _isExporting ? null : onTap,
      icon: CustomIconWidget(
        iconName: icon,
        color: _isExporting
            ? AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.5)
            : AppTheme.lightTheme.colorScheme.onPrimary,
        size: 20,
      ),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            _isExporting ? AppTheme.lightTheme.colorScheme.surface : color,
        foregroundColor: _isExporting
            ? AppTheme.lightTheme.colorScheme.onSurface.withValues(alpha: 0.5)
            : AppTheme.lightTheme.colorScheme.onPrimary,
        padding: EdgeInsets.symmetric(vertical: 1.5.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Widget _buildExportProgress() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _exportProgress,
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.lightTheme.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              GestureDetector(
                onTap: _cancelExport,
                child: CustomIconWidget(
                  iconName: 'close',
                  color: AppTheme.lightTheme.colorScheme.error,
                  size: 20,
                ),
              ),
            ],
          ),
          SizedBox(height: 1.h),
          LinearProgressIndicator(
            backgroundColor: AppTheme.lightTheme.dividerColor,
            valueColor: AlwaysStoppedAnimation<Color>(
              AppTheme.lightTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _exportPDF() async {
    setState(() {
      _isExporting = true;
      _exportProgress = 'Generating PDF report...';
    });

    try {
      // Simulate export process
      await Future.delayed(Duration(seconds: 1));
      setState(() => _exportProgress = 'Formatting data...');

      await Future.delayed(Duration(seconds: 1));
      setState(() => _exportProgress = 'Creating PDF document...');

      await Future.delayed(Duration(seconds: 1));
      setState(() => _exportProgress = 'Finalizing export...');

      await Future.delayed(Duration(seconds: 1));

      // Generate PDF content
      final pdfContent = _generatePDFContent();
      await _downloadFile(pdfContent,
          'fraud_report_${DateTime.now().millisecondsSinceEpoch}.pdf');

      _showSuccessMessage('PDF report exported successfully');
    } catch (e) {
      _showErrorMessage('Failed to export PDF report');
    } finally {
      setState(() {
        _isExporting = false;
        _exportProgress = '';
      });
    }
  }

  Future<void> _exportCSV() async {
    setState(() {
      _isExporting = true;
      _exportProgress = 'Generating CSV report...';
    });

    try {
      // Simulate export process
      await Future.delayed(Duration(seconds: 1));
      setState(() => _exportProgress = 'Extracting data...');

      await Future.delayed(Duration(seconds: 1));
      setState(() => _exportProgress = 'Formatting CSV...');

      await Future.delayed(Duration(seconds: 1));

      // Generate CSV content
      final csvContent = _generateCSVContent();
      await _downloadFile(csvContent,
          'fraud_report_${DateTime.now().millisecondsSinceEpoch}.csv');

      _showSuccessMessage('CSV report exported successfully');
    } catch (e) {
      _showErrorMessage('Failed to export CSV report');
    } finally {
      setState(() {
        _isExporting = false;
        _exportProgress = '';
      });
    }
  }

  void _cancelExport() {
    setState(() {
      _isExporting = false;
      _exportProgress = '';
    });
    _showSuccessMessage('Export cancelled');
  }

  void _showPDFPreview() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 90.w,
          height: 70.h,
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PDF Preview',
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 24,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface
                        .withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.lightTheme.dividerColor,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'picture_as_pdf',
                          color: AppTheme.lightTheme.colorScheme.error,
                          size: 48,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'PDF Preview',
                          style: AppTheme.lightTheme.textTheme.titleMedium,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Report: ${widget.reportType}',
                          style: AppTheme.lightTheme.textTheme.bodyMedium,
                        ),
                        if (widget.dateRange != null) ...[
                          SizedBox(height: 0.5.h),
                          Text(
                            'Period: ${_formatDate(widget.dateRange!.start)} - ${_formatDate(widget.dateRange!.end)}',
                            style: AppTheme.lightTheme.textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCSVPreview() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
          width: 90.w,
          height: 70.h,
          padding: EdgeInsets.all(4.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'CSV Preview',
                    style: AppTheme.lightTheme.textTheme.titleMedium,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 24,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.surface
                        .withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppTheme.lightTheme.dividerColor,
                      width: 1,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Text(
                      _generateCSVContent(),
                      style:
                          AppTheme.dataTextStyle(isLight: true, fontSize: 12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _generatePDFContent() {
    return '''
FRAUD DETECTION REPORT
Report Type: ${widget.reportType}
Generated: ${DateTime.now().toString()}
${widget.dateRange != null ? 'Period: ${_formatDate(widget.dateRange!.start)} - ${_formatDate(widget.dateRange!.end)}' : ''}

SUMMARY
Total Investigations: 1,247
Resolution Rate: 94.2%
False Positive Rate: 8.3%
Average Response Time: 2.4 hours

DETAILED FINDINGS
- High-risk users identified: 156
- Medium-risk users: 342
- Low-risk users: 749
- Cleared cases: 1,174
- Pending investigations: 73
''';
  }

  String _generateCSVContent() {
    return '''User ID,Risk Score,Status,Date,Investigation Type,Resolution
USR-2024-001,95,Flagged,07/16/2025,Identity Verification,Pending
USR-2024-002,78,Under Review,07/16/2025,Document Analysis,In Progress
USR-2024-003,45,Cleared,07/15/2025,Behavioral Analysis,Resolved
USR-2024-004,89,Flagged,07/15/2025,Network Analysis,Pending
USR-2024-005,62,Monitoring,07/14/2025,Transaction Review,Ongoing
USR-2024-006,91,Flagged,07/14/2025,Identity Verification,Escalated
USR-2024-007,34,Cleared,07/13/2025,Routine Check,Resolved
USR-2024-008,76,Under Review,07/13/2025,Document Analysis,In Progress''';
  }

  Future<void> _downloadFile(String content, String filename) async {
    // Simulate file download
    await Future.delayed(Duration(milliseconds: 500));
  }

  String _formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
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

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
