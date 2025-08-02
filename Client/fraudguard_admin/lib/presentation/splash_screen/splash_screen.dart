// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sizer/sizer.dart';

// import '../../core/app_export.dart';
// import './widgets/background_gradient_widget.dart';
// import './widgets/bank_logo_widget.dart';
// import './widgets/loading_indicator_widget.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _fadeController;
//   late Animation<double> _fadeAnimation;
//   bool _isInitialized = false;
//   bool _hasError = false;


//   @override
//   void initState() {
//     super.initState();
//     _setupAnimations();
//     _initializeApp();
//   }

//   void _setupAnimations() {
//     _fadeController = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     _fadeAnimation = Tween<double>(
//       begin: 1.0,
//       end: 0.0,
//     ).animate(CurvedAnimation(
//       parent: _fadeController,
//       curve: Curves.easeInOut,
//     ));
//   }

//   Future<void> _initializeApp() async {
//     try {
//       // Set system UI overlay style
//       SystemChrome.setSystemUIOverlayStyle(
//         SystemUiOverlayStyle(
//           statusBarColor: Colors.transparent,
//           statusBarIconBrightness: Brightness.dark,
//           systemNavigationBarColor: AppTheme.lightTheme.colorScheme.surface,
//           systemNavigationBarIconBrightness: Brightness.dark,
//         ),
//       );

//       // Simulate initialization tasks
//       await Future.wait([
//         _loadEmployeeData(),
//         _initializeSecureStorage(),
//         _checkAuthenticationStatus(),
//         _initializeFraudDetectionModules(),
//       ]);

//       // Minimum splash display time
//       await Future.delayed(const Duration(milliseconds: 2500));

//       setState(() {
//         _isInitialized = true;
//       });

//       // Add haptic feedback
//       HapticFeedback.lightImpact();

//       // Navigate based on authentication status
//       await _navigateToNextScreen();
//     } catch (e) {
//       setState(() {
//         _hasError = true;
//       });

//       // Show retry option after 5 seconds
//       Future.delayed(const Duration(seconds: 5), () {
//         if (mounted && _hasError) {
//           _showRetryDialog();
//         }
//       });
//     }
//   }

//   Future<void> _loadEmployeeData() async {
//     // Simulate loading employee validation data
//     await Future.delayed(const Duration(milliseconds: 800));
//     // In real implementation, this would load from secure storage or API
//   }

//   Future<void> _initializeSecureStorage() async {
//     // Simulate secure storage initialization
//     await Future.delayed(const Duration(milliseconds: 600));
//     // In real implementation, this would initialize Flutter secure storage
//   }

//   Future<void> _checkAuthenticationStatus() async {
//     // Simulate authentication status check
//     await Future.delayed(const Duration(milliseconds: 700));
//     // In real implementation, this would check stored authentication tokens
//   }

//   Future<void> _initializeFraudDetectionModules() async {
//     // Simulate fraud detection modules initialization
//     await Future.delayed(const Duration(milliseconds: 900));
//     // In real implementation, this would initialize fraud detection services
//   }

//   Future<void> _navigateToNextScreen() async {
//     await _fadeController.forward();

//     if (!mounted) return;

//     // Check if user is authenticated (mock logic)
//     final bool isAuthenticated = await _checkUserAuthentication();

//     if (isAuthenticated) {
//       Navigator.pushReplacementNamed(context, '/dashboard-screen');
//     } else {
//       // Check if user has attempted signup before
//       final bool hasAttemptedSignup = await _checkSignupAttempt();

//       if (hasAttemptedSignup) {
//         Navigator.pushReplacementNamed(context, '/admin-login-screen');
//       } else {
//         Navigator.pushReplacementNamed(context, '/admin-signup-screen');
//       }
//     }
//   }

//   Future<bool> _checkUserAuthentication() async {
//     // Mock authentication check
//     // In real implementation, this would check secure storage for valid tokens
//     return false;
//   }

//   Future<bool> _checkSignupAttempt() async {
//     // Mock signup attempt check
//     // In real implementation, this would check if user has previously attempted signup
//     return false;
//   }

//   void _showRetryDialog() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'Connection Timeout',
//             style: AppTheme.lightTheme.textTheme.titleMedium,
//           ),
//           content: Text(
//             'Unable to initialize the application. Please check your network connection and try again.',
//             style: AppTheme.lightTheme.textTheme.bodyMedium,
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 setState(() {
//                   _hasError = false;
//                   _isInitialized = false;
//                 });
//                 _initializeApp();
//               },
//               child: Text(
//                 'Retry',
//                 style: TextStyle(
//                   color: AppTheme.lightTheme.colorScheme.primary,
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _fadeController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: FadeTransition(
//           opacity: _fadeAnimation,
//           child: BackgroundGradientWidget(
//             child: _hasError ? _buildErrorState() : _buildSplashContent(),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildSplashContent() {
//     return Column(
//       children: [
//         Expanded(
//           flex: 3,
//           child: Container(),
//         ),
//         Expanded(
//           flex: 4,
//           child: const BankLogoWidget(),
//         ),
//         Expanded(
//           flex: 2,
//           child: const LoadingIndicatorWidget(),
//         ),
//         Expanded(
//           flex: 1,
//           child: Container(),
//         ),
//       ],
//     );
//   }

//   Widget _buildErrorState() {
//     return Center(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 8.w),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CustomIconWidget(
//               iconName: 'error_outline',
//               color: AppTheme.lightTheme.colorScheme.error,
//               size: 15.w,
//             ),
//             SizedBox(height: 3.h),
//             Text(
//               'Initialization Failed',
//               style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
//                 color: AppTheme.lightTheme.colorScheme.error,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 2.h),
//             Text(
//               'Unable to connect to fraud detection services. Please check your network connection.',
//               style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
//                 color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 4.h),
//             Container(
//               width: 6.w,
//               height: 6.w,
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 valueColor: AlwaysStoppedAnimation<Color>(
//                   AppTheme.lightTheme.colorScheme.primary,
//                 ),
//               ),
//             ),
//             SizedBox(height: 2.h),
//             Text(
//               'Retrying in 5 seconds...',
//               style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
//                 color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
