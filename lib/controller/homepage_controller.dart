// ignore_for_file: avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings, prefer_typing_uninitialized_variables, prefer_if_null_operators

import 'dart:convert';

import 'package:get/get.dart';
import '../Api/config.dart';
import '../Api/data_store.dart';
import '../model/catwise_info.dart';
import '../model/favourite_info.dart';
import '../model/homedata_info.dart';
import '../model/propetydetails_Info.dart';
import '../utils/Custom_widget.dart';
import 'package:http/http.dart' as http;

class HomePageController extends GetxController implements GetxService {
  HomeDatatInfo? homeDatatInfo;
  PropetydetailsInfo? propetydetailsInfo;
  FavouriteInfo? favouriteInfo;

  String searchLocation = "";

  CatWiseInfo? catWiseInfo;

  List<int> selectedIndex = [];

  int currentIndex = 0;
  int catCurrentIndex = 0;
  int ourCurrentIndex = 0;

  bool isLoading = false;
  bool isProperty = false;
  bool isfevorite = false;
  bool isCatWise = false;

  String fevResult = "";
  String fevMsg = "";
  String enquiry = "";
  HomePageController() {
    getHomeDataApi();
    getCatWiseData();
  }

  chnageObjectIndex(int index) {
    currentIndex = 0;
    currentIndex = index;
    update();
  }

  changeCategoryIndex(int index) {
    catCurrentIndex = 0;
    catCurrentIndex = index;
    update();
  }

  changeOurCurrentIndex(int index) {
    ourCurrentIndex = index;
    update();
  }

  getChangeLocation(String location) {
    searchLocation = location;
    Get.back();
    // getHomeDataApi();
    update();
  }

  getHomeDataApi({String? countryId}) async {
    try {
      isLoading = false;
      update();
      Map map = {
        "uid": getData.read("UserLogin") == null
            ? "0"
            : "${getData.read("UserLogin")["id"]}",
        "country_id": countryId,
      };
      print(map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.homeDataApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("----------URl ${uri}");
      print(response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        // print(result.toString());
        homeDatatInfo = HomeDatatInfo.fromJson(result);
      }
      isLoading = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getPropertyDetailsApi({String? id}) async {
    try {
      Map map = {
        "pro_id": id,
        "uid": getData.read("UserLogin") == null
            ? "0"
            : "${getData.read("UserLogin")["id"]}",
      };
      Uri uri = Uri.parse(Config.baseurl + Config.propertyDetails);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("--------URL" + uri.toString());
      print("-MPA" +map.toString());
      print("DDDDDDDDDDDDDDDD" + response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        propetydetailsInfo = PropetydetailsInfo.fromJson(result);
      }
      isProperty = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  addFavouriteList({String? pid, String? propertyType}) async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"].toString(),
        "pid": pid,
        "property_type": propertyType,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.addAndRemoveFavourite);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        fevResult = result["Result"];
        fevMsg = result["ResponseMsg"];
        getPropertyDetailsApi(id: pid);
        getFavouriteList(countryId: getData.read("countryId"));
        showToastMessage(fevMsg);
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getFavouriteList({String? countryId}) async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"].toString(),
        "property_type": "0",
        "country_id": countryId,
      };
      print("AAAAAAAAAAAAAAA" + map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.favouriteList);
      print("URL =${uri}");
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("-------==========" + response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        favouriteInfo = FavouriteInfo.fromJson(result);
      }
      isfevorite = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  getCatWiseData({String? cId, String? countryId}) async {
    try {
      Map map = {
        "cid": cId ?? "0",
        "uid": getData.read("UserLogin") == null
            ? "0"
            : getData.read("UserLogin")["id"].toString(),
        "country_id": countryId,
      };
      Uri uri = Uri.parse(Config.baseurl + Config.catWiseData);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );

      print("-----URL${uri}");
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        catWiseInfo = CatWiseInfo.fromJson(result);
      }
      isCatWise = true;
      update();
    } catch (e) {
      print(e.toString());
    }
  }

  enquirySetApi({String? pId}) async {
    try {
      Map map = {
        "uid": getData.read("UserLogin")["id"].toString(),
        "prop_id": pId,
      };
      print(map.toString());
      Uri uri = Uri.parse(Config.baseurl + Config.enquiry);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("---------------" + response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("+++++++++++++++" + result.toString());
        enquiry = result["Result"];
        // getPropertyDetailsApi(pId);
        showToastMessage(result["ResponseMsg"].toString());
        update();
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
