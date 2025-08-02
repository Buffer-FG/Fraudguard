// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sizer/sizer.dart';

// import '../../../../core/app_export.dart';

// class ProfileInfoCard extends StatelessWidget {
//   final Map<String, dynamic> userProfile;

//   const ProfileInfoCard({
//     Key? key,
//     required this.userProfile,
//   }) : super(key: key);

//   void _copyToClipboard(BuildContext context, String text) {
//     Clipboard.setData(ClipboardData(text: text));
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('Copied to clipboard'),
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   String _getInitials(String name) {
//     List<String> nameParts = name.split(' ');
//     if (nameParts.length >= 2) {
//       return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
//     }
//     return name.isNotEmpty ? name[0].toUpperCase() : 'A';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(6.w),
//         child: Column(
//           children: [
//             // Avatar Section
//             Container(
//               width: 20.w,
//               height: 20.w,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
//                 border: Border.all(
//                   color: AppTheme.lightTheme.primaryColor,
//                   width: 2,
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   _getInitials(userProfile['name'] as String? ?? 'Admin'),
//                   style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
//                     color: AppTheme.lightTheme.primaryColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 3.h),

//             // Name
//             Text(
//               userProfile['name'] as String? ?? 'Administrator',
//               style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
//                 fontWeight: FontWeight.w600,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 1.h),

//             // Email with copy functionality
//             GestureDetector(
//               onLongPress: () => _copyToClipboard(
//                 context,
//                 userProfile['email'] as String? ?? '',
//               ),
//               child: Container(
//                 padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
//                 decoration: BoxDecoration(
//                   color: AppTheme.lightTheme.colorScheme.surface,
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     color: AppTheme.lightTheme.dividerColor,
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     CustomIconWidget(
//                       iconName: 'email',
//                       color: AppTheme.lightTheme.colorScheme.primary,
//                       size: 16,
//                     ),
//                     SizedBox(width: 2.w),
//                     Flexible(
//                       child: Text(
//                         userProfile['email'] as String? ?? 'admin@bank.com',
//                         style:
//                             AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
//                           color: AppTheme.lightTheme.colorScheme.primary,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 2.h),

//             // Employee ID with copy functionality
//             _buildInfoRow(
//               context,
//               'Employee ID',
//               userProfile['employeeId'] as String? ?? 'EMP001',
//               'badge',
//               canCopy: true,
//             ),
//             SizedBox(height: 1.h),

//             // Bank Name
//             _buildInfoRow(
//               context,
//               'Bank',
//               userProfile['bankName'] as String? ?? 'Banking Institution',
//               'account_balance',
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(
//     BuildContext context,
//     String label,
//     String value,
//     String iconName, {
//     bool canCopy = false,
//   }) {
//     return GestureDetector(
//       onLongPress: canCopy ? () => _copyToClipboard(context, value) : null,
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
//         decoration: BoxDecoration(
//           color: AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.5),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           children: [
//             CustomIconWidget(
//               iconName: iconName,
//               color: AppTheme.lightTheme.colorScheme.secondary,
//               size: 20,
//             ),
//             SizedBox(width: 3.w),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     label,
//                     style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
//                       color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//                     ),
//                   ),
//                   SizedBox(height: 0.5.h),
//                   Text(
//                     value,
//                     style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             if (canCopy)
//               CustomIconWidget(
//                 iconName: 'content_copy',
//                 color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//                 size: 16,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class ProfileInfoCard extends StatelessWidget {
  final Map<String, dynamic> userProfile;

  const ProfileInfoCard({
    Key? key,
    required this.userProfile,
  }) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  String _getInitials(String name) {
    List<String> nameParts = name.split(' ');
    if (nameParts.length >= 2) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : 'A';
  }

  @override
  Widget build(BuildContext context) {
    final name = userProfile['name'] ?? 'Administrator';
    final email = userProfile['email'] ?? 'admin@bank.com';
    final empId = userProfile['empId'] ?? 'EMP001';
    final bankName = userProfile['bankName'] ?? 'UCO Bank'; // Optional fallback
    final department =
        userProfile['department'] ?? 'Department'; // Optional fallback

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(6.w),
        child: Column(
          children: [
            // Avatar Section
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.lightTheme.primaryColor.withOpacity(0.1),
                border: Border.all(
                  color: AppTheme.lightTheme.primaryColor,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  _getInitials(name),
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.lightTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 3.h),

            // Name
            Text(
              name,
              style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 1.h),

            // Email
            GestureDetector(
              onLongPress: () => _copyToClipboard(context, email),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppTheme.lightTheme.dividerColor,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'email',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 16,
                    ),
                    SizedBox(width: 2.w),
                    Flexible(
                      child: Text(
                        email,
                        style:
                            AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 2.h),

            // Employee ID
            _buildInfoRow(
              context,
              'Employee ID',
              empId,
              'badge',
              canCopy: true,
            ),
            SizedBox(height: 1.h),

            // Bank Name (optional, fallback if null)
            _buildInfoRow(
              context,
              'Bank',
              bankName,
              'account_balance',
            ),

            // Department (optional, if stored)
            // _buildInfoRow(
            //   context,
            //   'Department',
            //   department,
            //   'work',
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    String label,
    String value,
    String iconName, {
    bool canCopy = false,
  }) {
    return GestureDetector(
      onLongPress: canCopy ? () => _copyToClipboard(context, value) : null,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            CustomIconWidget(
              iconName: iconName,
              color: AppTheme.lightTheme.colorScheme.secondary,
              size: 20,
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    value,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (canCopy)
              CustomIconWidget(
                iconName: 'content_copy',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 16,
              ),
          ],
        ),
      ),
    );
  }
}
