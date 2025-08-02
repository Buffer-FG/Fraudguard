import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fraudguard_admin/presentation/Authentication/login_screen.dart';
import '../../core/app_export.dart';
import './widgets/profile_info_card.dart';
import './widgets/profile_settings_list.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({Key? key}) : super(key: key);

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  Map<String, dynamic>? userProfile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .get();
      if (doc.exists) {
        setState(() {
          userProfile = doc.data();
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void _handleLogout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login-screen',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: AppTheme.lightTheme.appBarTheme.titleTextStyle,
        ),
        backgroundColor: AppTheme.lightTheme.appBarTheme.backgroundColor,
        foregroundColor: AppTheme.lightTheme.appBarTheme.foregroundColor,
        elevation: AppTheme.lightTheme.appBarTheme.elevation,
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content:
                      Text('Settings will be available in future updates'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: CustomIconWidget(
              iconName: 'settings',
              color: AppTheme.lightTheme.appBarTheme.foregroundColor!,
              size: 24,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : userProfile == null
                ? Center(
                    child: Text(
                      'User profile not found.',
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                  )
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 2.h),

                        /// Profile Information Card (pass dynamic data)
                        ProfileInfoCard(userProfile: userProfile!),

                        SizedBox(height: 2.h),

                        /// Settings / Logout List
                        ProfileSettingsList(onLogout: _handleLogout),

                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
      ),
    );
  }
}
