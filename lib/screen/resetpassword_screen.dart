// ignore_for_file: prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, unnecessary_string_interpolations, sort_child_properties_last

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/countries.dart';
import '../controller/signup_controller.dart';
import '../model/fontfamily_model.dart';
import '../model/routes_helper.dart';
import '../utils/Colors.dart';
import '../utils/Custom_widget.dart';
import '../utils/Dark_lightmode.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResetPasswordScreen extends StatefulWidget {
  static String verifay = "";

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  SignUpController signUpController = Get.find();

  TextEditingController number = TextEditingController();

  String cuntryCode = "";

  final _formKey = GlobalKey<FormState>();

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
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      body: SafeArea(
        child: SizedBox(
          height: Get.size.height,
          width: Get.size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 10),
                  padding: EdgeInsets.all(15),
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
                  "Reset Password".tr,
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: "Gilroy Bold",
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
                  "Please enter your phone number to request a\npassword reset"
                      .tr,
                  maxLines: 2,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontFamily: "Gilroy Medium",
                    color: notifire.getgreycolor,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: IntlPhoneField(
                    countries: [Country(name: "Bangladesh", flag: "🇧🇩", code: "BD", dialCode: "880", nameTranslations: {"sk": "Bangladéš", "se": "Bangladesh", "pl": "Bangladesz", "no": "Bangladesh", "ja": "バングラデシュ", "it": "Bangladesh", "zh": "孟加拉国", "nl": "Bangladesh", "de": "Bangladesch", "fr": "Bangladesh", "es": "Bangladés", "en": "Bangladesh", "pt_BR": "Bangladesh", "sr-Cyrl": "Бангладеш", "sr-Latn":" Bangladeš"," zh_TW":" 孟加拉", "tr": "Bangladeş", "ro": "Bangladesh", "ar":" بنغلاديش", "fa": "بنگلادش", "yue": "孟加拉囯"}, minLength: 10, maxLength: 10)],
                    initialCountryCode: 'BD',
                    keyboardType: TextInputType.number,
                    cursorColor: notifire.getwhiteblackcolor,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: number,
                    onChanged: (value) {
                      cuntryCode = value.countryCode;
                    },
                    onCountryChanged: (value) {
                      number.text = '';
                    },
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
                    validator: (p0) {
                      if (p0!.completeNumber.isEmpty) {
                        return 'Please enter your number'.tr;
                      } else {}
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GestButton(
                Width: Get.size.width,
                height: 50,
                buttoncolor: blueColor,
                margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                buttontext: "Request OTP".tr,
                style: TextStyle(
                  fontFamily: "Gilroy Bold",
                  color: WhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                onclick: () async {
                  if (_formKey.currentState?.validate() ?? false) {
                    signUpController.checkMobileInResetPassword(
                        number: number.text, cuntryCode: cuntryCode);
                  }
                },
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
                        "You remember your password?".tr,
                        style: TextStyle(
                          fontFamily: FontFamily.gilroyMedium,
                          color: notifire.getgreycolor,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.login);
                        },
                        child: Text(
                          "Log In".tr,
                          style: TextStyle(
                            color: blueColor,
                            fontFamily: FontFamily.gilroyMedium,
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
    );
  }
}

Future<void> sendOTP(
    String phonNumber,
    String cuntryCode,
    ) async {
  await FirebaseAuth.instance.verifyPhoneNumber(
    phoneNumber: '${cuntryCode + phonNumber}',
    verificationCompleted: (PhoneAuthCredential credential) {},
    verificationFailed: (FirebaseAuthException e) {},
    timeout: Duration(seconds: 60),
    codeSent: (String verificationId, int? resendToken) {
      ResetPasswordScreen.verifay = verificationId;
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}
