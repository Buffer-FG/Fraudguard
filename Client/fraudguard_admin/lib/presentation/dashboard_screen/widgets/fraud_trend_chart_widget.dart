import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FraudTrendChartWidget extends StatefulWidget {
  const FraudTrendChartWidget({Key? key}) : super(key: key);

  @override
  State<FraudTrendChartWidget> createState() => _FraudTrendChartWidgetState();
}

class _FraudTrendChartWidgetState extends State<FraudTrendChartWidget> {
  int selectedPeriod = 0; // 0: 7 days, 1: 30 days, 2: 90 days

  final List<String> periods = ['7 Days', '30 Days', '90 Days'];

  final List<List<FlSpot>> chartData = [
    // 7 days data
    [
      FlSpot(0, 2.1),
      FlSpot(1, 3.2),
      FlSpot(2, 1.8),
      FlSpot(3, 4.5),
      FlSpot(4, 3.1),
      FlSpot(5, 5.2),
      FlSpot(6, 4.8),
    ],
    // 30 days data (showing every 5th day)
    [
      FlSpot(0, 2.5),
      FlSpot(5, 3.8),
      FlSpot(10, 2.2),
      FlSpot(15, 4.1),
      FlSpot(20, 3.9),
      FlSpot(25, 5.5),
      FlSpot(30, 4.2),
    ],
    // 90 days data (showing every 15th day)
    [
      FlSpot(0, 3.2),
      FlSpot(15, 2.8),
      FlSpot(30, 4.5),
      FlSpot(45, 3.7),
      FlSpot(60, 5.1),
      FlSpot(75, 4.3),
      FlSpot(90, 3.9),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppTheme.lightTheme.colorScheme.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Fraud Detection Trends',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                CustomIconWidget(
                  iconName: 'timeline',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 20,
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Container(
              height: 6.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: List.generate(periods.length, (index) {
                  final isSelected = selectedPeriod == index;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedPeriod = index;
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.all(1.w),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.lightTheme.colorScheme.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            periods[index],
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: isSelected
                                  ? AppTheme.lightTheme.colorScheme.onPrimary
                                  : AppTheme
                                      .lightTheme.colorScheme.onSurfaceVariant,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 3.h),
            Container(
              height: 25.h,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.3),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: selectedPeriod == 0
                            ? 1
                            : (selectedPeriod == 1 ? 5 : 15),
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              '${value.toInt()}',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              '${value.toStringAsFixed(1)}%',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                color: AppTheme
                                    .lightTheme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline
                          .withValues(alpha: 0.3),
                    ),
                  ),
                  minX: 0,
                  maxX:
                      selectedPeriod == 0 ? 6 : (selectedPeriod == 1 ? 30 : 90),
                  minY: 0,
                  maxY: 6,
                  lineBarsData: [
                    LineChartBarData(
                      spots: chartData[selectedPeriod],
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.lightTheme.colorScheme.primary,
                          AppTheme.lightTheme.colorScheme.primary
                              .withValues(alpha: 0.7),
                        ],
                      ),
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) {
                          return FlDotCirclePainter(
                            radius: 4,
                            color: AppTheme.lightTheme.colorScheme.primary,
                            strokeWidth: 2,
                            strokeColor:
                                AppTheme.lightTheme.colorScheme.surface,
                          );
                        },
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.lightTheme.colorScheme.primary
                                .withValues(alpha: 0.3),
                            AppTheme.lightTheme.colorScheme.primary
                                .withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
