import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/panel_card.dart';

class WeeklyMacroChart extends StatelessWidget {
  const WeeklyMacroChart({super.key});

  @override
  Widget build(BuildContext context) {
    return PanelCard(
      child: SizedBox(
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weekly nutrition', style: AppTextStyles.displaySub),
            const SizedBox(height: 12),
            Expanded(
              child: BarChart(
                BarChartData(
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: 95,
                        color: AppColors.error,
                        strokeWidth: 1,
                      ),
                    ],
                  ),
                  barGroups: List.generate(
                    7,
                    (i) => BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: 45 + i.toDouble() * 2,
                          color: AppColors.primaryViolet,
                          width: 5,
                        ),
                        BarChartRodData(
                          toY: 68 - i.toDouble(),
                          color: AppColors.accentGold,
                          width: 5,
                        ),
                        BarChartRodData(
                          toY: 34 + i.toDouble(),
                          color: AppColors.accentTeal,
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
