class ApiEndpoints {
  // Base route segments
  static const String user = 'User';
  static const String product = 'Products';
  static const String favProduct = 'me/favorites';
  static const String category = 'Categories';
  static const String banner = 'Banners';
  static const String activeBanner = 'Banners/active';

  // Specific endpoints
  static String userById(int id) => 'User/$id';
  static String productById(int id) => 'Products/$id';
  static String categoryById(int id) => 'Categories/$id';
  static String bannerById(int id) => 'Banners/$id';
  // Auth
  static const String login = 'Authentication/login';
  static const String logout = 'Authentication/logout';
}
