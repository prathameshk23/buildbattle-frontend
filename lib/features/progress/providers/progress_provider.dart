import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';

class ProgressData {
  const ProgressData({required this.weights, required this.targetWeight});
  final List<double> weights;
  final double targetWeight;
}

final progressProvider = FutureProvider<ProgressData>((ref) async {
  final dio = ref.read(dioClientProvider).dio;
  final responses = await Future.wait([
    dio.get(ApiEndpoints.weightHistory),
    dio.get(ApiEndpoints.goals),
  ]);
  final rows = responses[0].data['data'] as List<dynamic>? ?? const [];
  final goals = responses[1].data['data'] as Map<String, dynamic>? ?? {};
  double read(Object? value, double fallback) =>
      num.tryParse(value?.toString() ?? '')?.toDouble() ?? fallback;
  final weights = rows
      .whereType<Map<String, dynamic>>()
      .map((row) => read(row['weight_kg'], 0))
      .where((value) => value > 0)
      .toList();
  final target = read(goals['target_weight_kg'], weights.isEmpty ? 70 : weights.last);
  return ProgressData(
    weights: weights.isEmpty ? [target] : weights,
    targetWeight: target,
  );
});
