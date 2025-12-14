// ignore_for_file: non_constant_identifier_names

String BASE_URL = 'https://filterr.net/api/v1/';

String SIGN_IN = 'auth/login';
String SIGN_UP = 'auth/register';
String LOGOUT = 'auth/register';
String FORGET_PASSWORD = 'auth/forget-password';
String VERIFICATION = 'auth/verify-otp';
String RESEND_CODE = 'auth/resend-Otp';
String RESET_PASSWORD = 'auth/reset-password';
String CHANGE_PASSWORD = 'profile/change-password?_method=put';
String COUNTRY_AND_CODE = 'location/countries';
String CITY_AND_ID = 'location/cities';
String NEIGHBORHOODS = 'location/neighborhoods';
String MY_ORDERS = 'orders/my-orders';
String SOCIAL_NETWORK_POSTS = 'social-network/posts';
String SOCIAL_NETWORK_CATEGORIES = 'social-network/categories';
String ORDER_DETAILS = 'orders/orders';
String SOCIAL_NETWORK_COMMENTS = 'social-network/comments';
String SEND_CHATS(int chatId) {
  return 'chats/chats/$chatId/messages';
}

String POST_COMMENTS(int postId) {
  return 'social-network/posts/$postId/comments';
}

String POST_LIKED(int postId) {
  return 'social-network/posts/$postId/like';
}

String CONFIRM_ORDER = 'orders/confirm-order';
String ADD_ORDER = 'orders/add-order';
String MAP_STORES = 'user/stores';
String MAP_REPRESENTATIVE = 'user/representative';
String CHATS_CHATS = 'chats/chats';
String CHATS_CHAT = 'chats/chat';
String CANCEL_ORDER = 'orders/cancel-order';
String EDIT_PROFILE = 'profile/update-profile?_method=put';
String ADD_SHOP = 'shopowner/add-shop';
String CATEGORIES = 'categories/categories';
String ALL_STORES = 'shopowner/stores';
String ALL_PRODUCTS = 'productivefamilies/products';
String ALL_PRODUCTS_FOR_SHOP = 'shopowner/products';
String ALL_PRODUCTS_FOR_USER = 'user/my-products';
String ADD_PRODUCT = 'productivefamilies/add-product';
String ADD_PRODUCT_FOR_SHOP = 'shopowner/add-product';
String ADD_PRODUCT_FOR_USER = 'user/add-product';
String ADD_RATING = 'rating/add-rating';
String GET_STORES_FOR_USER = 'user/stores';
String PROFILE_SUMMARY = 'shopowner/profile-summary';
String PROFILE_PRODUCTIVE_SUMMARY = "productivefamilies/myprofile";
