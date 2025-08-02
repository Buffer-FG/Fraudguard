import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/bottom_action_bar.dart';
import './widgets/personal_details_tab.dart';
import './widgets/risk_factors_tab.dart';
import './widgets/timeline_tab.dart';
import './widgets/user_header_card.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  bool _isLoading = true;
  Map<String, dynamic>? _userData;
  int _currentBottomNavIndex = 2; 

  // Mock user data
  final Map<String, dynamic> _mockUserData = {
    "id": "USR_001",
    "name": "Sarah Mitchell",
    "email": "sarah.mitchell@email.com",
    "phone": "+1 (555) 123-4567",
    "profileImage":
        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=400",
    "riskScore": 85,
    "status": "Flagged",
    "accountId": "ACC_789456123",
    "flaggedDate": "2025-07-15T14:30:00Z",
    "accountType": "Premium Checking",
    "accountNumber": "****1234",
    "accountOpeningDate": "2023-03-15T10:00:00Z",
    "lastLogin": "2025-07-17T08:45:00Z",
    "loginCount": 247,
    "emailVerified": true,
    "phoneVerified": false,
    "identityVerified": true,
    "addressVerified": false,
    "kycStatus": "Pending Review",
    "primaryDevice": "iPhone 14 Pro",
    "deviceCount": 3,
    "lastIpAddress": "192.168.1.105",
    "lastLocation": "New York, NY",
    "browserInfo": "Safari 16.5",
    "address": {
      "street": "1234 Elm Street, Apt 5B",
      "city": "New York",
      "state": "NY",
      "zipCode": "10001",
      "country": "United States"
    },
    "riskFactors": [
      {
        "severity": "Critical",
        "title": "Multiple Identity Verification Failures",
        "description":
            "User has failed identity verification 3 times in the past 24 hours with different document types.",
        "timestamp": "2025-07-17T06:15:00Z",
        "riskImpact": 35,
        "detectedBy": "AI System",
        "details":
            "Failed attempts: Driver's License (blurry image), Passport (expired), State ID (mismatched name)"
      },
      {
        "severity": "High",
        "title": "Suspicious Login Pattern",
        "description":
            "Login attempts from 5 different geographic locations within 2 hours.",
        "timestamp": "2025-07-16T22:30:00Z",
        "riskImpact": 25,
        "detectedBy": "Geolocation Monitor",
        "details":
            "Locations: New York, Miami, Chicago, Los Angeles, Seattle. Impossible travel time detected."
      },
      {
        "severity": "High",
        "title": "Device Fingerprint Anomaly",
        "description":
            "Multiple device fingerprints associated with single account showing signs of emulation.",
        "timestamp": "2025-07-16T18:45:00Z",
        "riskImpact": 20,
        "detectedBy": "Device Analysis",
        "details":
            "3 different browser fingerprints, 2 mobile device signatures, inconsistent screen resolutions"
      },
      {
        "severity": "Medium",
        "title": "Rapid Account Changes",
        "description":
            "User updated personal information 8 times in the last week including address and phone number.",
        "timestamp": "2025-07-15T14:20:00Z",
        "riskImpact": 15,
        "detectedBy": "Profile Monitor",
        "details":
            "Changed: Address (3x), Phone (2x), Email (1x), Security questions (2x)"
      }
    ],
    "timelineEvents": [
      {
        "type": "Security",
        "title": "Account Flagged for Review",
        "description":
            "Automated system flagged account due to multiple risk factors exceeding threshold.",
        "timestamp": "2025-07-17T09:00:00Z",
        "details": {
          "Risk Score": "85%",
          "Trigger": "Identity Verification Failure",
          "System": "FraudGuard AI",
          "Action": "Account Restricted"
        }
      },
      {
        "type": "Login",
        "title": "Failed Login Attempt",
        "description":
            "Login attempt failed due to incorrect password from Seattle, WA.",
        "timestamp": "2025-07-17T07:30:00Z",
        "details": {
          "IP Address": "203.45.67.89",
          "Location": "Seattle, WA",
          "Device": "Chrome on Windows",
          "Attempts": "3 consecutive failures"
        }
      },
      {
        "type": "Geolocation",
        "title": "Impossible Travel Detected",
        "description":
            "User location changed from New York to Los Angeles in 30 minutes.",
        "timestamp": "2025-07-16T23:15:00Z",
        "details": {
          "Previous Location": "New York, NY",
          "Current Location": "Los Angeles, CA",
          "Time Difference": "30 minutes",
          "Distance": "2,445 miles"
        }
      },
      {
        "type": "Transaction",
        "title": "Large Transaction Attempt",
        "description":
            "Attempted wire transfer of \$15,000 to unverified external account.",
        "timestamp": "2025-07-16T20:45:00Z",
        "details": {
          "Amount": "\$15,000",
          "Destination": "External Bank Account",
          "Status": "Blocked",
          "Reason": "Unverified Recipient"
        }
      },
      {
        "type": "Device",
        "title": "New Device Registration",
        "description":
            "User registered new mobile device from Miami, FL location.",
        "timestamp": "2025-07-16T19:20:00Z",
        "details": {
          "Device": "Samsung Galaxy S23",
          "Location": "Miami, FL",
          "IP Address": "198.51.100.42",
          "Status": "Pending Verification"
        }
      },
      {
        "type": "Login",
        "title": "Successful Login",
        "description":
            "User successfully logged in from Chicago, IL using known device.",
        "timestamp": "2025-07-16T16:10:00Z",
        "details": {
          "IP Address": "192.0.2.146",
          "Location": "Chicago, IL",
          "Device": "iPhone 14 Pro",
          "Session Duration": "45 minutes"
        }
      }
    ]
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUserData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    // Simulate loading delay
    await Future.delayed(const Duration(milliseconds: 800));

    setState(() {
      _userData = _mockUserData;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('User Profile'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            color: AppTheme.lightTheme.colorScheme.onSurface,
            size: 24,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: _handleMenuAction,
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'export',
                child: Text('Export Profile'),
              ),
              const PopupMenuItem(
                value: 'notes',
                child: Text('Investigation Notes'),
              ),
              const PopupMenuItem(
                value: 'history',
                child: Text('View History'),
              ),
            ],
            icon: CustomIconWidget(
              iconName: 'more_vert',
              color: AppTheme.lightTheme.colorScheme.onSurface,
              size: 24,
            ),
          ),
        ],
      ),
      body: _isLoading ? _buildLoadingState() : _buildContent(),
      floatingActionButton: _isLoading
          ? null
          : FloatingActionButton.extended(
              onPressed: _handleFlagForReview,
              icon: CustomIconWidget(
                iconName: 'flag',
                color: AppTheme.lightTheme.colorScheme.onPrimary,
                size: 20,
              ),
              label: const Text('Flag for Review'),
            ),
      bottomNavigationBar: _isLoading
          ? null
          : BottomActionBar(
              userData: _userData!,
              onClearFlag: _handleClearFlag,
              onEscalateCase: _handleEscalateCase,
              onGenerateReport: _handleGenerateReport,
            ),
            
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: AppTheme.lightTheme.colorScheme.primary,
          ),
          SizedBox(height: 2.h),
          Text(
            'Loading user profile...',
            style: AppTheme.lightTheme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        UserHeaderCard(userData: _userData!),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Personal Details'),
              Tab(text: 'Risk Factors'),
              Tab(text: 'Timeline'),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              PersonalDetailsTab(userData: _userData!),
              RiskFactorsTab(userData: _userData!),
              TimelineTab(userData: _userData!),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentBottomNavIndex,
      onTap: (index) {
        setState(() {
          _currentBottomNavIndex = index;
        });
        _navigateToScreen(index);
      },
      type: BottomNavigationBarType.fixed,
      backgroundColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.backgroundColor,
      selectedItemColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.selectedItemColor,
      unselectedItemColor:
          AppTheme.lightTheme.bottomNavigationBarTheme.unselectedItemColor,
      elevation: AppTheme.lightTheme.bottomNavigationBarTheme.elevation,
      items: [
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'dashboard',
            color: _currentBottomNavIndex == 0
                ? AppTheme
                    .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                : AppTheme
                    .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
            size: 24,
          ),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'flag',
            color: _currentBottomNavIndex == 1
                ? AppTheme
                    .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                : AppTheme
                    .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
            size: 24,
          ),
          label: 'Flagged Users',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'assessment',
            color: _currentBottomNavIndex == 2
                ? AppTheme
                    .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                : AppTheme
                    .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
            size: 24,
          ),
          label: 'Reports',
        ),
        BottomNavigationBarItem(
          icon: CustomIconWidget(
            iconName: 'person',
            color: _currentBottomNavIndex == 3
                ? AppTheme
                    .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                : AppTheme
                    .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
            size: 24,
          ),
          label: 'Profile',
        ),
      ],
    );
  }

  void _navigateToScreen(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard-screen');
        break;
      case 1:
        // Navigator.pushReplacementNamed(context, '/flagged-users-list-screen');
        break;
      case 2:
        Navigator.pushNamed(context, '/reports-screen');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/admin-profile-screen');
        break;
    }
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'export':
        _handleExportProfile();
        break;
      case 'notes':
        _handleInvestigationNotes();
        break;
      case 'history':
        _handleViewHistory();
        break;
    }
  }

  void _handleExportProfile() {
    // Fluttertoast.showToast(
    //   msg: 'Profile exported successfully',
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   backgroundColor: AppTheme.lightTheme.colorScheme.primary,
    //   textColor: Colors.white,
    // );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile exported successfully')),
    );
  }

  void _handleInvestigationNotes() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Investigation Notes'),
        content: SizedBox(
          width: 80.w,
          height: 30.h,
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Add investigation notes...',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
            expands: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Fluttertoast.showToast(
              //   msg: 'Investigation note added',
              //   toastLength: Toast.LENGTH_SHORT,
              //   gravity: ToastGravity.BOTTOM,
              //   backgroundColor: AppTheme.lightTheme.colorScheme.primary,
              //   textColor: Colors.white,
              // );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Investigation note added')),
              );
            },
            child: const Text('Save Note'),
          ),
        ],
      ),
    );
  }

  void _handleViewHistory() {
    // Fluttertoast.showToast(
    //   msg: 'Opening investigation history...',
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   backgroundColor: AppTheme.lightTheme.colorScheme.primary,
    //   textColor: Colors.white,
    // );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Opening investigation history...')),
    );
  }

  void _handleFlagForReview() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Flag for Review'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flag ${_userData!['name']} for additional review?'),
            SizedBox(height: 2.h),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Review Reason',
                hintText: 'Enter reason for flagging...',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // .showToast(
              //   msg: 'User flagged for review',
              //   toastLength: Toast.LENGTH_SHORT,
              //   gravity: ToastGravity.BOTTOM,
              //   backgroundColor: AppTheme.warningLight,
              //   textColor: Colors.white,
              // );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('User flagged for review'),
                  backgroundColor: AppTheme.warningLight,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.warningLight,
            ),
            child: const Text('Flag User'),
          ),
        ],
      ),
    );
  }

  void _handleClearFlag() {
    // Handled by BottomActionBar
  }

  void _handleEscalateCase() {
    // Handled by BottomActionBar
  }

  void _handleGenerateReport() {
    // Handled by BottomActionBar
  }
}
