// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sizer/sizer.dart';

// import '../../core/app_export.dart';
// import './widgets/biometric_auth_widget.dart';
// import './widgets/login_form_widget.dart';
// import './widgets/security_indicators_widget.dart';
// import './widgets/two_factor_auth_widget.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _isLoading = false;
//   bool _showBiometric = false;
//   bool _showTwoFactor = false;
//   String _errorMessage = '';

//   // Mock credentials for different user types
//   final Map<String, Map<String, String>> _mockCredentials = {
//     'officer@fraudguard.com': {
//       'password': 'officer123',
//       'role': 'Fraud Detection Officer',
//     },
//     'admin@fraudguard.com': {
//       'password': 'admin123',
//       'role': 'Bank Security Admin',
//     },
//     'compliance@fraudguard.com': {
//       'password': 'compliance123',
//       'role': 'Compliance Officer',
//     },
//   };

//   @override
//   void initState() {
//     super.initState();
//     // Set status bar style for login screen
//     SystemChrome.setSystemUIOverlayStyle(
//       SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         statusBarIconBrightness: Brightness.dark,
//         systemNavigationBarColor: AppTheme.lightTheme.scaffoldBackgroundColor,
//         systemNavigationBarIconBrightness: Brightness.dark,
//       ),
//     );
//   }

//   Future<void> _handleLogin(String email, String password, String role) async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = '';
//     });

//     try {
//       // Simulate network delay
//       await Future.delayed(const Duration(seconds: 2));

//       // Validate credentials
//       if (_mockCredentials.containsKey(email.toLowerCase())) {
//         final userCredentials = _mockCredentials[email.toLowerCase()]!;

//         if (userCredentials['password'] == password &&
//             userCredentials['role'] == role) {
//           // Successful login - show 2FA
//           setState(() {
//             _isLoading = false;
//             _showTwoFactor = true;
//           });
//         } else {
//           // Invalid credentials
//           setState(() {
//             _isLoading = false;
//             _errorMessage =
//                 'Invalid credentials. Please check your email, password, and role selection.';
//           });
//           HapticFeedback.heavyImpact();
//         }
//       } else {
//         // User not found
//         setState(() {
//           _isLoading = false;
//           _errorMessage =
//               'Account not found. Please contact your system administrator.';
//         });
//         HapticFeedback.heavyImpact();
//       }
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _errorMessage =
//             'Network security error. Please check your connection and try again.';
//       });
//       HapticFeedback.heavyImpact();
//     }
//   }

//   Future<void> _handleTwoFactorAuth(String code) async {
//     // Simulate 2FA verification
//     await Future.delayed(const Duration(seconds: 1));

//     if (code == '123456') {
//       setState(() {
//         _showTwoFactor = false;
//         // _showBiometric = true;
//       });
//     } else {
//       setState(() {
//         _showTwoFactor = false;
//         _errorMessage = 'Invalid verification code. Please try again.';
//       });
//       HapticFeedback.heavyImpact();
//     }
//   }

//   // void _handleBiometricSuccess() {
//   //   HapticFeedback.lightImpact();
//   //   Navigator.pushReplacementNamed(context, '/dashboard-screen');
//   // }

//   // void _handleBiometricCancel() {
//   //   setState(() {
//   //     _showBiometric = false;
//   //   });
//   // }

//   void _handleTwoFactorCancel() {
//     setState(() {
//       _showTwoFactor = false;
//     });
//   }

//   void _handleResendCode() {
//     // Simulate resending code
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Verification code sent to your registered device'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
//       body: SafeArea(
//         child: Stack(
//           children: [
//             // Main Login Content
//             SingleChildScrollView(
//               padding: EdgeInsets.symmetric(horizontal: 6.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SizedBox(height: 8.h),

//                   // Bank Logo with Fraud Detection Badge
//                   Center(
//                     child: Column(
//                       children: [
//                         Container(
//                           width: 24.w,
//                           height: 24.w,
//                           decoration: BoxDecoration(
//                             color: AppTheme.lightTheme.colorScheme.primary,
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: AppTheme.lightTheme.colorScheme.primary
//                                     .withValues(alpha: 0.3),
//                                 blurRadius: 20,
//                                 offset: const Offset(0, 8),
//                               ),
//                             ],
//                           ),
//                           child: Center(
//                             child: CustomIconWidget(
//                               iconName: 'security',
//                               color: AppTheme.lightTheme.colorScheme.onPrimary,
//                               size: 12.w,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 2.h),
//                         Text(
//                           'FraudGuard',
//                           style: AppTheme.lightTheme.textTheme.headlineMedium
//                               ?.copyWith(
//                             fontWeight: FontWeight.w700,
//                             color: AppTheme.lightTheme.colorScheme.primary,
//                           ),
//                         ),
//                         Text(
//                           'Admin Dashboard',
//                           style:
//                               AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
//                             color: AppTheme
//                                 .lightTheme.colorScheme.onSurfaceVariant,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(height: 6.h),

//                   // Security Indicators
//                   const SecurityIndicatorsWidget(),

//                   SizedBox(height: 4.h),

//                   // Error Message
//                   _errorMessage.isNotEmpty
//                       ? Container(
//                           padding: EdgeInsets.all(3.w),
//                           margin: EdgeInsets.only(bottom: 2.h),
//                           decoration: BoxDecoration(
//                             color: AppTheme.lightTheme.colorScheme.error
//                                 .withValues(alpha: 0.1),
//                             borderRadius: BorderRadius.circular(8),
//                             border: Border.all(
//                               color: AppTheme.lightTheme.colorScheme.error
//                                   .withValues(alpha: 0.3),
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               CustomIconWidget(
//                                 iconName: 'error',
//                                 color: AppTheme.lightTheme.colorScheme.error,
//                                 size: 5.w,
//                               ),
//                               SizedBox(width: 2.w),
//                               Expanded(
//                                 child: Text(
//                                   _errorMessage,
//                                   style: AppTheme.lightTheme.textTheme.bodySmall
//                                       ?.copyWith(
//                                     color:
//                                         AppTheme.lightTheme.colorScheme.error,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       : const SizedBox.shrink(),

//                   // Login Form
//                   LoginFormWidget(
//                     onLogin: _handleLogin,
//                     isLoading: _isLoading,
//                   ),

//                   SizedBox(height: 4.h),

//                   // Mock Credentials Info
//                   Container(
//                     padding: EdgeInsets.all(3.w),
//                     decoration: BoxDecoration(
//                       color: AppTheme.lightTheme.colorScheme.primary
//                           .withValues(alpha: 0.05),
//                       borderRadius: BorderRadius.circular(8),
//                       border: Border.all(
//                         color: AppTheme.lightTheme.colorScheme.primary
//                             .withValues(alpha: 0.2),
//                       ),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             CustomIconWidget(
//                               iconName: 'info',
//                               color: AppTheme.lightTheme.colorScheme.primary,
//                               size: 4.w,
//                             ),
//                             SizedBox(width: 2.w),
//                             Text(
//                               'Demo Credentials',
//                               style: AppTheme.lightTheme.textTheme.titleSmall
//                                   ?.copyWith(
//                                 color: AppTheme.lightTheme.colorScheme.primary,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ],
//                         ),
//                         SizedBox(height: 1.h),
//                         Text(
//                           'Officer: officer@fraudguard.com / officer123\nAdmin: admin@fraudguard.com / admin123\nCompliance: compliance@fraudguard.com / compliance123',
//                           style:
//                               AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
//                             color: AppTheme
//                                 .lightTheme.colorScheme.onSurfaceVariant,
//                             fontFamily: 'monospace',
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   SizedBox(height: 4.h),
//                 ],
//               ),
//             ),

//             // Two-Factor Authentication Modal
//             if (_showTwoFactor)
//               Positioned.fill(
//                 child: Container(
//                   color: Colors.black.withValues(alpha: 0.5),
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: TwoFactorAuthWidget(
//                       onCodeSubmit: _handleTwoFactorAuth,
//                       onCancel: _handleTwoFactorCancel,
//                       onResendCode: _handleResendCode,
//                     ),
//                   ),
//                 ),
//               ),

//             // Biometric Authentication Modal
//             if (_showBiometric)
//               Positioned.fill(
//                 child: Container(
//                   color: Colors.black.withValues(alpha: 0.5),
//                   child: Align(
//                     alignment: Alignment.bottomCenter,
//                     child: BiometricAuthWidget(
//                       onBiometricSuccess: _handleBiometricSuccess,
//                       onBiometricCancel: _handleBiometricCancel,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
