import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/fraud_trend_chart_widget.dart';
import './widgets/high_risk_user_card_widget.dart';
import './widgets/metrics_card_widget.dart';
import './widgets/status_header_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  bool _isRefreshing = false;

  // Mock data for dashboard metrics
  final Map<String, dynamic> dashboardMetrics = {
    "totalUsersScanned": 45672,
    "flaggedUsersCount": 127,
    "fraudRate": 2.8,
    "lastSyncTime": "2 mins ago",
    "isConnected": true,
  };

  // Mock data for high-risk users
  final List<Map<String, dynamic>> highRiskUsers = [
    {
      "id": 1,
      "name": "Marcus Johnson",
      "email": "marcus.j@email.com",
      "riskScore": 94.5,
      "profileImage":
          "https://images.pexels.com/photos/2379004/pexels-photo-2379004.jpeg?auto=compress&cs=tinysrgb&w=400",
      "flagDate": "07/15/2025",
      "flagReason": "Multiple identity patterns detected",
    },
    {
      "id": 2,
      "name": "Sarah Chen",
      "email": "s.chen.banking@email.com",
      "riskScore": 87.2,
      "profileImage":
          "https://images.pexels.com/photos/1239291/pexels-photo-1239291.jpeg?auto=compress&cs=tinysrgb&w=400",
      "flagDate": "07/16/2025",
      "flagReason": "Suspicious device fingerprinting",
    },
    {
      "id": 3,
      "name": "David Rodriguez",
      "email": "d.rodriguez.finance@email.com",
      "riskScore": 82.8,
      "profileImage":
          "https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=400",
      "flagDate": "07/16/2025",
      "flagReason": "Shared IP address patterns",
    },
    {
      "id": 4,
      "name": "Emily Watson",
      "email": "emily.watson.corp@email.com",
      "riskScore": 79.1,
      "profileImage":
          "https://images.pexels.com/photos/1130626/pexels-photo-1130626.jpeg?auto=compress&cs=tinysrgb&w=400",
      "flagDate": "07/17/2025",
      "flagReason": "Anomalous login behavior",
    },
    {
      "id": 5,
      "name": "Michael Thompson",
      "email": "m.thompson.secure@email.com",
      "riskScore": 76.3,
      "profileImage":
          "https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=400",
      "flagDate": "07/17/2025",
      "flagReason": "Duplicate phone number usage",
    },
  ];

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
      dashboardMetrics["lastSyncTime"] = "Just now";
    });
  }

  void _showUserContextMenu(BuildContext context, Map<String, dynamic> user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.lightTheme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.outline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              user['name'] as String,
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 2.h),
            _buildContextMenuItem(
              icon: 'flag',
              title: 'Flag for Review',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${user['name']} flagged for review')),
                );
              },
            ),
            _buildContextMenuItem(
              icon: 'note_add',
              title: 'Add Note',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Note added for ${user['name']}')),
                );
              },
            ),
            _buildContextMenuItem(
              icon: 'download',
              title: 'Export Data',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Exporting data for ${user['name']}')),
                );
              },
            ),
            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildContextMenuItem({
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: CustomIconWidget(
        iconName: icon,
        color: AppTheme.lightTheme.colorScheme.primary,
        size: 24,
      ),
      title: Text(
        title,
        style: AppTheme.lightTheme.textTheme.bodyMedium,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: AppTheme.lightTheme.colorScheme.primary,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: StatusHeaderWidget(
                lastSyncTime: dashboardMetrics["lastSyncTime"] as String,
                isConnected: dashboardMetrics["isConnected"] as bool,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 2.h),
            ),
            // Metrics Cards
            SliverToBoxAdapter(
              child: Column(
                children: [
                  MetricsCardWidget(
                    title: 'Total Users Scanned',
                    value:
                        '${(dashboardMetrics["totalUsersScanned"] as int).toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}',
                    subtitle: 'Last 24 hours',
                    trendIcon: 'trending_up',
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: MetricsCardWidget(
                          title: 'Flagged Users',
                          value: '${dashboardMetrics["flaggedUsersCount"]}',
                          badgeColor: AppTheme.lightTheme.colorScheme.error,
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/flagged-users-list-screen');
                          },
                        ),
                      ),
                      Expanded(
                        child: MetricsCardWidget(
                          title: 'Fraud Rate',
                          value: '${dashboardMetrics["fraudRate"]}%',
                          subtitle: 'Current period',
                          trendIcon: 'trending_down',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Fraud Trend Chart
            SliverToBoxAdapter(
              child: FraudTrendChartWidget(),
            ),
            // High Risk Users Section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Top 5 Highest Risk Users',
                      style:
                          AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, '/flagged-users-list-screen');
                      },
                      child: Text('View All'),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final user = highRiskUsers[index];
                  return HighRiskUserCardWidget(
                    userData: user,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/user-profile-screen',
                        arguments: user,
                      );
                    },
                    onLongPress: () {
                      _showUserContextMenu(context, user);
                    },
                  );
                },
                childCount: highRiskUsers.length,
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 10.h),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.backgroundColor,
        selectedItemColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            AppTheme.lightTheme.bottomNavigationBarTheme.unselectedItemColor,
        elevation:
            AppTheme.lightTheme.bottomNavigationBarTheme.elevation ?? 4.0,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              // Already on Dashboard
              break;
            case 1:
              Navigator.pushNamed(context, '/flagged-users-list-screen');
              break;
            case 2:
              Navigator.pushNamed(context, '/reports-screen');
              break;
            case 3:
              Navigator.pushNamed(context, '/admin-profile-screen');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'dashboard',
              color: _currentIndex == 0
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
              color: _currentIndex == 1
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
              iconName: 'assessment', // Reports icon
              color: _currentIndex == 2
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
              iconName: 'person', // Admin profile icon
              color: _currentIndex == 3
                  ? AppTheme
                      .lightTheme.bottomNavigationBarTheme.selectedItemColor!
                  : AppTheme
                      .lightTheme.bottomNavigationBarTheme.unselectedItemColor!,
              size: 24,
            ),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Manual User Lookup'),
              content: TextField(
                decoration: InputDecoration(
                  hintText: 'Enter user ID or email',
                  prefixIcon: CustomIconWidget(
                    iconName: 'search',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('User lookup initiated')),
                    );
                  },
                  child: Text('Search'),
                ),
              ],
            ),
          );
        },
        backgroundColor:
            AppTheme.lightTheme.floatingActionButtonTheme.backgroundColor,
        foregroundColor:
            AppTheme.lightTheme.floatingActionButtonTheme.foregroundColor,
        child: CustomIconWidget(
          iconName: 'search',
          color: AppTheme.lightTheme.floatingActionButtonTheme.foregroundColor!,
          size: 24,
        ),
      ),
    );
  }
}
