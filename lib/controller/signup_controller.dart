// ignore_for_file: avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api/config.dart';
import '../Api/data_store.dart';
import '../model/routes_helper.dart';
import '../screen/resetpassword_screen.dart';
import '../utils/Custom_widget.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends GetxController implements GetxService {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController referralCode = TextEditingController();
  bool showPassword = true;
  bool chack = false;
  int currentIndex = 0;
  String userMessage = "";
  String resultCheck = "";

  String signUpMsg = "";

  showOfPassword() {
    showPassword = !showPassword;
    update();
  }

  checkTermsAndCondition(bool? newbool) {
    chack = newbool ?? false;
    update();
  }

  cleanFild() {
    name.text = "";
    email.text = "";
    number.text = "";
    password.text = "";
    referralCode.text = "";
    chack = false;
    update();
  }

  changeIndex(int index) {
    currentIndex = index;
    update();
  }

  checkMobileNumber(String cuntryCode) async {
    try {
      Map map = {
        "mobile": number.text,
        "ccode": cuntryCode,
      };
      print(Config.baseurl + Config.mobileChack);
      Uri uri = Uri.parse(Config.baseurl + Config.mobileChack);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        userMessage = result["ResponseMsg"];
        resultCheck = result["Result"];
        print("MMMMMMMMMMMMMMMMMM" + userMessage);
        if (resultCheck == "true") {
          sendOTP(number.text, cuntryCode);
          Get.toNamed(Routes.otpScreen, arguments: {
            "number": number.text,
            "cuntryCode": cuntryCode,
            "route": "signUpScreen",
          });
        }
        showToastMessage(userMessage);
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  checkMobileInResetPassword({String? number, String? cuntryCode}) async {
    try {
      Map map = {
        "mobile": number,
        "ccode": cuntryCode,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.mobileChack);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        userMessage = result["ResponseMsg"];
        resultCheck = result["Result"];
        if (resultCheck == "false") {
          sendOTP(number ?? "", cuntryCode ?? "");
          Get.toNamed(Routes.otpScreen, arguments: {
            "number": number,
            "cuntryCode": cuntryCode,
            "route": "resetScreen",
          });
        } else {
          showToastMessage('Invalid Mobile Number');
        }
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  setUserApiData(String cuntryCode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      Map map = {
        "name": name.text,
        "email": email.text,
        "mobile": number.text,
        "ccode": cuntryCode,
        "password": password.text
      };
      Uri uri = Uri.parse(Config.baseurl + Config.registerUser);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        await prefs.setBool('Firstuser', true);
        signUpMsg = result["ResponseMsg"];
        showToastMessage(signUpMsg);
        save("UserLogin", result["UserLogin"]);
        OneSignal.shared.sendTag("user_id", getData.read("UserLogin")["id"]);
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  editProfileApi({String? name, String? password, String? email,String? gender}) async {
    try {
      Map map = {
        "name": name,
        "uid": getData.read("UserLogin")["id"].toString(),
        "password": password,
        "email": email,
        "gender": gender,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.editProfileApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("MAP ${map}");
      print("URL ${uri}");
      print("RESPONSE ${response.body}");
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        save("UserLogin", result["UserLogin"]);
      }
      Get.back();
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
