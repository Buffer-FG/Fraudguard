import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/app_export.dart';

class TimelineTab extends StatefulWidget {
  final Map<String, dynamic> userData;

  const TimelineTab({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<TimelineTab> createState() => _TimelineTabState();
}

class _TimelineTabState extends State<TimelineTab> {
  int? expandedIndex;

  @override
  Widget build(BuildContext context) {
    final timelineEvents = (widget.userData['timelineEvents'] as List)
        .cast<Map<String, dynamic>>();

    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Suspicious Activity Timeline',
            style: AppTheme.lightTheme.textTheme.titleMedium,
          ),
          SizedBox(height: 2.h),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: timelineEvents.length,
            itemBuilder: (context, index) {
              final event = timelineEvents[index];
              final isLast = index == timelineEvents.length - 1;
              return _buildTimelineItem(event, index, isLast);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(
      Map<String, dynamic> event, int index, bool isLast) {
    final eventType = event['type'] as String;
    final eventData = _getEventTypeData(eventType);
    final isExpanded = expandedIndex == index;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: eventData['color'].withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: eventData['color'],
                    width: 2,
                  ),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: eventData['icon'],
                    color: eventData['color'],
                    size: 20,
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: isExpanded ? 20.h : 10.h,
                  color: AppTheme.lightTheme.colorScheme.outline,
                ),
            ],
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  expandedIndex = isExpanded ? null : index;
                });
              },
              child: Card(
                margin: EdgeInsets.only(bottom: 2.h),
                child: Padding(
                  padding: EdgeInsets.all(4.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              event['title'] as String,
                              style: AppTheme.lightTheme.textTheme.titleSmall,
                            ),
                          ),
                          CustomIconWidget(
                            iconName:
                                isExpanded ? 'expand_less' : 'expand_more',
                            color: AppTheme
                                .lightTheme.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        _formatDateTime(event['timestamp'] as String),
                        style:
                            AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                          color:
                              AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        event['description'] as String,
                        style: AppTheme.lightTheme.textTheme.bodyMedium,
                      ),
                      if (isExpanded) ...[
                        SizedBox(height: 2.h),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(3.w),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppTheme.lightTheme.colorScheme.outline,
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Detailed Information',
                                style: AppTheme.lightTheme.textTheme.labelMedium
                                    ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 1.h),
                              ..._buildDetailedInfo(event),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildDetailedInfo(Map<String, dynamic> event) {
    final details = event['details'] as Map<String, dynamic>? ?? {};
    final widgets = <Widget>[];

    details.forEach((key, value) {
      widgets.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0.5.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 25.w,
                child: Text(
                  key,
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  value.toString(),
                  style: AppTheme.dataTextStyle(isLight: true, fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      );
    });

    return widgets;
  }

  Map<String, dynamic> _getEventTypeData(String eventType) {
    switch (eventType.toLowerCase()) {
      case 'login':
        return {
          'color': AppTheme.lightTheme.colorScheme.primary,
          'icon': 'login',
        };
      case 'geolocation':
        return {
          'color': AppTheme.warningLight,
          'icon': 'location_on',
        };
      case 'transaction':
        return {
          'color': AppTheme.lightTheme.colorScheme.error,
          'icon': 'payment',
        };
      case 'device':
        return {
          'color': Color(0xFF9C27B0),
          'icon': 'devices',
        };
      case 'security':
        return {
          'color': AppTheme.lightTheme.colorScheme.error,
          'icon': 'security',
        };
      default:
        return {
          'color': AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          'icon': 'event',
        };
    }
  }

  String _formatDateTime(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}/${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }
}
