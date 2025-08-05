import 'package:flutter/material.dart';
// import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/screens/onboarding_screen.dart';
import '../presentation/Authentication/login_screen.dart';
import '../presentation/Authentication/signup_screen.dart';
import '../presentation/dashboard_screen/dashboard_screen.dart';
import '../presentation/user_profile_screen/user_profile_screen.dart';
import '../presentation/reports_screen/reports_screen.dart';
import '../presentation/admin_profile_screen/admin_profile_screen.dart';
import '../presentation/flagged_users_list_screen/flagged_users_list_screen.dart';
import '../presentation/user_profile_screen/dashboard_user.dart'; 
// import '../presentation/network_graph_screen/network_graph_screen.dart';

class AppRoutes {
  // static const String initial = '/';
  // static const String splashScreen = '/splash-screen';
  static const String onboardingScreen = '/onboarding-screen';
  static const String loginScreen = '/login-screen';
  static const String signupScreen = '/signup-screen';
  static const String dashboardScreen = '/dashboard-screen';
  static const String userProfileScreen = '/user-profile-screen';
  static const String reportsScreen = '/reports-screen';
  static const String flaggedUsersListScreen = '/flagged-users-list-screen';
  static const String networkGraphScreen = '/network-graph-screen';
  static const String adminProfileScreen = '/admin-profile-screen';
  static const String dashuserProfileScreen = '/dash-user-profile-screen';

  static Map<String, WidgetBuilder> routes = {
    // initial: (context) => LoginScreen(),
    // splashScreen: (context) => SplashScreen(),
    onboardingScreen: (context) => OnboardingScreen(),
    loginScreen: (context) => LoginScreen(),
    signupScreen: (context) => SignupScreen(),
    dashboardScreen: (context) => DashboardScreen(),
    userProfileScreen: (context) => UserProfileScreen(),
    dashuserProfileScreen: (context) => DashUserProfileScreen(),
    // userProfileScreen: (context) {
    //   final args =
    //       ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    //   return UserProfileScreen(
    //     userData: args?['userData'],
    //     userId: args?['userId'],
    //   );
    // },
    reportsScreen: (context) => ReportsScreen(),
    flaggedUsersListScreen: (context) => FlaggedUsersListScreen(),
    adminProfileScreen: (context) => AdminProfileScreen(),
    // networkGraphScreen: (context) => NetworkGraphScreen(),
  };
}

// import 'package:flutter/material.dart';
// import '../presentation/splash_screen/splash.dart';
// import '../presentation/screens/onboarding_screen.dart';
// import '../presentation/login_screen/login_screen.dart';
// import '../presentation/dashboard_screen/dashboard_screen.dart';
// import '../presentation/user_profile_screen/user_profile_screen.dart';
// import '../presentation/reports_screen/reports_screen.dart';
// import '../presentation/flagged_users_list_screen/flagged_users_list_screen.dart';
// import '../presentation/network_graph_screen/network_graph_screen.dart';

// class AppRoutes {
//   // Route name constants
//   static const String initial = '/';
//   static const String splashScreen = '/splash-screen';
//   static const String onboardingScreen = '/onboarding-screen';
//   static const String authenticationScreen = '/authentication-screen';
//   static const String loginScreen = '/login-screen';
//   static const String dashboardScreen = '/dashboard-screen';
//   static const String userProfileScreen = '/user-profile-screen';
//   static const String reportsScreen = '/reports-screen';
//   static const String flaggedUsersListScreen = '/flagged-users-list-screen';
//   static const String networkGraphScreen = '/network-graph-screen';

//   // onGenerateRoute function
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case initial:
//       case onboardingScreen:
//         return MaterialPageRoute(
//           builder: (context) => OnboardingScreen(),
//         );
//       case loginScreen:
//         return MaterialPageRoute(builder: (_) => const LoginScreen());

//       case splashScreen:
//         return MaterialPageRoute(builder: (_) => const SplashScreen());
//       case dashboardScreen:
//         return MaterialPageRoute(builder: (_) => const DashboardScreen());

//       case userProfileScreen:
//         return MaterialPageRoute(builder: (_) => const UserProfileScreen());

//       case reportsScreen:
//         return MaterialPageRoute(builder: (_) => const ReportsScreen());

//       case flaggedUsersListScreen:
//         return MaterialPageRoute(
//             builder: (_) => const FlaggedUsersListScreen());

//       case networkGraphScreen:
//         return MaterialPageRoute(builder: (_) => const NetworkGraphScreen());

//       // default:
//       //   return MaterialPageRoute(
//       //     builder: (_) => Scaffold(
//       //       body: Center(
//       //         child: Text(
//       //           '404: Page Not Found',
//       //           style: TextStyle(fontSize: 24),
//       //         ),
//       //       ),
//       //     ),
//       //   );

//       default:
//       return MaterialPageRoute(
//         // Make a screen for undefine
//         builder: (context) => const OnBoardingScreen(),
//       );
//     }
//   }
// }
