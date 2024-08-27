// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, prefer_if_null_operators

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../Api/config.dart';
import '../Api/data_store.dart';
import '../model/search_info.dart';
import 'package:http/http.dart' as http;

class SearchController extends GetxController implements GetxService {
  TextEditingController search = TextEditingController();

  List<SearchInfo> searchData = [];
  bool isLoading = false;

  String searchText = "";

  changeValueUpdate(String value) {
    searchText = value;
    update();
  }

  getSearchData({String? countryId}) async {
    searchData.clear();
    print("countryId {$countryId}");
    try {
      Map map = {
        "keyword": search.text,
        "uid": getData.read("UserLogin")["id"].toString(),
        "country_id": countryId,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.searchApi);
      print(uri);
      print(map);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );

      print("-----HELLOO ${response.statusCode}");

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("RESULT---- ${result}");
        for (var element in result["search_propety"]) {
          searchData.add(SearchInfo.fromJson(element));
        }
        // searchInfo = SearchInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
