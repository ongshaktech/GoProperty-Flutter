// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:get/get.dart';
import '../Api/config.dart';
import '../Api/data_store.dart';
import '../model/coupon_info.dart';
import 'package:http/http.dart' as http;

class CouponController extends GetxController implements GetxService {
  CouponListInfo? couponListInfo;
  bool isLodding = false;

  String copResult = "";

  String couponMsg = "";

  getCouponDataApi() async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"].toString(),
      };
      Uri uri = Uri.parse(Config.baseurl + Config.couponlist);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        couponListInfo = CouponListInfo.fromJson(result);
      }
      isLodding = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  checkCouponDataApi({String? cid}) async {
    try {
      isLodding = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin")["id"].toString(),
        "cid": cid,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.couponCheck);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        copResult = result["Result"];
        couponMsg = result["ResponseMsg"];
      }
      isLodding = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
