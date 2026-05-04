class FoodItem {
  const FoodItem({
    required this.name,
    required this.brand,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
    this.servingG = 100,
    this.confidence,
    this.notes,
  });

  final String name;
  final String brand;
  final int kcal;
  final int protein;
  final int carbs;
  final int fat;
  final double servingG;
  final double? confidence;
  final String? notes;

  factory FoodItem.fromFoodApi(Map<String, dynamic> json) {
    final serving = readNum(json['serving_size_g']) ?? 100;
    final kcal100 = readNum(json['kcal_per_100g']) ?? 0;
    return FoodItem(
      name: json['name']?.toString() ?? 'Unknown food',
      brand: json['brand']?.toString() ?? 'Food database',
      kcal: (kcal100 * serving / 100).round(),
      protein: ((readNum(json['protein_g']) ?? 0) * serving / 100).round(),
      carbs: ((readNum(json['carbs_g']) ?? 0) * serving / 100).round(),
      fat: ((readNum(json['fat_g']) ?? 0) * serving / 100).round(),
      servingG: serving,
    );
  }

  factory FoodItem.fromScan(Map<String, dynamic> json) => FoodItem(
    name: json['name']?.toString() ?? 'Scanned food',
    brand: 'AI scan',
    kcal: (readNum(json['kcal']) ?? 0).round(),
    protein: (readNum(json['protein_g']) ?? 0).round(),
    carbs: (readNum(json['carbs_g']) ?? 0).round(),
    fat: (readNum(json['fat_g']) ?? 0).round(),
    servingG: readNum(json['serving_g']) ?? 100,
    confidence: readNum(json['confidence']),
    notes: json['notes']?.toString(),
  );

  static double? readNum(Object? value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '');
  }
}
