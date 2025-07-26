import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class PersonalDetailsTab extends StatelessWidget {
  final Map<String, dynamic> userData;

  const PersonalDetailsTab({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          _buildExpandableCard(
            'Address Information',
            'location_on',
            [
              _buildDetailRow(
                  'Street Address', userData['address']['street'] as String),
              _buildDetailRow('City', userData['address']['city'] as String),
              _buildDetailRow('State', userData['address']['state'] as String),
              _buildDetailRow(
                  'ZIP Code', userData['address']['zipCode'] as String),
              _buildDetailRow(
                  'Country', userData['address']['country'] as String),
            ],
          ),
          SizedBox(height: 2.h),
          _buildExpandableCard(
            'Account Information',
            'account_balance',
            [
              _buildDetailRow(
                  'Account Type', userData['accountType'] as String),
              _buildDetailRow(
                  'Account Number', userData['accountNumber'] as String),
              _buildDetailRow('Opening Date',
                  _formatDate(userData['accountOpeningDate'] as String)),
              _buildDetailRow('Last Login',
                  _formatDateTime(userData['lastLogin'] as String)),
              _buildDetailRow('Login Count', userData['loginCount'].toString()),
            ],
          ),
          SizedBox(height: 2.h),
          _buildExpandableCard(
            'Verification Status',
            'verified_user',
            [
              _buildVerificationRow(
                  'Email Verified', userData['emailVerified'] as bool),
              _buildVerificationRow(
                  'Phone Verified', userData['phoneVerified'] as bool),
              _buildVerificationRow(
                  'Identity Verified', userData['identityVerified'] as bool),
              _buildVerificationRow(
                  'Address Verified', userData['addressVerified'] as bool),
              _buildDetailRow('KYC Status', userData['kycStatus'] as String),
            ],
          ),
          SizedBox(height: 2.h),
          _buildExpandableCard(
            'Device Information',
            'devices',
            [
              _buildDetailRow(
                  'Primary Device', userData['primaryDevice'] as String),
              _buildDetailRow(
                  'Device Count', userData['deviceCount'].toString()),
              _buildDetailRow(
                  'Last IP Address', userData['lastIpAddress'] as String),
              _buildDetailRow('Location', userData['lastLocation'] as String),
              _buildDetailRow('Browser', userData['browserInfo'] as String),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableCard(
      String title, String iconName, List<Widget> children) {
    return Card(
      child: ExpansionTile(
        leading: CustomIconWidget(
          iconName: iconName,
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 24,
        ),
        title: Text(
          title,
          style: AppTheme.lightTheme.textTheme.titleMedium,
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 35.w,
            child: Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerificationRow(String label, bool isVerified) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 35.w,
            child: Text(
              label,
              style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: isVerified ? 'check_circle' : 'cancel',
                  color: isVerified
                      ? AppTheme.successLight
                      : AppTheme.lightTheme.colorScheme.error,
                  size: 16,
                ),
                SizedBox(width: 2.w),
                Text(
                  isVerified ? 'Verified' : 'Not Verified',
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: isVerified
                        ? AppTheme.successLight
                        : AppTheme.lightTheme.colorScheme.error,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }

  String _formatDateTime(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }
}
