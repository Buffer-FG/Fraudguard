// // import 'package:flutter/material.dart';
// // import 'package:sizer/sizer.dart';

// // import '../../core/app_export.dart';
// // import './widgets/graph_controls_bottom_sheet.dart';
// // import './widgets/graph_export_dialog.dart';
// // import './widgets/graph_legend_widget.dart';
// // import './widgets/network_edge_widget.dart';
// // import './widgets/network_node_widget.dart';
// // import './widgets/node_info_popup.dart';

// // class NetworkGraphScreen extends StatefulWidget {
// //   const NetworkGraphScreen({Key? key}) : super(key: key);

// //   @override
// //   State<NetworkGraphScreen> createState() => _NetworkGraphScreenState();
// // }

// // class _NetworkGraphScreenState extends State<NetworkGraphScreen>
// //     with TickerProviderStateMixin {
// //   late TransformationController _transformationController;
// //   late AnimationController _fabAnimationController;

// //   // Graph state
// //   String _selectedLayout = 'Force-Directed';
// //   List<String> _selectedNodeTypes = ['User', 'IP', 'Device', 'Email'];
// //   String _selectedRiskLevel = 'All';
// //   String _searchQuery = '';
// //   bool _isLegendVisible = false;
// //   String? _selectedNodeId;
// //   String? _highlightedNodeId;
// //   Map<String, dynamic>? _popupNode;
// //   Offset? _popupPosition;
// //   bool _isOfflineMode = false;

// //   // Mock data
// //   final List<Map<String, dynamic>> _mockNodes = [
// //     {
// //       'id': 'user_001',
// //       'type': 'User',
// //       'label': 'John Smith',
// //       'email': 'john.smith@email.com',
// //       'riskLevel': 'High',
// //       'riskScore': 0.85,
// //       'lastActivity': DateTime.now().subtract(const Duration(hours: 2)),
// //       'connectionCount': 12,
// //       'position': const Offset(100, 150),
// //     },
// //     {
// //       'id': 'user_002',
// //       'type': 'User',
// //       'label': 'Sarah Johnson',
// //       'email': 'sarah.j@email.com',
// //       'riskLevel': 'Medium',
// //       'riskScore': 0.65,
// //       'lastActivity': DateTime.now().subtract(const Duration(hours: 5)),
// //       'connectionCount': 8,
// //       'position': const Offset(300, 200),
// //     },
// //     {
// //       'id': 'ip_001',
// //       'type': 'IP',
// //       'label': '192.168.1.100',
// //       'ipAddress': '192.168.1.100',
// //       'location': 'New York, US',
// //       'riskLevel': 'High',
// //       'riskScore': 0.78,
// //       'connectionCount': 15,
// //       'position': const Offset(200, 100),
// //     },
// //     {
// //       'id': 'device_001',
// //       'type': 'Device',
// //       'label': 'iPhone 14',
// //       'deviceType': 'Mobile',
// //       'os': 'iOS 16.4',
// //       'riskLevel': 'Low',
// //       'riskScore': 0.25,
// //       'connectionCount': 3,
// //       'position': const Offset(150, 300),
// //     },
// //     {
// //       'id': 'email_001',
// //       'type': 'Email',
// //       'label': 'temp@domain.com',
// //       'domain': 'domain.com',
// //       'verified': false,
// //       'riskLevel': 'Medium',
// //       'riskScore': 0.55,
// //       'connectionCount': 6,
// //       'position': const Offset(350, 150),
// //     },
// //     {
// //       'id': 'user_003',
// //       'type': 'User',
// //       'label': 'Mike Wilson',
// //       'email': 'mike.w@email.com',
// //       'riskLevel': 'Low',
// //       'riskScore': 0.30,
// //       'lastActivity': DateTime.now().subtract(const Duration(days: 1)),
// //       'connectionCount': 4,
// //       'position': const Offset(250, 350),
// //     },
// //   ];

// //   final List<Map<String, dynamic>> _mockEdges = [
// //     {
// //       'id': 'edge_001',
// //       'source': 'user_001',
// //       'target': 'ip_001',
// //       'type': 'shared_ip',
// //       'strength': 0.8,
// //     },
// //     {
// //       'id': 'edge_002',
// //       'source': 'user_002',
// //       'target': 'ip_001',
// //       'type': 'shared_ip',
// //       'strength': 0.6,
// //     },
// //     {
// //       'id': 'edge_003',
// //       'source': 'user_001',
// //       'target': 'device_001',
// //       'type': 'reused_phone',
// //       'strength': 0.7,
// //     },
// //     {
// //       'id': 'edge_004',
// //       'source': 'user_002',
// //       'target': 'email_001',
// //       'type': 'linked_address',
// //       'strength': 0.5,
// //     },
// //     {
// //       'id': 'edge_005',
// //       'source': 'user_003',
// //       'target': 'device_001',
// //       'type': 'shared_ip',
// //       'strength': 0.4,
// //     },
// //   ];

// //   @override
// //   void initState() {
// //     super.initState();
// //     _transformationController = TransformationController();
// //     _fabAnimationController = AnimationController(
// //       duration: const Duration(milliseconds: 300),
// //       vsync: this,
// //     );
// //     _fabAnimationController.forward();
// //   }

// //   @override
// //   void dispose() {
// //     _transformationController.dispose();
// //     _fabAnimationController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
// //       appBar: _buildAppBar(),
// //       body: Stack(
// //         children: [
// //           _buildGraphView(),
// //           _buildLegendOverlay(),
// //           _buildSyncIndicator(),
// //           if (_popupNode != null && _popupPosition != null)
// //             NodeInfoPopup(
// //               node: _popupNode!,
// //               position: _popupPosition!,
// //               onClose: _closePopup,
// //               onViewDetails: () => _navigateToUserProfile(_popupNode!['id']),
// //             ),
// //         ],
// //       ),
// //       floatingActionButton: _buildFloatingActionButtons(),
// //     );
// //   }

// //   PreferredSizeWidget _buildAppBar() {
// //     return AppBar(
// //       title: Text(
// //         'Network Graph',
// //         style: TextStyle(
// //           fontSize: 18.sp,
// //           fontWeight: FontWeight.w600,
// //           color: AppTheme.lightTheme.colorScheme.onSurface,
// //         ),
// //       ),
// //       backgroundColor: AppTheme.lightTheme.colorScheme.surface,
// //       elevation: 1,
// //       actions: [
// //         IconButton(
// //           onPressed: _toggleLegend,
// //           icon: CustomIconWidget(
// //             iconName: 'info',
// //             color: AppTheme.lightTheme.colorScheme.onSurface,
// //             size: 5.w,
// //           ),
// //         ),
// //         IconButton(
// //           onPressed: _showExportDialog,
// //           icon: CustomIconWidget(
// //             iconName: 'share',
// //             color: AppTheme.lightTheme.colorScheme.onSurface,
// //             size: 5.w,
// //           ),
// //         ),
// //         IconButton(
// //           onPressed: _showControlsBottomSheet,
// //           icon: CustomIconWidget(
// //             iconName: 'tune',
// //             color: AppTheme.lightTheme.colorScheme.onSurface,
// //             size: 5.w,
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   Widget _buildGraphView() {
// //     return InteractiveViewer(
// //       transformationController: _transformationController,
// //       boundaryMargin: EdgeInsets.all(10.w),
// //       minScale: 0.1,
// //       maxScale: 3.0,
// //       onInteractionStart: (details) => _closePopup(),
// //       child: Container(
// //         width: double.infinity,
// //         height: double.infinity,
// //         child: Stack(
// //           children: [
// //             // Edges
// //             ..._getFilteredEdges().map((edge) {
// //               final sourceNode = _getNodeById(edge['source']);
// //               final targetNode = _getNodeById(edge['target']);

// //               if (sourceNode != null && targetNode != null) {
// //                 return NetworkEdgeWidget(
// //                   edge: edge,
// //                   startPoint: sourceNode['position'],
// //                   endPoint: targetNode['position'],
// //                   isHighlighted: _isEdgeHighlighted(edge),
// //                 );
// //               }
// //               return const SizedBox.shrink();
// //             }).toList(),

// //             // Nodes
// //             ..._getFilteredNodes().map((node) {
// //               return Positioned(
// //                 left: (node['position'] as Offset).dx,
// //                 top: (node['position'] as Offset).dy,
// //                 child: NetworkNodeWidget(
// //                   node: node,
// //                   onTap: () => _onNodeTap(node),
// //                   onLongPress: () => _onNodeLongPress(node),
// //                   isSelected: _selectedNodeId == node['id'],
// //                   isHighlighted: _highlightedNodeId == node['id'],
// //                 ),
// //               );
// //             }).toList(),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildLegendOverlay() {
// //     return GraphLegendWidget(
// //       isVisible: _isLegendVisible,
// //       onToggle: _toggleLegend,
// //     );
// //   }

// //   Widget _buildSyncIndicator() {
// //     return AnimatedPositioned(
// //       duration: const Duration(milliseconds: 300),
// //       top: _isOfflineMode ? 10.h : -5.h,
// //       left: 4.w,
// //       right: 4.w,
// //       child: Container(
// //         padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
// //         decoration: BoxDecoration(
// //           color: const Color(0xFFF57C00),
// //           borderRadius: BorderRadius.circular(8),
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             CustomIconWidget(
// //               iconName: 'cloud_off',
// //               color: Colors.white,
// //               size: 4.w,
// //             ),
// //             SizedBox(width: 2.w),
// //             Text(
// //               'Offline Mode - Viewing cached data',
// //               style: TextStyle(
// //                 fontSize: 11.sp,
// //                 color: Colors.white,
// //                 fontWeight: FontWeight.w500,
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _buildFloatingActionButtons() {
// //     return Column(
// //       mainAxisAlignment: MainAxisAlignment.end,
// //       children: [
// //         ScaleTransition(
// //           scale: _fabAnimationController,
// //           child: FloatingActionButton(
// //             heroTag: 'reset',
// //             onPressed: _resetGraph,
// //             backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
// //             child: CustomIconWidget(
// //               iconName: 'refresh',
// //               color: Colors.white,
// //               size: 5.w,
// //             ),
// //           ),
// //         ),
// //         SizedBox(height: 2.h),
// //         ScaleTransition(
// //           scale: _fabAnimationController,
// //           child: FloatingActionButton(
// //             heroTag: 'fit',
// //             onPressed: _fitToScreen,
// //             child: CustomIconWidget(
// //               iconName: 'fit_screen',
// //               color: Colors.white,
// //               size: 5.w,
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }

// //   List<Map<String, dynamic>> _getFilteredNodes() {
// //     return _mockNodes.where((node) {
// //       // Filter by node type
// //       if (!_selectedNodeTypes.contains(node['type'])) return false;

// //       // Filter by risk level
// //       if (_selectedRiskLevel != 'All' &&
// //           node['riskLevel'] != _selectedRiskLevel) {
// //         return false;
// //       }

// //       // Filter by search query
// //       if (_searchQuery.isNotEmpty) {
// //         final query = _searchQuery.toLowerCase();
// //         final label = (node['label'] as String).toLowerCase();
// //         final email = (node['email'] as String? ?? '').toLowerCase();
// //         final id = (node['id'] as String).toLowerCase();

// //         if (!label.contains(query) &&
// //             !email.contains(query) &&
// //             !id.contains(query)) {
// //           return false;
// //         }
// //       }

// //       return true;
// //     }).toList();
// //   }

// //   List<Map<String, dynamic>> _getFilteredEdges() {
// //     final filteredNodeIds =
// //         _getFilteredNodes().map((node) => node['id']).toSet();

// //     return _mockEdges.where((edge) {
// //       return filteredNodeIds.contains(edge['source']) &&
// //           filteredNodeIds.contains(edge['target']);
// //     }).toList();
// //   }

// //   Map<String, dynamic>? _getNodeById(String id) {
// //     try {
// //       return _mockNodes.firstWhere((node) => node['id'] == id);
// //     } catch (e) {
// //       return null;
// //     }
// //   }

// //   bool _isEdgeHighlighted(Map<String, dynamic> edge) {
// //     return _selectedNodeId == edge['source'] ||
// //         _selectedNodeId == edge['target'];
// //   }

// //   void _onNodeTap(Map<String, dynamic> node) {
// //     setState(() {
// //       _selectedNodeId = _selectedNodeId == node['id'] ? null : node['id'];
// //       _highlightedNodeId = null;
// //     });

// //     // Show quick info popup
// //     final RenderBox renderBox = context.findRenderObject() as RenderBox;
// //     final position = renderBox.localToGlobal(node['position']);

// //     setState(() {
// //       _popupNode = node;
// //       _popupPosition = position;
// //     });

// //     // Auto-hide popup after 3 seconds
// //     Future.delayed(const Duration(seconds: 3), () {
// //       if (mounted && _popupNode?['id'] == node['id']) {
// //         _closePopup();
// //       }
// //     });
// //   }

// //   void _onNodeLongPress(Map<String, dynamic> node) {
// //     // Center and highlight node connections
// //     _centerOnNode(node);
// //     setState(() {
// //       _highlightedNodeId = node['id'];
// //       _selectedNodeId = null;
// //     });

// //     // Navigate to detailed view
// //     _navigateToUserProfile(node['id']);
// //   }

// //   void _centerOnNode(Map<String, dynamic> node) {
// //     final position = node['position'] as Offset;
// //     final screenCenter = Offset(50.w, 50.h);
// //     final translation = screenCenter - position;

// //     _transformationController.value = Matrix4.identity()
// //       ..translate(translation.dx, translation.dy)
// //       ..scale(1.5);
// //   }

// //   void _closePopup() {
// //     setState(() {
// //       _popupNode = null;
// //       _popupPosition = null;
// //     });
// //   }

// //   void _toggleLegend() {
// //     setState(() {
// //       _isLegendVisible = !_isLegendVisible;
// //     });
// //   }

// //   void _showControlsBottomSheet() {
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (context) => GraphControlsBottomSheet(
// //         selectedLayout: _selectedLayout,
// //         selectedNodeTypes: _selectedNodeTypes,
// //         selectedRiskLevel: _selectedRiskLevel,
// //         searchQuery: _searchQuery,
// //         onLayoutChanged: (layout) {
// //           setState(() => _selectedLayout = layout);
// //           _applyLayout();
// //         },
// //         onNodeTypesChanged: (types) {
// //           setState(() => _selectedNodeTypes = types);
// //         },
// //         onRiskLevelChanged: (level) {
// //           setState(() => _selectedRiskLevel = level);
// //         },
// //         onSearchChanged: (query) {
// //           setState(() => _searchQuery = query);
// //         },
// //         onResetGraph: () {
// //           Navigator.pop(context);
// //           _resetGraph();
// //         },
// //         onFitToScreen: () {
// //           Navigator.pop(context);
// //           _fitToScreen();
// //         },
// //       ),
// //     );
// //   }

// //   void _showExportDialog() {
// //     showDialog(
// //       context: context,
// //       builder: (context) => GraphExportDialog(
// //         onExportImage: () {
// //           Navigator.pop(context);
// //           _exportGraphImage();
// //         },
// //         onExportData: () {
// //           Navigator.pop(context);
// //           _exportGraphData();
// //         },
// //         onCancel: () => Navigator.pop(context),
// //       ),
// //     );
// //   }

// //   void _applyLayout() {
// //     // Simulate layout algorithm application
// //     // In a real app, this would apply force-directed, hierarchical, or circular layouts
// //     setState(() {
// //       // Layout changes would update node positions
// //     });
// //   }

// //   void _resetGraph() {
// //     setState(() {
// //       _selectedNodeId = null;
// //       _highlightedNodeId = null;
// //       _selectedLayout = 'Force-Directed';
// //       _selectedNodeTypes = ['User', 'IP', 'Device', 'Email'];
// //       _selectedRiskLevel = 'All';
// //       _searchQuery = '';
// //     });

// //     _transformationController.value = Matrix4.identity();
// //     _closePopup();
// //   }

// //   void _fitToScreen() {
// //     _transformationController.value = Matrix4.identity()..scale(0.8);
// //   }

// //   void _exportGraphImage() {
// //     // Simulate image export
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(
// //           'Graph image exported successfully',
// //           style: TextStyle(fontSize: 12.sp),
// //         ),
// //         backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
// //         duration: const Duration(seconds: 2),
// //       ),
// //     );
// //   }

// //   void _exportGraphData() {
// //     // Simulate data export
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(
// //           'Graph data exported successfully',
// //           style: TextStyle(fontSize: 12.sp),
// //         ),
// //         backgroundColor: AppTheme.lightTheme.colorScheme.secondary,
// //         duration: const Duration(seconds: 2),
// //       ),
// //     );
// //   }

// //   void _navigateToUserProfile(String userId) {
// //     Navigator.pushNamed(context, '/user-profile-screen');
// //   }
// // }


// import 'package:flutter/material.dart';
// import 'package:sizer/sizer.dart';

// import '../../core/app_export.dart';
// import './widgets/graph_controls_bottom_sheet.dart';
// import './widgets/graph_export_dialog.dart';
// import './widgets/graph_legend_widget.dart';
// import './widgets/network_edge_widget.dart';
// import './widgets/network_node_widget.dart';
// import './widgets/node_info_popup.dart';

// class NetworkGraphScreen extends StatefulWidget {
//   const NetworkGraphScreen({Key? key}) : super(key: key);

//   @override
//   State<NetworkGraphScreen> createState() => _NetworkGraphScreenState();
// }

// class _NetworkGraphScreenState extends State<NetworkGraphScreen>
//     with TickerProviderStateMixin {
//   late TransformationController _transformationController;
//   late AnimationController _fabAnimationController;

//   // Graph state
//   String _selectedLayout = 'Force-Directed';
//   List<String> _selectedNodeTypes = ['User', 'IP', 'Device', 'Email'];
//   String _selectedRiskLevel = 'All';
//   String _searchQuery = '';
//   bool _isLegendVisible = false;
//   String? _selectedNodeId;
//   String? _highlightedNodeId;
//   Map<String, dynamic>? _popupNode;
//   Offset? _popupPosition;
//   bool _isOfflineMode = false;

//   // Mock data
//   final List<Map<String, dynamic>> _mockNodes = [
//     {
//       'id': 'user_001',
//       'type': 'User',
//       'label': 'John Smith',
//       'email': 'john.smith@email.com',
//       'riskLevel': 'High',
//       'riskScore': 0.85,
//       'lastActivity': DateTime.now().subtract(const Duration(hours: 2)),
//       'connectionCount': 12,
//       'position': const Offset(100, 150),
//     },
//     {
//       'id': 'user_002',
//       'type': 'User',
//       'label': 'Sarah Johnson',
//       'email': 'sarah.j@email.com',
//       'riskLevel': 'Medium',
//       'riskScore': 0.65,
//       'lastActivity': DateTime.now().subtract(const Duration(hours: 5)),
//       'connectionCount': 8,
//       'position': const Offset(300, 200),
//     },
//     {
//       'id': 'ip_001',
//       'type': 'IP',
//       'label': '192.168.1.100',
//       'ipAddress': '192.168.1.100',
//       'location': 'New York, US',
//       'riskLevel': 'High',
//       'riskScore': 0.78,
//       'connectionCount': 15,
//       'position': const Offset(200, 100),
//     },
//     {
//       'id': 'device_001',
//       'type': 'Device',
//       'label': 'iPhone 14',
//       'deviceType': 'Mobile',
//       'os': 'iOS 16.4',
//       'riskLevel': 'Low',
//       'riskScore': 0.25,
//       'connectionCount': 3,
//       'position': const Offset(150, 300),
//     },
//     {
//       'id': 'email_001',
//       'type': 'Email',
//       'label': 'temp@domain.com',
//       'domain': 'domain.com',
//       'verified': false,
//       'riskLevel': 'Medium',
//       'riskScore': 0.55,
//       'connectionCount': 6,
//       'position': const Offset(350, 150),
//     },
//     {
//       'id': 'user_003',
//       'type': 'User',
//       'label': 'Mike Wilson',
//       'email': 'mike.w@email.com',
//       'riskLevel': 'Low',
//       'riskScore': 0.30,
//       'lastActivity': DateTime.now().subtract(const Duration(days: 1)),
//       'connectionCount': 4,
//       'position': const Offset(250, 350),
//     },
//   ];

//   final List<Map<String, dynamic>> _mockEdges = [
//     {
//       'id': 'edge_001',
//       'source': 'user_001',
//       'target': 'ip_001',
//       'type': 'shared_ip',
//       'strength': 0.8,
//     },
//     {
//       'id': 'edge_002',
//       'source': 'user_002',
//       'target': 'ip_001',
//       'type': 'shared_ip',
//       'strength': 0.6,
//     },
//     {
//       'id': 'edge_003',
//       'source': 'user_001',
//       'target': 'device_001',
//       'type': 'reused_phone',
//       'strength': 0.7,
//     },
//     {
//       'id': 'edge_004',
//       'source': 'user_002',
//       'target': 'email_001',
//       'type': 'linked_address',
//       'strength': 0.5,
//     },
//     {
//       'id': 'edge_005',
//       'source': 'user_003',
//       'target': 'device_001',
//       'type': 'shared_ip',
//       'strength': 0.4,
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _transformationController = TransformationController();
//     _fabAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _fabAnimationController.forward();
//   }

//   @override
//   void dispose() {
//     _transformationController.dispose();
//     _fabAnimationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
//       appBar: _buildAppBar(),
//       body: Stack(
//         children: [
//           _buildGraphView(),
//           AnimatedPositioned(
//             duration: const Duration(milliseconds: 300),
//             top: _isLegendVisible ? 12.h : -50.h,
//             right: 4.w,
//             child: GraphLegendWidget(
//               isVisible: _isLegendVisible,
//               onToggle: _toggleLegend,
//             ),
//           ),
//           _buildSyncIndicator(),
//           if (_popupNode != null && _popupPosition != null)
//             NodeInfoPopup(
//               node: _popupNode!,
//               position: _popupPosition!,
//               onClose: _closePopup,
//               onViewDetails: () => _navigateToUserProfile(_popupNode!['id']),
//             ),
//         ],
//       ),
//       floatingActionButton: _buildFloatingActionButtons(),
//     );
//   }

//   PreferredSizeWidget _buildAppBar() {
//     return AppBar(
//       title: Text(
//         'Network Graph',
//         style: TextStyle(
//           fontSize: 18.sp,
//           fontWeight: FontWeight.w600,
//           color: AppTheme.lightTheme.colorScheme.onSurface,
//         ),
//       ),
//       backgroundColor: AppTheme.lightTheme.colorScheme.surface,
//       elevation: 1,
//       actions: [
//         IconButton(
//           onPressed: _toggleLegend,
//           icon: CustomIconWidget(
//             iconName: 'info',
//             color: AppTheme.lightTheme.colorScheme.onSurface,
//             size: 5.w,
//           ),
//         ),
//         IconButton(
//           onPressed: _showExportDialog,
//           icon: CustomIconWidget(
//             iconName: 'share',
//             color: AppTheme.lightTheme.colorScheme.onSurface,
//             size: 5.w,
//           ),
//         ),
//         IconButton(
//           onPressed: _showControlsBottomSheet,
//           icon: CustomIconWidget(
//             iconName: 'tune',
//             color: AppTheme.lightTheme.colorScheme.onSurface,
//             size: 5.w,
//           ),
//         ),
//       ],
//     );
//   }

//   void _toggleLegend() {
//     setState(() {
//       _isLegendVisible = !_isLegendVisible;
//     });
//   }

//   // You may implement these helpers: _buildGraphView, _buildSyncIndicator, _buildFloatingActionButtons, _closePopup, _navigateToUserProfile, _showExportDialog, _showControlsBottomSheet
// }
