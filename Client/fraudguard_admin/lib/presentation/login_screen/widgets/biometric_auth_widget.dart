// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sizer/sizer.dart';

// import '../../../core/app_export.dart';

// class BiometricAuthWidget extends StatefulWidget {
//   final VoidCallback onBiometricSuccess;
//   final VoidCallback onBiometricCancel;

//   const BiometricAuthWidget({
//     Key? key,
//     required this.onBiometricSuccess,
//     required this.onBiometricCancel,
//   }) : super(key: key);

//   @override
//   State<BiometricAuthWidget> createState() => _BiometricAuthWidgetState();
// }

// class _BiometricAuthWidgetState extends State<BiometricAuthWidget>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;
//   bool _isAuthenticating = false;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 1500),
//       vsync: this,
//     );
//     _scaleAnimation = Tween<double>(
//       begin: 1.0,
//       end: 1.2,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Curves.easeInOut,
//     ));

//     _animationController.repeat(reverse: true);
//     _startBiometricAuth();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   Future<void> _startBiometricAuth() async {
//     setState(() {
//       _isAuthenticating = true;
//     });

//     try {
//       // Simulate biometric authentication delay
//       await Future.delayed(const Duration(seconds: 2));

//       // Simulate successful authentication
//       HapticFeedback.lightImpact();
//       widget.onBiometricSuccess();
//     } catch (e) {
//       // Handle biometric authentication failure
//       HapticFeedback.heavyImpact();
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: const Text(
//                 'Biometric authentication failed. Please try again.'),
//             backgroundColor: AppTheme.lightTheme.colorScheme.error,
//           ),
//         );
//       }
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isAuthenticating = false;
//         });
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(6.w),
//       decoration: BoxDecoration(
//         color: AppTheme.lightTheme.colorScheme.surface,
//         borderRadius: const BorderRadius.vertical(
//           top: Radius.circular(24),
//         ),
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Handle bar
//           Container(
//             width: 12.w,
//             height: 0.5.h,
//             decoration: BoxDecoration(
//               color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
//                   .withValues(alpha: 0.3),
//               borderRadius: BorderRadius.circular(2),
//             ),
//           ),

//           SizedBox(height: 4.h),

//           // Biometric Icon with Animation
//           AnimatedBuilder(
//             animation: _scaleAnimation,
//             builder: (context, child) {
//               return Transform.scale(
//                 scale: _scaleAnimation.value,
//                 child: Container(
//                   width: 20.w,
//                   height: 20.w,
//                   decoration: BoxDecoration(
//                     color: AppTheme.lightTheme.colorScheme.primary
//                         .withValues(alpha: 0.1),
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: CustomIconWidget(
//                       iconName: 'fingerprint',
//                       color: AppTheme.lightTheme.colorScheme.primary,
//                       size: 12.w,
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),

//           SizedBox(height: 3.h),

//           // Title
//           Text(
//             'Biometric Authentication',
//             style: AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
//               fontWeight: FontWeight.w600,
//             ),
//             textAlign: TextAlign.center,
//           ),

//           SizedBox(height: 1.h),

//           // Description
//           Text(
//             _isAuthenticating
//                 ? 'Please verify your identity using Face ID or Touch ID'
//                 : 'Use your biometric authentication to securely access FraudGuard',
//             style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
//               color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//             ),
//             textAlign: TextAlign.center,
//           ),

//           SizedBox(height: 4.h),

//           // Action Buttons
//           Row(
//             children: [
//               Expanded(
//                 child: OutlinedButton(
//                   onPressed:
//                       _isAuthenticating ? null : widget.onBiometricCancel,
//                   child: Text('Cancel'),
//                 ),
//               ),
//               SizedBox(width: 4.w),
//               Expanded(
//                 child: ElevatedButton(
//                   onPressed: _isAuthenticating ? null : _startBiometricAuth,
//                   child: _isAuthenticating
//                       ? SizedBox(
//                           width: 4.w,
//                           height: 4.w,
//                           child: CircularProgressIndicator(
//                             strokeWidth: 2,
//                             valueColor: AlwaysStoppedAnimation<Color>(
//                               AppTheme.lightTheme.colorScheme.onPrimary,
//                             ),
//                           ),
//                         )
//                       : Text('Try Again'),
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 2.h),
//         ],
//       ),
//     );
//   }
// }
