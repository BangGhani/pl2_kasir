import 'package:flutter/material.dart';

//Template Warna Default
class AppColors {
  static const Color primary = Color(0xFF00AD48);
  static const Color scaffoldBackground = Color(0xFFFFFFFF);
  static const Color scaffoldWithBoxBackground = Color(0xFFF7F7F7);
  static const Color cardColor = Color(0xFFF2F2F2);
  static const Color coloredBackground = Color(0xFFE4F8EA);
  static const Color placeholder = Color(0xFF8B8B97);
  static const Color textInputBackground = Color(0xFFF7F7F7);
  static const Color separator = Color(0xFFFAFAFA);
  static const Color gray = Color(0xFFE1E1E1);
}

//Shortcut properti
class AppDefaults {
  static const double radius = 15;
  static const double margin = 15;
  static const double padding = 15;
  //Border Radius
  static BorderRadius borderRadius = BorderRadius.circular(radius);
  //
  static BorderRadius bottomSheetRadius = const BorderRadius.only(
    topLeft: Radius.circular(radius),
    topRight: Radius.circular(radius),
  );
  //
  static BorderRadius topSheetRadius = const BorderRadius.only(
    bottomLeft: Radius.circular(radius),
    bottomRight: Radius.circular(radius),
  );
  //
  static List<BoxShadow> boxShadow = [
    BoxShadow(
      blurRadius: 10,
      spreadRadius: 0,
      offset: const Offset(0, 2),
      color: Colors.black.withOpacity(0.04),
    ),
  ];
  static Duration duration = const Duration(milliseconds: 300);
}

//Default Icon
class AppIcons {
  static const add = 'assets/icons/add.svg';
  static const addRounded = 'assets/icons/add_rounded.svg';
  static const appleIconRounded = 'assets/icons/apple_icon_rounded.svg';
  static const appleIcon = 'assets/icons/apple_icon.svg';
  static const eye = 'assets/icons/eye.svg';
  static const arrowBackward = 'assets/icons/arrow_backward.svg';
  static const arrowForward = 'assets/icons/arrow_forward.svg';
  static const cart = 'assets/icons/cart.svg';
  static const dashboardIcon = 'assets/icons/dashboard_icon.svg';
  static const facebookIcon = 'assets/icons/facebook_icon.svg';
  static const googleIconRounded = 'assets/icons/google_icon_rounded.svg';
  static const googleIcon = 'assets/icons/google_icon.svg';
  static const home = 'assets/icons/home.svg';
  static const location = 'assets/icons/location.svg';
  static const menu = 'assets/icons/menu.svg';
  static const profile = 'assets/icons/profile.svg';
  static const save = 'assets/icons/save.svg';
  static const search = 'assets/icons/search.svg';
  static const shoppingBag = 'assets/icons/shopping_bag.svg';
  static const edit = 'assets/icons/edit.svg';
  static const deleteOutline = 'assets/icons/delete_outline.svg';
  static const twitterIcon = 'assets/icons/twitter_icon.svg';
  static const sidebarIcon = 'assets/icons/side_bar_icon.svg';
  static const heart = 'assets/icons/heart.svg';
  static const heartActive = 'assets/icons/heart_active.svg';
  static const heartOutlined = 'assets/icons/heart_outlined.svg';
  static const addQuantity = 'assets/icons/add_quantity.svg';
  static const removeQuantity = 'assets/icons/remove_quantity.svg';
  static const shoppingCart = 'assets/icons/shopping_cart.svg';
  static const delete = 'assets/icons/delete.svg';
  static const paypal = 'assets/icons/paypal.svg';
  static const cashOnDelivery = 'assets/icons/cash_on_delivery.svg';
  static const masterCard = 'assets/icons/master_card.svg';
  static const filter = 'assets/icons/filter.svg';
  static const searchTileArrow = 'assets/icons/search_tile_arrow.svg';
  static const homeProfile = 'assets/icons/home_profile.svg';
  static const truckIcon = 'assets/icons/truck_icon.svg';
  static const voucher = 'assets/icons/voucher.svg';
  static const reply = 'assets/icons/reply.svg';
  static const right = 'assets/icons/right.svg';
  static const profilePerson = 'assets/icons/profile_person.svg';
  static const profileNotification = 'assets/icons/profile_notification.svg';
  static const profilePayment = 'assets/icons/profile_payment.svg';
  static const profileSetting = 'assets/icons/profile_setting.svg';
  static const profileLogout = 'assets/icons/profile_logout.svg';
  static const orderConfirmed = 'assets/icons/order_confirm.svg';
  static const orderDelivered = 'assets/icons/order_delivered.svg';
  static const orderProcessing = 'assets/icons/order_processing.svg';
  static const orderShipped = 'assets/icons/order_shipped.svg';
  static const contactPhone = 'assets/icons/contact_phone.svg';
  static const contactEmail = 'assets/icons/contact_email.svg';
  static const contactMap = 'assets/icons/contact_map.svg';
  static const cardAdd = 'assets/icons/card_add.svg';
}

//Gambar Online
class AppImages {
  static const roundedLogo = 'https://i.imgur.com/9EsY2t6.png';

  /* <---- Homepage banner -----> */
  static const homePageBanner = 'https://i.imgur.com/8hBIsS5.png';

  /* <---- Image used on unknown page -----> */
  static const illustrations404 = 'https://i.imgur.com/SGTzEiC.png';

  /* <---- Other Illustrations -----> */
  static const numberVerfication = 'https://i.imgur.com/tCCmY3I.png';
  static const verified = 'https://i.imgur.com/vF1jB6b.png';

  /* <---- Coupon Backgrounds -----> */
  static const couponBackgrounds = [
    'assets/images/coupon_background_1.png',
    'assets/images/coupon_background_2.png',
    'assets/images/coupon_background_3.png',
    'assets/images/coupon_background_4.png',
  ];
}
