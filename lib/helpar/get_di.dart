import 'package:get/get.dart';
import '../controller/addproperties_controller.dart';
import '../controller/bookingdetails_controller.dart';
import '../controller/bookrealestate_controller.dart';
import '../controller/coupon_controller.dart';
import '../controller/faq_controller.dart';
import '../controller/gallery_controller.dart';
import '../controller/homepage_controller.dart';
import '../controller/login_controller.dart';
import '../controller/mybooking_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/pagelist_controller.dart';
import '../controller/reviewsummary_controller.dart';
import '../controller/search_controller.dart';
import '../controller/selectcountry_controller.dart';
import '../controller/signup_controller.dart';
import '../controller/wallet_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => HomePageController());
  Get.lazyPut(() => LoginController());
  Get.lazyPut(() => SignUpController());
  Get.lazyPut(() => AddPropertiesController());
  Get.lazyPut(() => BookingDetailsController());
  Get.lazyPut(() => BookrealEstateController());
  Get.lazyPut(() => CouponController());
  Get.lazyPut(() => FaqController());
  Get.lazyPut(() => MyBookingController());
  Get.lazyPut(() => NotificationController());
  Get.lazyPut(() => PageListController());
  Get.lazyPut(() => ReviewSummaryController());
  Get.lazyPut(() => SearchController());
  Get.lazyPut(() => WalletController());
  Get.lazyPut(() => GalleryController());
  Get.lazyPut(() => SelectCountryController());
}
