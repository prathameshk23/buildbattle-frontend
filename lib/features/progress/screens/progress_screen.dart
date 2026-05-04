import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/loading_shimmer.dart';
import '../providers/progress_provider.dart';
import '../widgets/streak_badge_row.dart';
import '../widgets/weekly_macro_chart.dart';
import '../widgets/weight_chart.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(progressProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: data.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(20),
          child: LoadingShimmer(height: 500),
        ),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
        data: (data) => ListView(
          padding: const EdgeInsets.all(20),
          children:
              [
                    WeightChart(
                      weights: data.weights,
                      target: data.targetWeight,
                    ),
                    const SizedBox(height: 14),
                    const WeeklyMacroChart(),
                    const SizedBox(height: 14),
                    const StreakBadgeRow(),
                  ]
                  .animate(interval: 50.ms)
                  .fadeIn(duration: 300.ms)
                  .slideY(begin: 0.06),
        ),
      ),
    );
  }
}
