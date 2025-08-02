import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ProfileSettingsList extends StatefulWidget {
  final VoidCallback onLogout;

  const ProfileSettingsList({
    Key? key,
    required this.onLogout,
  }) : super(key: key);

  @override
  State<ProfileSettingsList> createState() => _ProfileSettingsListState();
}

class _ProfileSettingsListState extends State<ProfileSettingsList> {
  bool _biometricEnabled = false;
  bool _notificationsEnabled = true;

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Logout',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Text(
            'Are you sure you want to logout? You will need to sign in again to access your account.',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onLogout();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.lightTheme.colorScheme.error,
                foregroundColor: AppTheme.lightTheme.colorScheme.onError,
              ),
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  void _showComingSoonDialog(String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Coming Soon',
            style: AppTheme.lightTheme.textTheme.titleLarge,
          ),
          content: Text(
            '$feature will be available in future updates with enterprise integration.',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Account Settings Section
        _buildSectionHeader('Account Settings'),
        _buildSettingsTile(
          iconName: 'settings',
          title: 'Account Settings',
          subtitle: 'Manage your account preferences',
          onTap: () => _showComingSoonDialog('Account Settings'),
          trailing: CustomIconWidget(
            iconName: 'chevron_right',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 20,
          ),
        ),
        _buildSettingsTile(
          iconName: 'lock',
          title: 'Change Password',
          subtitle: 'Update your login credentials',
          onTap: () => _showComingSoonDialog('Change Password'),
          trailing: CustomIconWidget(
            iconName: 'chevron_right',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 20,
          ),
        ),

        SizedBox(height: 2.h),

        // Security Section
        _buildSectionHeader('Security'),
        _buildSettingsTile(
          iconName: 'fingerprint',
          title: 'Biometric Authentication',
          subtitle: 'Use fingerprint or face recognition',
          trailing: Switch(
            value: _biometricEnabled,
            onChanged: (value) {
              setState(() {
                _biometricEnabled = value;
              });
            },
          ),
        ),

        SizedBox(height: 2.h),

        // Notifications Section
        _buildSectionHeader('Notifications'),
        _buildSettingsTile(
          iconName: 'notifications',
          title: 'Case Alerts',
          subtitle: 'Receive notifications for new fraud cases',
          trailing: Switch(
            value: _notificationsEnabled,
            onChanged: (value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
        ),

        SizedBox(height: 2.h),

        // Support Section
        _buildSectionHeader('Support'),
        _buildSettingsTile(
          iconName: 'help',
          title: 'Help & Support',
          subtitle: 'Get help and contact support',
          onTap: () => _showComingSoonDialog('Help & Support'),
          trailing: CustomIconWidget(
            iconName: 'chevron_right',
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            size: 20,
          ),
        ),

        SizedBox(height: 4.h),

        // Logout Button
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: ElevatedButton(
            onPressed: _showLogoutConfirmation,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.lightTheme.colorScheme.error,
              foregroundColor: AppTheme.lightTheme.colorScheme.onError,
              padding: EdgeInsets.symmetric(vertical: 2.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'logout',
                  color: AppTheme.lightTheme.colorScheme.onError,
                  size: 20,
                ),
                SizedBox(width: 2.w),
                Text(
                  'Logout',
                  style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onError,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: 2.h),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Text(
        title,
        style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
          color: AppTheme.lightTheme.colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required String iconName,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
    Widget? trailing,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.dividerColor.withValues(alpha: 0.5),
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color:
                AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: CustomIconWidget(
            iconName: iconName,
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
        trailing: trailing,
        contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      ),
    );
  }
}
