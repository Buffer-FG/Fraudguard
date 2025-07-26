import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class BottomActionBar extends StatelessWidget {
  final Map<String, dynamic> userData;
  final VoidCallback? onClearFlag;
  final VoidCallback? onEscalateCase;
  final VoidCallback? onGenerateReport;

  const BottomActionBar({
    Key? key,
    required this.userData,
    this.onClearFlag,
    this.onEscalateCase,
    this.onGenerateReport,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: AppTheme.lightTheme.colorScheme.outline,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _handleClearFlag(context),
                icon: CustomIconWidget(
                  iconName: 'clear',
                  color: AppTheme.successLight,
                  size: 18,
                ),
                label: Text(
                  'Clear Flag',
                  style: TextStyle(color: AppTheme.successLight),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppTheme.successLight),
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _handleEscalateCase(context),
                icon: CustomIconWidget(
                  iconName: 'priority_high',
                  color: AppTheme.warningLight,
                  size: 18,
                ),
                label: Text(
                  'Escalate',
                  style: TextStyle(color: AppTheme.warningLight),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppTheme.warningLight),
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                ),
              ),
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () => _handleGenerateReport(context),
                icon: CustomIconWidget(
                  iconName: 'description',
                  color: AppTheme.lightTheme.colorScheme.onPrimary,
                  size: 18,
                ),
                label: const Text('Report'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleClearFlag(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Flag'),
        content: Text(
          'Are you sure you want to clear the fraud flag for ${userData['name']}? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onClearFlag?.call();
              // Fluttertoast.showToast(
              //   msg: 'Flag cleared successfully',
              //   toastLength: Toast.LENGTH_SHORT,
              //   gravity: ToastGravity.BOTTOM,
              //   backgroundColor: AppTheme.successLight,
              //   textColor: Colors.white,
              // );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Flag cleared successfully'),
                  backgroundColor: AppTheme.successLight,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.successLight,
            ),
            child: const Text('Clear Flag'),
          ),
        ],
      ),
    );
  }

  void _handleEscalateCase(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Escalate Case'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
                'Escalate case for ${userData['name']} to senior investigator?'),
            SizedBox(height: 2.h),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Escalation Reason',
                hintText: 'Enter reason for escalation...',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onEscalateCase?.call();
              // Fluttertoast.showToast(
              //   msg: 'Case escalated successfully',
              //   toastLength: Toast.LENGTH_SHORT,
              //   gravity: ToastGravity.BOTTOM,
              //   backgroundColor: AppTheme.warningLight,
              //   textColor: Colors.white,
              // );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Case escalated successfully'),
                  backgroundColor: AppTheme.warningLight,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.warningLight,
            ),
            child: const Text('Escalate'),
          ),
        ],
      ),
    );
  }

  void _handleGenerateReport(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Generate Report'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Generate investigation report for ${userData['name']}?'),
            SizedBox(height: 2.h),
            const Text('Report will include:'),
            SizedBox(height: 1.h),
            Text('• Personal details and risk assessment',
                style: AppTheme.lightTheme.textTheme.bodySmall),
            Text('• Risk factors and flagging reasons',
                style: AppTheme.lightTheme.textTheme.bodySmall),
            Text('• Activity timeline and patterns',
                style: AppTheme.lightTheme.textTheme.bodySmall),
            Text('• Investigation notes and actions',
                style: AppTheme.lightTheme.textTheme.bodySmall),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              onGenerateReport?.call();
              // Fluttertoast.showToast(
              //   msg: 'Report generated successfully',
              //   toastLength: Toast.LENGTH_SHORT,
              //   gravity: ToastGravity.BOTTOM,
              //   backgroundColor: AppTheme.lightTheme.colorScheme.primary,
              //   textColor: Colors.white,
              // );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Report generated successfully'),
                  backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                ),
              );
            },
            child: const Text('Generate'),
          ),
        ],
      ),
    );
  }
}
