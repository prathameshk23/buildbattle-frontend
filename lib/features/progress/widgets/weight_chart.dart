import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../shared/widgets/panel_card.dart';

class WeightChart extends StatelessWidget {
  const WeightChart({super.key, required this.weights, required this.target});
  final List<double> weights;
  final double target;

  @override
  Widget build(BuildContext context) {
    return PanelCard(
      child: SizedBox(
        height: 220,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weight trajectory', style: AppTextStyles.displaySub),
            const SizedBox(height: 12),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    getDrawingHorizontalLine: (_) => const FlLine(
                      color: AppColors.borderLight,
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  extraLinesData: ExtraLinesData(
                    horizontalLines: [
                      HorizontalLine(
                        y: target,
                        color: AppColors.accentTeal,
                        dashArray: [6, 4],
                      ),
                    ],
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [
                        for (var i = 0; i < weights.length; i++)
                          FlSpot(i.toDouble(), weights[i]),
                      ],
                      color: AppColors.primaryViolet,
                      barWidth: 3,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, bar, index) =>
                            FlDotCirclePainter(
                              color: AppColors.accentGold,
                              radius: 4,
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
