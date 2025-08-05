import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class SearchHeaderWidget extends StatefulWidget {
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;
  // final VoidCallback onFilterTap;
  // final List<String> activeFilters;
  // final VoidCallback onClearFilters;

  const SearchHeaderWidget({
    Key? key,
    required this.searchController,
    required this.onSearchChanged,
    // required this.onFilterTap,
    // required this.activeFilters,
    // required this.onClearFilters,
  }) : super(key: key);

  @override
  State<SearchHeaderWidget> createState() => _SearchHeaderWidgetState();
}

class _SearchHeaderWidgetState extends State<SearchHeaderWidget> {
  final FocusNode _searchFocusNode = FocusNode();
  bool _showRecentSearches = false;

  final List<String> _recentSearches = [
    'john.doe@email.com',
    'high risk users',
    'flagged today',
    'sarah.wilson',
  ];

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _showRecentSearches =
            _searchFocusNode.hasFocus && widget.searchController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.lightTheme.colorScheme.surface,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 1.h),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: TextField(
                      controller: widget.searchController,
                      focusNode: _searchFocusNode,
                      onChanged: widget.onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Search users by name, email...',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: CustomIconWidget(
                            iconName: 'search',
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ),
                        suffixIcon: widget.searchController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  widget.searchController.clear();
                                  widget.onSearchChanged('');
                                  setState(() {});
                                },
                                icon: CustomIconWidget(
                                  iconName: 'close',
                                  color: AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                                  size: 20,
                                ),
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 2.h),
                      ),
                      style: AppTheme.lightTheme.textTheme.bodyMedium,
                    ),
                  ),
                ),
                // SizedBox(width: 3.w),
                // Container(
                //   decoration: BoxDecoration(
                //     color: AppTheme.lightTheme.colorScheme.primary,
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: Material(
                //     color: Colors.transparent,
                //     child: InkWell(
                //       onTap: widget.onFilterTap,
                //       borderRadius: BorderRadius.circular(12),
                //       child: Container(
                //         padding: EdgeInsets.all(3.w),
                //         child: Stack(
                //           children: [
                //             CustomIconWidget(
                //               iconName: 'tune',
                //               color: AppTheme.lightTheme.colorScheme.onPrimary,
                //               size: 24,
                //             ),
                //             if (widget.activeFilters.isNotEmpty)
                //               Positioned(
                //                 right: -2,
                //                 top: -2,
                //                 child: Container(
                //                   padding: EdgeInsets.all(1.w),
                //                   decoration: BoxDecoration(
                //                     color: AppTheme.warningLight,
                //                     shape: BoxShape.circle,
                //                   ),
                //                   constraints: BoxConstraints(
                //                     minWidth: 5.w,
                //                     minHeight: 5.w,
                //                   ),
                //                   child: Text(
                //                     widget.activeFilters.length.toString(),
                //                     style: TextStyle(
                //                       color: Colors.white,
                //                       fontSize: 10.sp,
                //                       fontWeight: FontWeight.w600,
                //                     ),
                //                     textAlign: TextAlign.center,
                //                   ),
                //                 ),
                //               ),
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          // if (widget.activeFilters.isNotEmpty) _buildActiveFilters(),
          if (_showRecentSearches) _buildRecentSearches(),
        ],
      ),
    );
  }

  // Widget _buildActiveFilters() {
  //   return Container(
  //     padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 1.h),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           children: [
  //             Text(
  //               'Active Filters (${widget.activeFilters.length})',
  //               style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
  //                 fontWeight: FontWeight.w500,
  //               ),
  //             ),
  //             const Spacer(),
  //             TextButton(
  //               onPressed: widget.onClearFilters,
  //               child: Text(
  //                 'Clear All',
  //                 style: TextStyle(
  //                   color: AppTheme.lightTheme.colorScheme.primary,
  //                   fontSize: 12.sp,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 1.h),
  //         Wrap(
  //           spacing: 2.w,
  //           runSpacing: 1.h,
  //           children: widget.activeFilters.map((filter) {
  //             return Container(
  //               padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
  //               decoration: BoxDecoration(
  //                 color: AppTheme.lightTheme.colorScheme.primary
  //                     .withValues(alpha: 0.1),
  //                 borderRadius: BorderRadius.circular(20),
  //                 border: Border.all(
  //                   color: AppTheme.lightTheme.colorScheme.primary
  //                       .withValues(alpha: 0.3),
  //                 ),
  //               ),
  //               child: Row(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   Text(
  //                     filter,
  //                     style: TextStyle(
  //                       color: AppTheme.lightTheme.colorScheme.primary,
  //                       fontSize: 12.sp,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   SizedBox(width: 1.w),
  //                   GestureDetector(
  //                     onTap: () {
  //                       // Remove specific filter
  //                     },
  //                     child: CustomIconWidget(
  //                       iconName: 'close',
  //                       color: AppTheme.lightTheme.colorScheme.primary,
  //                       size: 16,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildRecentSearches() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 1.h),
            child: Text(
              'Recent Searches',
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...(_recentSearches.map((search) {
            return ListTile(
              dense: true,
              leading: CustomIconWidget(
                iconName: 'history',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
              title: Text(
                search,
                style: AppTheme.lightTheme.textTheme.bodyMedium,
              ),
              onTap: () {
                widget.searchController.text = search;
                widget.onSearchChanged(search);
                _searchFocusNode.unfocus();
              },
            );
          }).toList()),
        ],
      ),
    );
  }
}
