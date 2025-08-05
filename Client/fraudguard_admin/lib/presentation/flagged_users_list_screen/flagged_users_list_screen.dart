import 'package:flutter/material.dart';

import '../../core/app_export.dart';
import './widgets/empty_state_widget.dart';
import './widgets/filter_bottom_sheet_widget.dart';
import './widgets/search_header_widget.dart';
import './widgets/skeleton_card_widget.dart';
import './widgets/user_card_widget.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class FlaggedUsersListScreen extends StatefulWidget {
  const FlaggedUsersListScreen({Key? key}) : super(key: key);

  @override
  State<FlaggedUsersListScreen> createState() => _FlaggedUsersListScreenState();
}

class _FlaggedUsersListScreenState extends State<FlaggedUsersListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _filteredUsers = [];
  List<String> _activeFilters = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMoreData = true;
  int _currentPage = 1;
  final int _pageSize = 20;

  // Mock data for flagged users
  // final List<Map<String, dynamic>> _mockUsers = [
  //   {
  //     "id": 1,
  //     "name": "John Anderson",
  //     "email": "john.anderson@email.com",
  //     "avatar":
  //         "https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png",
  //     "riskScore": 95,
  //     "flagDate": DateTime.now().subtract(const Duration(hours: 2)),
  //     "region": "North America",
  //     "flagReason":
  //         "Multiple suspicious login attempts from different locations"
  //   },
  //   {
  //     "id": 2,
  //     "name": "Sarah Wilson",
  //     "email": "sarah.wilson@email.com",
  //     "avatar":
  //         "https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png",
  //     "riskScore": 87,
  //     "flagDate": DateTime.now().subtract(const Duration(hours: 5)),
  //     "region": "Europe",
  //     "flagReason": "Unusual transaction patterns detected"
  //   },
  //   {
  //     "id": 3,
  //     "name": "Michael Chen",
  //     "email": "michael.chen@email.com",
  //     "avatar":
  //         "https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png",
  //     "riskScore": 92,
  //     "flagDate": DateTime.now().subtract(const Duration(hours: 8)),
  //     "region": "Asia Pacific",
  //     "flagReason": "Identity verification failed multiple times"
  //   },
  //   {
  //     "id": 4,
  //     "name": "Emily Rodriguez",
  //     "email": "emily.rodriguez@email.com",
  //     "avatar":
  //         "https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png",
  //     "riskScore": 78,
  //     "flagDate": DateTime.now().subtract(const Duration(days: 1)),
  //     "region": "Latin America",
  //     "flagReason": "Suspicious device fingerprinting patterns"
  //   },
  //   {
  //     "id": 5,
  //     "name": "David Thompson",
  //     "email": "david.thompson@email.com",
  //     "avatar":
  //         "https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png",
  //     "riskScore": 85,
  //     "flagDate": DateTime.now().subtract(const Duration(days: 1, hours: 3)),
  //     "region": "North America",
  //     "flagReason": "Anomalous spending behavior detected"
  //   },
  //   {
  //     "id": 6,
  //     "name": "Lisa Park",
  //     "email": "lisa.park@email.com",
  //     "avatar":
  //         "https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png",
  //     "riskScore": 73,
  //     "flagDate": DateTime.now().subtract(const Duration(days: 2)),
  //     "region": "Asia Pacific",
  //     "flagReason": "Multiple failed authentication attempts"
  //   },
  //   {
  //     "id": 7,
  //     "name": "Robert Johnson",
  //     "email": "robert.johnson@email.com",
  //     "avatar":
  //         "https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png",
  //     "riskScore": 89,
  //     "flagDate": DateTime.now().subtract(const Duration(days: 2, hours: 5)),
  //     "region": "Europe",
  //     "flagReason": "Synthetic identity indicators found"
  //   },
  //   {
  //     "id": 8,
  //     "name": "Maria Garcia",
  //     "email": "maria.garcia@email.com",
  //     "avatar":
  //         "https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png",
  //     "riskScore": 81,
  //     "flagDate": DateTime.now().subtract(const Duration(days: 3)),
  //     "region": "Latin America",
  //     "flagReason": "Unusual account creation patterns"
  //   },
  //   {
  //     "id": 9,
  //     "name": "James Miller",
  //     "email": "james.miller@email.com",
  //     "avatar":
  //         "https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png",
  //     "riskScore": 76,
  //     "flagDate": DateTime.now().subtract(const Duration(days: 3, hours: 8)),
  //     "region": "North America",
  //     "flagReason": "Suspicious network connections detected"
  //   },
  //   {
  //     "id": 10,
  //     "name": "Anna Kowalski",
  //     "email": "anna.kowalski@email.com",
  //     "avatar":
  //         "https://www.pngkey.com/png/full/349-3499617_person-placeholder-person-placeholder.png",
  //     "riskScore": 94,
  //     "flagDate": DateTime.now().subtract(const Duration(days: 4)),
  //     "region": "Europe",
  //     "flagReason": "High-risk behavioral patterns identified"
  //   },
  // ];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  // void _loadInitialData() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   // Simulate API call delay
  //   await Future.delayed(const Duration(milliseconds: 1500));

  //   setState(() {
  //     _allUsers = List.from(_mockUsers);
  //     _filteredUsers = List.from(_allUsers);
  //     _isLoading = false;
  //   });
  // }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));

    // Load JSON from file
    final String response =
        await rootBundle.loadString('assets/data/mock_users.json');
    final List<dynamic> data = json.decode(response);

    setState(() {
      _allUsers = List<Map<String, dynamic>>.from(data);
      _filteredUsers = List.from(_allUsers);
      _isLoading = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreData();
    }
  }

  // void _loadMoreData() async {
  //   if (_isLoadingMore || !_hasMoreData) return;

  //   setState(() {
  //     _isLoadingMore = true;
  //   });

  //   // Simulate API call delay
  //   await Future.delayed(const Duration(milliseconds: 1000));

  //   // Simulate no more data after 2 pages
  //   if (_currentPage >= 2) {
  //     setState(() {
  //       _hasMoreData = false;
  //       _isLoadingMore = false;
  //     });
  //     return;
  //   }
  // }

  void _loadMoreData() async {
    if (_isLoadingMore || !_hasMoreData) return;

    setState(() {
      _isLoadingMore = true;
    });

    // Simulate API call delay
    await Future.delayed(const Duration(milliseconds: 1000));

    // Simulate no more data after 2 pages
    if (_currentPage >= 2) {
      setState(() {
        _hasMoreData = false;
        _isLoadingMore = false;
      });
      return;
    }

    // Simulate more users by duplicating existing ones
    final moreUsers = _allUsers.take(_pageSize).map((user) {
      return {
        ...user,
        'id': user['id'] + (_currentPage * _pageSize),
        'name': '${user['name']} (Page ${_currentPage + 1})',
      };
    }).toList();

    setState(() {
      _allUsers.addAll(moreUsers);
      _applyFilters();
      _currentPage++;
      _isLoadingMore = false;
    });
  }

  // Add more mock data
  //   final moreUsers = _mockUsers
  //       .map((user) => {
  //             ...user,
  //             'id': user['id'] + (_currentPage * _pageSize),
  //             'name': '${user['name']} (Page ${_currentPage + 1})',
  //           })
  //       .toList();

  //   setState(() {
  //     _allUsers.addAll(moreUsers);
  //     _applyFilters();
  //     _currentPage++;
  //     _isLoadingMore = false;
  //   });
  // }

  void _onSearchChanged(String query) {
    setState(() {
      _currentPage = 1;
      _hasMoreData = true;
      _applyFilters();
    });
  }

  void _applyFilters() {
    String query = _searchController.text.toLowerCase();

    _filteredUsers = _allUsers.where((user) {
      final matchesSearch = query.isEmpty ||
          (user['name'] as String).toLowerCase().contains(query) ||
          (user['email'] as String).toLowerCase().contains(query);

      // Apply other filters here based on _activeFilters
      return matchesSearch;
    }).toList();
  }

  void _onFiltersApplied(Map<String, dynamic> filters) {
    List<String> newActiveFilters = [];

    if (filters['region'] != null && filters['region'] != 'All Regions') {
      newActiveFilters.add('Region: ${filters['region']}');
    }

    final riskRange = filters['riskScoreRange'] as RangeValues?;
    if (riskRange != null && (riskRange.start > 0 || riskRange.end < 100)) {
      newActiveFilters
          .add('Risk: ${riskRange.start.round()}%-${riskRange.end.round()}%');
    }

    if (filters['datePreset'] != null) {
      newActiveFilters.add('Date: ${filters['datePreset']}');
    } else if (filters['startDate'] != null && filters['endDate'] != null) {
      newActiveFilters.add('Custom Date Range');
    }

    setState(() {
      _activeFilters = newActiveFilters;
      _applyFilters();
    });
  }

  void _clearAllFilters() {
    setState(() {
      _activeFilters.clear();
      _searchController.clear();
      _applyFilters();
    });
  }

  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: FilterBottomSheetWidget(
          onFiltersApplied: _onFiltersApplied,
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _loadUsersFromJson() async {
    final String response =
        await rootBundle.loadString('assets/data/mock_users.json');
    final List<dynamic> data = json.decode(response);
    return List<Map<String, dynamic>>.from(data);
  }

  Future<void> _onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    final users = await _loadUsersFromJson();

    setState(() {
      _currentPage = 1;
      _hasMoreData = true;
      _allUsers = users;
      _applyFilters();
    });
  }
  // void _navigateToUserProfile(Map<String, dynamic> userData) {
  //   Navigator.pushNamed(
  //     context,
  //     '/user-profile-screen',
  //     arguments: userData,
  //   );
  // }

  void _navigateToUserProfile(Map<String, dynamic> userData) {
    Navigator.pushNamed(
      context,
      '/user-profile-screen',
      arguments: {
        'id': userData['id'],
        'name': userData['name'],
        'email': userData['email'],
        'profileImage': userData['profileImage'],
        'riskScore': userData['riskScore'], // 👈 pass it
        'flagDate': userData['flagDate'],
        // Optionally: pass riskFactors list dynamically too
      },
    );

    // Navigator.pushNamed(
    //   context,
    //   '/user-profile-screen',
    //   arguments: {
    //     'id': '003',
    //     'name': 'Sophia Zhang',
    //     'email': 'sophia.zhang@example.com',
    //     'profileImage': 'https://example.com/sophia.jpg',
    //     'flagDate': DateTime.now(),
    //     'riskFactors': ['Identity mismatch', 'IP mismatch'],
    //     'lastLocation': 'suspicious location',
    //     'deviceCount': 5,
    //     'identityVerified': false,
    //     'kycStatus': 'Pending Review',
    //     'lastLogin':
    //         DateTime.now().subtract(Duration(days: 45)).toIso8601String(),
    //   },
    // );
  }

  void _handleUserReview(Map<String, dynamic> userData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reviewing ${userData['name']}...'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {},
        ),
      ),
    );
  }

  void _handleClearFlag(Map<String, dynamic> userData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Flag cleared for ${userData['name']}'),
        backgroundColor: AppTheme.successLight,
      ),
    );
  }

  void _handleExportUser(Map<String, dynamic> userData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Exporting data for ${userData['name']}...'),
      ),
    );
  }

  void _handleAddNote(Map<String, dynamic> userData) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Adding note for ${userData['name']}...'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SearchHeaderWidget(
              searchController: _searchController,
              onSearchChanged: _onSearchChanged,
              // onFilterTap: _showFilterBottomSheet,
              // activeFilters: _activeFilters,
              // onClearFilters: _clearAllFilters,
            ),
            Expanded(
              child: _isLoading
                  ? _buildSkeletonList()
                  : _filteredUsers.isEmpty
                      ? EmptyStateWidget(
                          onClearFilters: _clearAllFilters,
                          hasActiveFilters: _activeFilters.isNotEmpty,
                        )
                      : _buildUsersList(),
            ),
          ],
        ),
      ),
      // floatingActionButton: _filteredUsers.isNotEmpty
      //     ? FloatingActionButton(
      //         onPressed: () {
      //           // Handle bulk actions
      //           ScaffoldMessenger.of(context).showSnackBar(
      //             const SnackBar(
      //               content: Text('Bulk actions available'),
      //             ),
      //           );
      //         },
      //         child: CustomIconWidget(
      //           iconName: 'checklist',
      //           color: AppTheme.lightTheme.colorScheme.onPrimary,
      //           size: 24,
      //         ),
      //       )
      //     : null,
    );
  }

  Widget _buildSkeletonList() {
    return ListView.builder(
      itemCount: 8,
      itemBuilder: (context, index) => const SkeletonCardWidget(),
    );
  }

  Widget _buildUsersList() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      color: AppTheme.lightTheme.colorScheme.primary,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _filteredUsers.length + (_isLoadingMore ? 3 : 0),
        itemBuilder: (context, index) {
          if (index >= _filteredUsers.length) {
            return const SkeletonCardWidget();
          }

          final userData = _filteredUsers[index];
          return UserCardWidget(
            userData: userData,
            onTap: () => _navigateToUserProfile(userData),
            onReview: () => _handleUserReview(userData),
            onClearFlag: () => _handleClearFlag(userData),
            onExport: () => _handleExportUser(userData),
            onAddNote: () => _handleAddNote(userData),
          );
        },
      ),
    );
  }
}
