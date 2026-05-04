import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProgressData {
  const ProgressData({required this.weights, required this.targetWeight});
  final List<double> weights;
  final double targetWeight;
}

final progressProvider = FutureProvider<ProgressData>((ref) async {
  await Future<void>.delayed(const Duration(milliseconds: 300));
  return const ProgressData(
    weights: [82, 81.5, 80.9, 80.2, 79.7, 79.1, 78.8],
    targetWeight: 74,
  );
});
