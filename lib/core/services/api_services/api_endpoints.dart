class ApiEndpoints {
  // Base route segments
  static const String user = 'User';
  static const String product = 'Products';
  static const String favProduct = 'me/favorites';
  static const String category = 'Categories';
  static const String banner = 'Banners';
  static const String activeBanners = 'Banners/active';
  static const String productSearch = 'Products/paginated/';
  static const String categorySearch = 'Categories/paginated/';
  static const String favSearch = 'favorites/paginated/';
  static const String userInfo = 'me';

  // Specific endpoints
  static String userById(int id) => 'User/$id';
  static String productById(int id) => 'Products/$id';
  static String categoryById(int id) => 'Categories/$id';
  static String bannerById(int id) => 'Banners/$id';
  static String addtoFavById(int id) => 'favorites/$id';

  // Auth
  static const String register = 'Authentication/register';
  static const String login = 'Authentication/login';
  static const String refreshToken = 'Authentication/refresh-token';
  static const String logout = 'Authentication/logout';
}
