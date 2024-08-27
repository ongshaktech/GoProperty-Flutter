// ignore_for_file: unused_local_variable, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api/config.dart';
import '../model/payment_info.dart';
import 'package:http/http.dart' as http;

class ReviewSummaryController extends GetxController implements GetxService {
  TextEditingController note = TextEditingController();

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController gmail = TextEditingController();
  TextEditingController mobile = TextEditingController();

  PaymentInfo? paymentInfo;
  bool isLodding = false;

  String pImage = "";
  String pTitle = "";
  String pCity = "";
  String pPrice = "";
  String pHourPrice = "";
  String MinHour = "";
  int ptype = 0;
  String id = "";

  ReviewSummaryController() {
    getpaymentgatewayList();
  }

  cleanOtherDetails() {
    note.text = '';
    firstName.text = '';
    lastName.text = '';
    gmail.text = '';
    mobile.text = '';
    update();
  }

  getpaymentgatewayList() async {
    try {
      Uri uri = Uri.parse(Config.baseurl + Config.paymentgatewayApi);
      var response = await http.post(uri);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        paymentInfo = PaymentInfo.fromJson(result);
        isLodding = true;
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getProductObject(
      {String? pim, String? pti, String? pci, String? pPr,String? hourP,String? min_hour,int? type,  String? pId}) {
    pImage = pim ?? "";
    pTitle = pti ?? "";
    pCity = pci ?? "";
    pPrice = pPr ?? "";
    pHourPrice = hourP ?? "";
    MinHour = min_hour ?? "";
    ptype = type ?? 0;
    id = pId ?? "";
    update();
  }
}
