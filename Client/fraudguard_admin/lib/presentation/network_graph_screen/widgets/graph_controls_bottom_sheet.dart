import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class GraphControlsBottomSheet extends StatefulWidget {
  final String selectedLayout;
  final List<String> selectedNodeTypes;
  final String selectedRiskLevel;
  final String searchQuery;
  final Function(String) onLayoutChanged;
  final Function(List<String>) onNodeTypesChanged;
  final Function(String) onRiskLevelChanged;
  final Function(String) onSearchChanged;
  final VoidCallback onResetGraph;
  final VoidCallback onFitToScreen;

  const GraphControlsBottomSheet({
    Key? key,
    required this.selectedLayout,
    required this.selectedNodeTypes,
    required this.selectedRiskLevel,
    required this.searchQuery,
    required this.onLayoutChanged,
    required this.onNodeTypesChanged,
    required this.onRiskLevelChanged,
    required this.onSearchChanged,
    required this.onResetGraph,
    required this.onFitToScreen,
  }) : super(key: key);

  @override
  State<GraphControlsBottomSheet> createState() =>
      _GraphControlsBottomSheetState();
}

class _GraphControlsBottomSheetState extends State<GraphControlsBottomSheet> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController(text: widget.searchQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.h,
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          SizedBox(height: 2.h),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchSection(),
                  SizedBox(height: 3.h),
                  _buildLayoutSection(),
                  SizedBox(height: 3.h),
                  _buildNodeTypeFilters(),
                  SizedBox(height: 3.h),
                  _buildRiskLevelFilters(),
                  SizedBox(height: 3.h),
                  _buildActionButtons(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Graph Controls',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline,
                width: 1,
              ),
            ),
            child: Center(
              child: CustomIconWidget(
                iconName: 'close',
                color: AppTheme.lightTheme.colorScheme.onSurface,
                size: 4.w,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Search Nodes',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        TextField(
          controller: _searchController,
          onChanged: widget.onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Search by name, email, or ID...',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'search',
                color: AppTheme.lightTheme.colorScheme.onSurface
                    .withValues(alpha: 0.6),
                size: 5.w,
              ),
            ),
            suffixIcon: _searchController.text.isNotEmpty
                ? GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      widget.onSearchChanged('');
                    },
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: CustomIconWidget(
                        iconName: 'clear',
                        color: AppTheme.lightTheme.colorScheme.onSurface
                            .withValues(alpha: 0.6),
                        size: 5.w,
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }

  Widget _buildLayoutSection() {
    final layouts = ['Force-Directed', 'Hierarchical', 'Circular'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Layout Algorithm',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          children: layouts.map((layout) {
            final isSelected = widget.selectedLayout == layout;
            return GestureDetector(
              onTap: () => widget.onLayoutChanged(layout),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.primaryColor
                      : AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.primaryColor
                        : AppTheme.lightTheme.colorScheme.outline,
                  ),
                ),
                child: Text(
                  layout,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isSelected
                        ? Colors.white
                        : AppTheme.lightTheme.colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNodeTypeFilters() {
    final nodeTypes = ['User', 'IP', 'Device', 'Email'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Node Types',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          children: nodeTypes.map((type) {
            final isSelected = widget.selectedNodeTypes.contains(type);
            return GestureDetector(
              onTap: () {
                final updatedTypes =
                    List<String>.from(widget.selectedNodeTypes);
                if (isSelected) {
                  updatedTypes.remove(type);
                } else {
                  updatedTypes.add(type);
                }
                widget.onNodeTypesChanged(updatedTypes);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1)
                      : AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.primaryColor
                        : AppTheme.lightTheme.colorScheme.outline,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected)
                      Padding(
                        padding: EdgeInsets.only(right: 1.w),
                        child: CustomIconWidget(
                          iconName: 'check',
                          color: AppTheme.lightTheme.primaryColor,
                          size: 3.w,
                        ),
                      ),
                    Text(
                      type,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: isSelected
                            ? AppTheme.lightTheme.primaryColor
                            : AppTheme.lightTheme.colorScheme.onSurface,
                        fontWeight:
                            isSelected ? FontWeight.w500 : FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRiskLevelFilters() {
    final riskLevels = ['All', 'High', 'Medium', 'Low'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Risk Level',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppTheme.lightTheme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          children: riskLevels.map((level) {
            final isSelected = widget.selectedRiskLevel == level;
            return GestureDetector(
              onTap: () => widget.onRiskLevelChanged(level),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppTheme.lightTheme.primaryColor
                      : AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? AppTheme.lightTheme.primaryColor
                        : AppTheme.lightTheme.colorScheme.outline,
                  ),
                ),
                child: Text(
                  level,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: isSelected
                        ? Colors.white
                        : AppTheme.lightTheme.colorScheme.onSurface,
                    fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: widget.onResetGraph,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'refresh',
                      color: Colors.white,
                      size: 4.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Reset Graph',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 3.w),
            Expanded(
              child: ElevatedButton(
                onPressed: widget.onFitToScreen,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomIconWidget(
                      iconName: 'fit_screen',
                      color: Colors.white,
                      size: 4.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Fit to Screen',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
