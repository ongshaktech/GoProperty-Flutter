// ignore_for_file: prefer_const_constructors, sort_child_properties_last, must_be_immutable, use_key_in_widget_constructors, unused_element, avoid_print, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import '../Api/config.dart';
import '../Api/data_store.dart';
import '../controller/homepage_controller.dart';
import '../controller/login_controller.dart';
import '../controller/selectcountry_controller.dart';
import '../model/fontfamily_model.dart';
import '../model/routes_helper.dart';
import '../utils/Colors.dart';
import '../utils/Custom_widget.dart';
import '../utils/Dark_lightmode.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.find();
  HomePageController homePageController = Get.find();
  SelectCountryController selectCountryController = Get.find();



  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String cuntryCode = "";

  late ColorNotifire notifire;

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }

  @override
  void initState() {
    super.initState();
    loginController.number.text = "";
    loginController.password.text = "";
    getdarkmodepreviousstate();

  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    getData.read('isLoginBack')
                        ? Get.toNamed(Routes.bottoBarScreen)
                        : Get.back();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.only(left: 10),
                    child: Image.asset(
                      'assets/images/back.png',
                      color: notifire.getwhiteblackcolor,
                    ),
                    decoration: BoxDecoration(
                      color: notifire.getboxcolor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Let's sign you in.".tr,
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: FontFamily.gilroyBold,
                      color: notifire.getwhiteblackcolor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Welcome back. You've been missed!".tr,
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyMedium,
                      color: notifire.getwhiteblackcolor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: IntlPhoneField(
                    countries: [Country(name: "Bangladesh", flag: "🇧🇩", code: "BD", dialCode: "880", nameTranslations: {"sk": "Bangladéš", "se": "Bangladesh", "pl": "Bangladesz", "no": "Bangladesh", "ja": "バングラデシュ", "it": "Bangladesh", "zh": "孟加拉国", "nl": "Bangladesh", "de": "Bangladesch", "fr": "Bangladesh", "es": "Bangladés", "en": "Bangladesh", "pt_BR": "Bangladesh", "sr-Cyrl": "Бангладеш", "sr-Latn":" Bangladeš"," zh_TW":" 孟加拉", "tr": "Bangladeş", "ro": "Bangladesh", "ar":" بنغلاديش", "fa": "بنگلادش", "yue": "孟加拉囯"}, minLength: 10, maxLength: 10)],
                    initialCountryCode: 'BD',
                    keyboardType: TextInputType.number,
                    cursorColor: notifire.getwhiteblackcolor,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: loginController.number,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    dropdownIcon: Icon(
                      Icons.arrow_drop_down,
                      color: notifire.getgreycolor,
                    ),
                    dropdownTextStyle: TextStyle(
                      color: notifire.getgreycolor,
                    ),
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: notifire.getwhiteblackcolor,
                    ),
                    onCountryChanged: (value) {
                      loginController.number.text = '';
                      loginController.password.text = '';
                      print(value.name);
                      print(value.flag);
                      print(value.code);
                      print(value.dialCode);
                      print(value.nameTranslations);
                      print(value.minLength);
                      print(value.maxLength);



                    },
                    onChanged: (value) {
                     print(value.countryCode);
                      cuntryCode = value.countryCode;
                    },
                    decoration: InputDecoration(
                      helperText: null,
                      labelText: "Mobile Number".tr,
                      labelStyle: TextStyle(
                        color: notifire.getgreycolor,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: notifire.getgreycolor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: notifire.getgreycolor,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    invalidNumberMessage: "Please enter your mobile number".tr,
                    // validator: (p0) {
                    //   if (p0!.completeNumber.isEmpty) {
                    //     return 'Please enter your number';
                    //   } else {}
                    //   return null;
                    // },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GetBuilder<LoginController>(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      controller: loginController.password,
                      obscureText: loginController.showPassword,
                      cursorColor: notifire.getwhiteblackcolor,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: notifire.getwhiteblackcolor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password'.tr;
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: greycolor),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        suffixIcon: InkWell(
                          onTap: () {
                            loginController.showOfPassword();
                          },
                          child: !loginController.showPassword
                              ? Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              "assets/images/showpassowrd.png",
                              height: 10,
                              width: 10,
                              color: notifire.getgreycolor,
                            ),
                          )
                              : Padding(
                            padding: const EdgeInsets.all(10),
                            child: Image.asset(
                              "assets/images/HidePassword.png",
                              height: 10,
                              width: 10,
                              color: notifire.getgreycolor,
                            ),
                          ),
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                            "assets/images/Unlock.png",
                            height: 10,
                            width: 10,
                            color: notifire.getgreycolor,
                          ),
                        ),
                        labelText: "Password".tr,
                        labelStyle: TextStyle(
                          color: notifire.getgreycolor,
                        ),
                      ),
                    ),
                  );
                }),
                Row(
                  children: [
                    Expanded(
                      child: GetBuilder<LoginController>(builder: (context) {
                        return Row(
                          children: [
                            Theme(
                              data:
                              ThemeData(unselectedWidgetColor: BlackColor),
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                value: loginController.isChecked,
                                activeColor: BlackColor,
                                onChanged: (value) async {
                                  loginController.changeRememberMe(value);
                                  final prefs =
                                  await SharedPreferences.getInstance();
                                  await prefs.setBool('Remember', true);
                                  // save("Remember", value);
                                },
                              ),
                            ),
                            Text(
                              "Remember me".tr,
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "Gilroy Medium",
                                color: BlackColor,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(Routes.resetPassword);
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(
                          "Forgot Password?".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyBold,
                            color: blueColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                GestButton(
                  Width: Get.size.width,
                  height: 50,
                  buttoncolor: blueColor,
                  margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                  buttontext: "Login".tr,
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyBold,
                    color: WhiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  onclick: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // save('showWallet', true);
                      selectCountryController.getCountryApi();
                      initPlatformState();
                      loginController.getLoginApiData(cuntryCode);
                      // Get.toNamed(Routes.bottoBarScreen);
                    } else {}
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "OR".tr,
                    style: TextStyle(
                      fontFamily: FontFamily.gilroyMedium,
                      color: notifire.getwhiteblackcolor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestButton(
                  Width: Get.size.width,
                  height: 50,
                  margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                  buttoncolor: notifire.getboxcolor,
                  buttontext: "Continue as a Guest".tr,
                  onclick: () {
                    selectCountryController.getCountryApi();
                    Get.toNamed(Routes.selectCountryScreen);
                    save('isLoginBack', true);
                  },
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyBold,
                    color: notifire.getwhiteblackcolor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have an account?".tr,
                          style: TextStyle(
                            fontFamily: FontFamily.gilroyMedium,
                            color: notifire.getgreycolor,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.signUpScreen);
                          },
                          child: Text(
                            "Sign Up".tr,
                            style: TextStyle(
                              color: blueColor,
                              fontFamily: FontFamily.gilroyBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(Config.oneSignel);
    OneSignal.shared
        .promptUserForPushNotificationPermission()
        .then((accepted) {});
    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      print("Accepted OSPermissionStateChanges : $changes");
    });
    // print("--------------__uID : ${getData.read("UserLogin")["id"]}");
  }
}
