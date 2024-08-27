// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:get/get.dart';
import '../Api/config.dart';
import '../Api/data_store.dart';
import '../model/country_info.dart';
import 'package:http/http.dart' as http;

class SelectCountryController extends GetxController implements GetxService {
  CountryInfo? countryInfo;

  int? currentIndex;

  bool isLoading = false;

  changeCountryIndex(int index) {
    currentIndex = index;
    save("currentIndex", currentIndex);
    update();
  }

  getCountryApi() async {
    try {
      Map map = {
        "uid": getData.read("UserLogin") == null
            ? "0"
            : "${getData.read("UserLogin")["id"]}",
      };
      Uri uri = Uri.parse(Config.baseurl + Config.allCountry);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        countryInfo = CountryInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
