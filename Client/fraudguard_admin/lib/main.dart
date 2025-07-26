// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sizer/sizer.dart';
// import './presentation/Authentication/login_screen.dart';
// import './presentation/dashboard_screen/dashboard_screen.dart';
// import '../core/app_export.dart';
// import '../widgets/custom_error_widget.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   // Custom error handling 
//   ErrorWidget.builder = (FlutterErrorDetails details) {
//     return CustomErrorWidget(
//       errorDetails: details,
//     );
//   };
//   // Device orientation lock 
//   Future.wait([
//     SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
//   ]).then((value) {
//     runApp(MyApp());
//   });
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Sizer(builder: (context, orientation, screenType) {
//       return MaterialApp(
//         title: 'fraudguard_admin',
//         theme: AppTheme.lightTheme,
//         darkTheme: AppTheme.darkTheme,
//         themeMode: ThemeMode.light,
//         // BEGIN CRITICAL SECTION
//         builder: (context, child) {
//           return MediaQuery(
//             data: MediaQuery.of(context).copyWith(
//               textScaler: TextScaler.linear(1.0),
//             ),
//             child: child!,
//           );
//         },
//         // END CRITICAL SECTION
//         debugShowCheckedModeBanner: false,
//         home: StreamBuilder(
//           stream: FirebaseAuth.instance.authStateChanges(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasData) {
//               return const DashboardScreen();
//             } else {
//               return const LoginScreen();
//             }
//           },
//         ),
//         routes: AppRoutes.routes,
//         initialRoute: AppRoutes.initial,
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:sizer/sizer.dart';
// import './presentation/Authentication/login_screen.dart';
// import './presentation/dashboard_screen/dashboard_screen.dart';
// import '../core/app_export.dart';
// import '../widgets/custom_error_widget.dart';

// Import your project's files - please verify these paths are correct for your structure
// import 'package:fraudguard_admin/firebase_options.dart'; 
import 'package:fraudguard_admin/presentation/wrapper/Autowrapper.dart';
import 'package:fraudguard_admin/presentation/screens/onboarding_screen.dart'; 
import 'package:fraudguard_admin/presentation/Authentication/login_screen.dart';
import 'package:fraudguard_admin/presentation/dashboard_screen/dashboard_screen.dart';
import 'package:fraudguard_admin/core/app_export.dart';
import 'package:fraudguard_admin/widgets/custom_error_widget.dart';

void main() async {
  // --- INITIALIZATION ---
  // Ensure Flutter engine is ready
  // WidgetsFlutterBinding.ensureInitialized();

  // // Initialize Firebase with platform-specific options
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Lock device orientation
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  
  // Check if the user has completed onboarding before
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  // Set custom error widget
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return CustomErrorWidget(errorDetails: details);
  };

  // Run the app, passing the onboarding status
  runApp(MyApp(seenOnboarding: seenOnboarding));
}

class MyApp extends StatelessWidget {
  final bool seenOnboarding;

  const MyApp({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'fraudguard_admin',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.linear(1.0),
              ),
              child: child!,
            );
          },
          
          home: seenOnboarding ? const AuthWrapper() : OnboardingScreen(),
          
          // Your routes are still available for named navigation
          routes: AppRoutes.routes,
        );
      },
    );
  }
}

/// This widget is the gatekeeper. It listens to the authentication
/// state and shows the correct screen AFTER the initial onboarding check.
// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User?>(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         // While checking, show a loading indicator
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Scaffold(
//             body: Center(child: CircularProgressIndicator()),
//           );
//         }
//         // If user is logged in, show the Dashboard
//         if (snapshot.hasData) {
//           return const DashboardScreen();
//         }
//         // Otherwise, show the Login screen
//         return const LoginScreen();
//       },
//     );
//   }
// }

