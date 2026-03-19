// base url and endpoints

abstract class Apis {
  static const baseUrl = 'https://codingarabic.online/api';

  // auth
  static const login = '/login';
  static const register = '/register';

  // home
  static const sliders = '/sliders';
  static const productsBestseller = '/products-bestseller';

  // wishlist
  static const wishlist = '/wishlist';
  static const addToWishlist = '/add-to-wishlist';
  static const removeFromWishlist = '/remove-from-wishlist';

  // cart
  static const cart = '/cart';
  static const addToCart = '/add-to-cart';
  static const removeFromCart = '/remove-from-cart';
  static const updateCart = '/update-cart';
  static const checkout = '/checkout';

  // place order
  static const governorates = '/governorates';
}
