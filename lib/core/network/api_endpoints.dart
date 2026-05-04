class ApiEndpoints {
  const ApiEndpoints._();

  static const login = '/auth/login';
  static const register = '/auth/register';
  static const refresh = '/auth/refresh';
  static const goals = '/goals';
  static const diary = '/diary';
  static const water = '/water';
  static const steps = '/steps';
  static const foodSearch = '/food/search';
  static const foodScan = '/food/scan';
  static String foodBarcode(String barcode) => '/food/barcode/$barcode';
  static const progressSummary = '/progress/summary';
  static const weightHistory = '/progress/weight-history';
  static const profile = '/profile';
}
