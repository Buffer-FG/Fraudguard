import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GraphExportDialog extends StatefulWidget {
  final VoidCallback onExportImage;
  final VoidCallback onExportData;
  final VoidCallback onCancel;

  const GraphExportDialog({
    Key? key,
    required this.onExportImage,
    required this.onExportData,
    required this.onCancel,
  }) : super(key: key);

  @override
  State<GraphExportDialog> createState() => _GraphExportDialogState();
}

class _GraphExportDialogState extends State<GraphExportDialog> {
  String selectedFormat = 'PNG';
  String selectedDataFormat = 'CSV';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        width: 85.w,
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 3.h),
            _buildImageExportSection(),
            SizedBox(height: 3.h),
            _buildDataExportSection(),
            SizedBox(height: 4.h),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Export Graph',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        GestureDetector(
          onTap: widget.onCancel,
          child: CustomIconWidget(
            iconName: 'close',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 5.w,
          ),
        ),
      ],
    );
  }

  Widget _buildImageExportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Export as Image',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Capture the current graph view as an image file',
          style: TextStyle(
            fontSize: 11.sp,
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            _buildFormatOption('PNG', selectedFormat == 'PNG', (value) {
              setState(() => selectedFormat = value);
            }),
            SizedBox(width: 3.w),
            _buildFormatOption('JPG', selectedFormat == 'JPG', (value) {
              setState(() => selectedFormat = value);
            }),
          ],
        ),
        SizedBox(height: 2.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onExportImage,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
              padding: EdgeInsets.symmetric(vertical: 2.h),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'image',
                  color: Colors.white,
                  size: 4.w,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Export Image ($selectedFormat)',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDataExportSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Export Connection Data',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'Export node and edge data for analysis',
          style: TextStyle(
            fontSize: 11.sp,
            color: AppTheme.lightTheme.colorScheme.onSurface
                .withValues(alpha: 0.7),
          ),
        ),
        SizedBox(height: 2.h),
        Row(
          children: [
            _buildFormatOption('CSV', selectedDataFormat == 'CSV', (value) {
              setState(() => selectedDataFormat = value);
            }),
            SizedBox(width: 3.w),
            _buildFormatOption('JSON', selectedDataFormat == 'JSON', (value) {
              setState(() => selectedDataFormat = value);
            }),
          ],
        ),
        SizedBox(height: 2.h),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: widget.onExportData,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'download',
                  color: Colors.white,
                  size: 4.w,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Export Data ($selectedDataFormat)',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormatOption(
      String format, bool isSelected, Function(String) onTap) {
    return GestureDetector(
      onTap: () => onTap(format),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1)
              : AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected
                ? AppTheme.lightTheme.primaryColor
                : AppTheme.lightTheme.colorScheme.outline,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 4.w,
              height: 4.w,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.lightTheme.primaryColor
                    : Colors.transparent,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? AppTheme.lightTheme.primaryColor
                      : AppTheme.lightTheme.colorScheme.outline,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 1.5.w,
                        height: 1.5.w,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
            SizedBox(width: 2.w),
            Text(
              format,
              style: TextStyle(
                fontSize: 12.sp,
                color: isSelected
                    ? AppTheme.lightTheme.primaryColor
                    : AppTheme.lightTheme.colorScheme.onSurface,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: widget.onCancel,
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              side: BorderSide(
                color: AppTheme.lightTheme.colorScheme.outline,
                width: 1,
              ),
            ),
            child: Text(
              'Cancel',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
