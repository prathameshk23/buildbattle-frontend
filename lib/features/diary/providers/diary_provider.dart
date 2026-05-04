import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../core/network/api_endpoints.dart';
import '../../../core/network/dio_client.dart';
import '../../../shared/models/diary_entry.dart';
import '../../../shared/models/food_item.dart';

final selectedDiaryDateProvider =
    NotifierProvider<SelectedDiaryDateNotifier, DateTime>(
  SelectedDiaryDateNotifier.new,
);

final diaryProvider = AsyncNotifierProvider<DiaryNotifier, List<DiaryEntry>>(
  DiaryNotifier.new,
);

final foodSearchProvider =
    FutureProvider.family<List<FoodItem>, String>((ref, query) async {
  if (query.trim().isEmpty) return const [];
  final dio = ref.read(dioClientProvider).dio;
  final response = await dio.get(ApiEndpoints.foodSearch, queryParameters: {'q': query});
  final rows = (response.data['data'] as List<dynamic>? ?? const []);
  return rows
      .whereType<Map<String, dynamic>>()
      .map(FoodItem.fromFoodApi)
      .toList();
});

class DiaryNotifier extends AsyncNotifier<List<DiaryEntry>> {
  @override
  Future<List<DiaryEntry>> build() async {
    ref.watch(selectedDiaryDateProvider);
    return _load();
  }

  String get _date =>
      DateFormat('yyyy-MM-dd').format(ref.read(selectedDiaryDateProvider));

  Future<List<DiaryEntry>> _load() async {
    final dio = ref.read(dioClientProvider).dio;
    final response = await dio.get(ApiEndpoints.diary, queryParameters: {'date': _date});
    final sections = response.data['data']?['sections'] as Map<String, dynamic>? ?? {};
    return sections.values
        .expand((items) => items is List ? items : const [])
        .whereType<Map<String, dynamic>>()
        .map(DiaryEntry.fromJson)
        .toList();
  }

  Future<void> add(String meal, FoodItem food) async {
    final dio = ref.read(dioClientProvider).dio;
    await dio.post(
      ApiEndpoints.diary,
      data: {
        'date': _date,
        'meal_section': DiaryEntry.sectionKey(meal),
        'food_name': food.name,
        'kcal': food.kcal,
        'protein_g': food.protein,
        'carbs_g': food.carbs,
        'fat_g': food.fat,
        'serving_g': food.servingG,
        'quantity': 1,
      },
    );
    state = AsyncData(await _load());
  }

  Future<void> remove(DiaryEntry entry) async {
    if (entry.id == null) return;
    final dio = ref.read(dioClientProvider).dio;
    await dio.delete('${ApiEndpoints.diary}/${entry.id}');
    state = AsyncData(await _load());
  }

  Future<FoodItem> scanFood({
    required Uint8List bytes,
    required String mimeType,
  }) async {
    final dio = ref.read(dioClientProvider).dio;
    final response = await dio.post(
      ApiEndpoints.foodScan,
      data: {
        'image_base64': base64Encode(bytes),
        'mime_type': mimeType,
      },
    );
    return FoodItem.fromScan(response.data['data'] as Map<String, dynamic>);
  }

  Future<FoodItem> lookupBarcode(String barcode) async {
    final dio = ref.read(dioClientProvider).dio;
    final response = await dio.get(ApiEndpoints.foodBarcode(barcode));
    return FoodItem.fromFoodApi(response.data['data'] as Map<String, dynamic>);
  }
}

class SelectedDiaryDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() => DateTime.now();

  void setDate(DateTime date) => state = date;
}
