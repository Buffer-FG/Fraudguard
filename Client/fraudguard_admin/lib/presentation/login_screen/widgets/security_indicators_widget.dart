// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// import '../../../core/app_export.dart';

// class SecurityIndicatorsWidget extends StatelessWidget {
//   final bool isSecureConnection;
//   final bool isCertificatePinned;

//   const SecurityIndicatorsWidget({
//     Key? key,
//     this.isSecureConnection = true,
//     this.isCertificatePinned = true,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
//       decoration: BoxDecoration(
//         color: AppTheme.lightTheme.colorScheme.surface,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
//         ),
//       ),
//       child: Column(
//         children: [
//           // Security Header
//           Row(
//             children: [
//               CustomIconWidget(
//                 iconName: 'shield',
//                 color: AppTheme.successColor(true),
//                 size: 5.w,
//               ),
//               SizedBox(width: 2.w),
//               Text(
//                 'Security Status',
//                 style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 2.h),

//           // Security Indicators
//           Column(
//             children: [
//               _buildSecurityIndicator(
//                 icon: 'https',
//                 title: 'Secure Connection',
//                 subtitle: 'TLS 1.3 Encrypted',
//                 isActive: isSecureConnection,
//               ),
//               SizedBox(height: 1.h),
//               _buildSecurityIndicator(
//                 icon: 'verified',
//                 title: 'Certificate Pinning',
//                 subtitle: 'API Security Verified',
//                 isActive: isCertificatePinned,
//               ),
//               SizedBox(height: 1.h),
//               _buildSecurityIndicator(
//                 icon: 'policy',
//                 title: 'SOX Compliant',
//                 subtitle: 'Financial Data Protected',
//                 isActive: true,
//               ),
//               SizedBox(height: 1.h),
//               _buildSecurityIndicator(
//                 icon: 'gpp_good',
//                 title: 'PCI DSS Certified',
//                 subtitle: 'Payment Security Standard',
//                 isActive: true,
//               ),
//             ],
//           ),

//           SizedBox(height: 2.h),

//           // Trust Badges
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildTrustBadge('Bank Grade\nSecurity', 'account_balance'),
//               _buildTrustBadge('GDPR\nCompliant', 'privacy_tip'),
//               _buildTrustBadge('99.9%\nUptime', 'trending_up'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSecurityIndicator({
//     required String icon,
//     required String title,
//     required String subtitle,
//     required bool isActive,
//   }) {
//     return Row(
//       children: [
//         Container(
//           width: 8.w,
//           height: 8.w,
//           decoration: BoxDecoration(
//             color: isActive
//                 ? AppTheme.successColor(true).withValues(alpha: 0.1)
//                 : AppTheme.lightTheme.colorScheme.error.withValues(alpha: 0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Center(
//             child: CustomIconWidget(
//               iconName: icon,
//               color: isActive
//                   ? AppTheme.successColor(true)
//                   : AppTheme.lightTheme.colorScheme.error,
//               size: 4.w,
//             ),
//           ),
//         ),
//         SizedBox(width: 3.w),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Text(
//                 subtitle,
//                 style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
//                   color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         CustomIconWidget(
//           iconName: isActive ? 'check_circle' : 'error',
//           color: isActive
//               ? AppTheme.successColor(true)
//               : AppTheme.lightTheme.colorScheme.error,
//           size: 4.w,
//         ),
//       ],
//     );
//   }

//   Widget _buildTrustBadge(String label, String iconName) {
//     return Column(
//       children: [
//         Container(
//           width: 12.w,
//           height: 12.w,
//           decoration: BoxDecoration(
//             color:
//                 AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Center(
//             child: CustomIconWidget(
//               iconName: iconName,
//               color: AppTheme.lightTheme.colorScheme.primary,
//               size: 6.w,
//             ),
//           ),
//         ),
//         SizedBox(height: 1.h),
//         Text(
//           label,
//           style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
//             fontWeight: FontWeight.w500,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }
// }
