// ignore_for_file: prefer_const_constructors

import 'package:get/route_manager.dart';
import '../screen/addproperties_screen.dart';
import '../screen/addwallet/addwallet_screen.dart';
import '../screen/addwallet/referfriend_screen.dart';
import '../screen/addwallet/wallet_screen.dart';
import '../screen/bookinformation_screen.dart';
import '../screen/bookrealestate_screen.dart';
import '../screen/bottombar_screen.dart';
import '../screen/coupons_screen.dart';
import '../screen/e-receipt_screen.dart';
import '../screen/faq_screen.dart';
import '../screen/featured_screen.dart';
import '../screen/gallery_screen.dart';
import '../screen/homesearch_screen.dart';
import '../screen/language_screen.dart';
import '../screen/login_screen.dart';
import '../screen/loream_screen.dart';
import '../screen/message_screen.dart';
import '../screen/mybooking_screen.dart';
import '../screen/notification_screen.dart';
import '../screen/onbording_screen.dart';
import '../screen/otp_screen.dart';
import '../screen/our_recommendation_screen.dart';
import '../screen/profile_screen.dart';
import '../screen/resetpassword_screen.dart';
import '../screen/review_screen.dart';
import '../screen/review_summary.dart';
import '../screen/select_country.dart';
import '../screen/signup_screen.dart';
import '../screen/splesh_screen.dart';
import '../screen/viewdata_screen.dart';
import '../screen/viewprofile_screen.dart';

class Routes {
  static String initial = "/";
  static String onBordingScreen = '/OnBordingScreen';
  static String login = "/Login";
  static String bottoBarScreen = "/BottoBarScreen";
  static String signUpScreen = "/signUpScreen";
  static String otpScreen = '/otpScreen';
  static String resetPassword = "/resetPassword";
  static String viewDataScreen = "/viewDataScreen";
  static String massageScreen = "/massageScren";
  static String profileScreen = "/profileScreen";
  static String galleryScreen = "/galleyScreen";
  static String reviewScreen = "/reviewScreen";
  static String ourRecommendationScreen = "/ourRecommendationScreen";
  static String notificationScreen = "/notificationScreen";
  static String homeSearchScreen = "/homeSearchScreen";
  static String mybookingScreen = "/mybookingScreen";
  static String languageScreen = "/languageScreen";
  static String viewProfileScreen = "/viewProfileScreen";
  static String bookRealEstate = "/bookRealEstate";
  static String bookInformetionScreen = "/bookInformetionScreen";
  static String reviewSummaryScreen = "/reviewSummaryScreen";
  static String couponsScreen = "/couponsScreen";
  static String eReceiptScreen = "/eReceiptScreen";
  static String loreamScreen = "/loreamScreen";
  static String faqScreen = "/faqScreen";
  static String walletScreen = "/walletScreen";
  static String addWalletScreen = "/addWalletScreen";
  static String referFriendScreen = "/referFriendScreen";
  static String featuredScreen = "/featuredScreen";
  static String addPropertiesOne = "/addPropertiesOne";
  static String selectCountryScreen = "/selectCountryScreen";
}

final getPages = [
  GetPage(
    name: Routes.initial,
    page: () => SpleshScreen(),
  ),
  GetPage(
    name: Routes.onBordingScreen,
    page: () => OnBordingScreen(),
  ),
  GetPage(
    name: Routes.login,
    page: () => LoginScreen(),
  ),
  GetPage(
    name: Routes.bottoBarScreen,
    page: () => BottoBarScreen(),
  ),
  GetPage(
    name: Routes.signUpScreen,
    page: () => SignUpScreen(),
  ),
  GetPage(
    name: Routes.otpScreen,
    page: () => OtpScreen(),
  ),
  GetPage(
    name: Routes.resetPassword,
    page: () => ResetPasswordScreen(),
  ),
  GetPage(
    name: Routes.viewDataScreen,
    page: () => ViewDataScreen(),
  ),
  GetPage(
    name: Routes.massageScreen,
    page: () => MassageScreen(),
  ),
  GetPage(
    name: Routes.profileScreen,
    page: () => ProfileScreen(),
  ),
  GetPage(
    name: Routes.galleryScreen,
    page: () => GalleryScreen(),
  ),
  GetPage(
    name: Routes.reviewScreen,
    page: () => ReviewScreen(),
  ),
  GetPage(
    name: Routes.ourRecommendationScreen,
    page: () => OurRecommendationScreen(),
  ),
  GetPage(
    name: Routes.notificationScreen,
    page: () => NotificationScreen(),
  ),
  GetPage(
    name: Routes.homeSearchScreen,
    page: () => HomeSearchScreen(),
  ),
  GetPage(
    name: Routes.mybookingScreen,
    page: () => MyBookingScreen(),
  ),
  GetPage(
    name: Routes.languageScreen,
    page: () => LanguageScreen(),
  ),
  GetPage(
    name: Routes.viewProfileScreen,
    page: () => ViewProfileScreen(),
  ),
  GetPage(
    name: Routes.bookRealEstate,
    page: () => BookRealEstate(),
  ),
  GetPage(
    name: Routes.bookInformetionScreen,
    page: () => BookInformetionScreen(),
  ),
  GetPage(
    name: Routes.reviewSummaryScreen,
    page: () => ReviewSummaryScreen(),
  ),
  GetPage(
    name: Routes.couponsScreen,
    page: () => CouponsScreen(),
  ),
  GetPage(
    name: Routes.eReceiptScreen,
    page: () => EReceiptScreen(),
  ),
  GetPage(
    name: Routes.loreamScreen,
    page: () => Loream(),
  ),
  GetPage(
    name: Routes.faqScreen,
    page: () => FaqScreen(),
  ),
  GetPage(
    name: Routes.walletScreen,
    page: () => WalletScreen(),
  ),
  GetPage(
    name: Routes.addWalletScreen,
    page: () => AddWalletScreen(),
  ),
  GetPage(
    name: Routes.referFriendScreen,
    page: () => ReferFriendScreen(),
  ),
  GetPage(
    name: Routes.featuredScreen,
    page: () => FeaturedScreen(),
  ),
  GetPage(
    name: Routes.addPropertiesOne,
    page: () => AddPropertiesOne(),
  ),
  GetPage(
    name: Routes.selectCountryScreen,
    page: () => SelectCountryScreen(),
  ),
];
