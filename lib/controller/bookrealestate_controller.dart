// ignore_for_file: unused_element, unused_field, unnecessary_string_interpolations, unused_local_variable, prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../Api/config.dart';
import '../Api/data_store.dart';
import '../controller/wallet_controller.dart';
import '../model/routes_helper.dart';
import '../utils/Colors.dart';
import '../utils/Custom_widget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookrealEstateController extends GetxController implements GetxService {
  DateRangePickerController controller = DateRangePickerController();
  WalletController walletController = Get.put(WalletController());

  int count = 1;

  DateTime selectedDate = DateTime.now();
  List<DateTime> selectedDates = [];
  String selectedDatees = '';
  String dateCount = '';

  String checkIn = '';
  String checkOut = '';

  String check_in = '';
  String check_out = '';

  String check_in_hour = '';
  String check_out_hour = '';
  int total_hour = 0;
  int check_in_hour_int = 0;
  int check_out_hour_int  = 0;


  String checkDateResult = "true";
  String checkDateMsg = "";

  String rangeCount = '';
  bool visible = false;
  bool chack = false;
  List days = [];

  int currentValue = 0;




  void CheckInHour(v,t){
    check_in_hour=v;
    check_in_hour_int=t;
    update();
  }
  void CheckOutHour(v,t){
    check_out_hour=v;
    check_out_hour_int=t;
    total_hour=check_out_hour_int-check_in_hour_int;

    update();
  }

  SetCheckOutDate(v){
    check_out_hour=v;
    update();
  }

  void onSelectionChanged(DateRangePickerSelectionChangedArgs args) {

    if (args.value is PickerDateRange) {
      days = [];
      checkDateResult = "true";
      checkIn = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)}';
      // ignore: lines_longer_than_80_chars
      checkOut =
          '${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';

      check_in = '${DateFormat('yyyy-MM-dd').format(args.value.startDate)}';
      check_out =
          '${DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate)}';
      String che = checkIn.split('/').first;
      String out = checkOut.split('/').first;

      for (var i = int.parse(che); i <= int.parse(out); i++) {
        days.add(i);
      }
      visible = true;
      update();
    } else if (args.value is DateTime) {
      // selectedDatees = args.value.toString();

      days = [];
      checkDateResult = "true";
      checkIn = '${DateFormat('dd/MM/yyyy').format(args.value)}';
      // ignore: lines_longer_than_80_chars
      checkOut =
      '${DateFormat('dd/MM/yyyy').format(args.value?? args.value)}';

      check_in = '${DateFormat('yyyy-MM-dd').format(args.value)}';
      check_out =
      '${DateFormat('yyyy-MM-dd').format(args.value?? args.value)}';
      String che = checkIn.split('/').first;
      String out = checkOut.split('/').first;

      for (var i = int.parse(che); i <= int.parse(out); i++) {
        days.add(i);
      }
      visible = true;
      update();


      update();
    } else if (args.value is List<DateTime>) {
      dateCount = args.value.length.toString();
      update();
    } else {
      rangeCount = args.value.length.toString();
      update();
    }
  }

  cleanDate() {
    selectedDate = DateTime.now();
    selectedDates = [];
    selectedDatees = '';
    dateCount = '';
    checkIn = '';
    checkOut = '';
    rangeCount = '';
    visible = false;
    chack = false;
    update();
  }

  bookingForSomeOne(bool? newbool) {
    chack = newbool ?? false;
    update();
  }

  changeValue(int value) {
    currentValue = value;
    update();
  }

  checkDateApi({String? pid}) async {
    try {
      Map map = {
        "pro_id": pid,
        "check_in": check_in,
        "check_out": check_out,
        "from_hour_no":GetTimeToNo(check_in_hour),
        "to_hour_no":GetTimeToNo(check_out_hour),
      };
      Uri uri = Uri.parse(Config.baseurl + Config.checDateApi);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("RESPONSE---- ${check_in} =${check_out}-- ${response.body}");
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        checkDateResult = result["Result"];
        checkDateMsg = result["ResponseMsg"];
        if (visible == true) {
          if (checkDateResult == "true") {
            if (chack == true) {
              Get.toNamed(Routes.bookInformetionScreen);
            } else {
              Get.toNamed(Routes.reviewSummaryScreen, arguments: {
                "copAmt": 0,
                "fname": "",
                "lname": "",
                "gender": "",
                "email": "",
                "mobile": "",
                "ccode": "",
                "country": "",
                "couponCode": "",
              });
            }
          } else {
            Fluttertoast.showToast(
              msg: checkDateMsg,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: RedColor,
              textColor: Colors.white,
              fontSize: 14.0,
            );
          }
        } else {
          showToastMessage("Please select date");
        }
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }
  int GetTimeToNo(value){
    var time=0;
    if(value.toString()=="1:00 AM"){time=1;}
    if(value.toString()=="2:00 AM"){time=2;}
    if(value.toString()=="3:00 AM"){time=3;}
    if(value.toString()=="4:00 AM"){time=4;}
    if(value.toString()=="5:00 AM"){time=5;}
    if(value.toString()=="6:00 AM"){time=6;}
    if(value.toString()=="7:00 AM"){time=7;}
    if(value.toString()=="8:00 AM"){time=8;}
    if(value.toString()=="9:00 AM"){time=9;}
    if(value.toString()=="10:00 AM"){time=10;}
    if(value.toString()=="11:00 AM"){time=11;}
    if(value.toString()=="12:00 PM"){time=12;}
    if(value.toString()=="1:00 PM"){time=13;}
    if(value.toString()=="2:00 PM"){time=14;}
    if(value.toString()=="3:00 PM"){time=15;}
    if(value.toString()=="4:00 PM"){time=16;}
    if(value.toString()=="5:00 PM"){time=17;}
    if(value.toString()=="6:00 PM"){time=18;}
    if(value.toString()=="7:00 PM"){time=19;}
    if(value.toString()=="8:00 PM"){time=20;}
    if(value.toString()=="9:00 PM"){time=21;}
    if(value.toString()=="10:00 PM"){time=22;}
    if(value.toString()=="11:00 PM"){time=23;}
    if(value.toString()=="12:00 AM"){time=24;}

    return time;
  }
  bookApiData({
    String? pid,
    String? subtotal,
    String? total,
    String? totalDays,
    String? couAmt,
    String? wallAmt,
    String? transactionId,
    String? addNote,
    String? propPrice,
    String? bookFor,
    String? pMethodId,
    String? tex,
    String? fname,
    String? lname,
    String? gender,
    String? email,
    String? mobile,
    String? ccode,
    String? country,
    String? noGuest,
    int? total_hour,
    String? hour_from,
    String? hour_to,
    int? booking_type,
    int? is_cod,
    int? from_no,
    int? to_no,
  }) async {
    try {
      Map map = {
        "prop_id": pid,
        "uid": getData.read("UserLogin")["id"].toString(),
        "check_in": check_in,
        "check_out": check_out,
        "subtotal": subtotal,
        "total": total,
        "total_day": totalDays,
        "cou_amt": couAmt,
        "wall_amt": wallAmt,
        "transaction_id": transactionId,
        "add_note": addNote ?? "",
        "prop_price": propPrice,
        "book_for": bookFor,
        "p_method_id": pMethodId,
        "tax": tex,
        "fname": fname,
        "lname": lname,
        "gender": gender,
        "email": email,
        "mobile": mobile,
        "ccode": ccode,
        "country": country,
        "noguest": noGuest,
        "total_hour": total_hour,
        "hour_from": hour_from,
        "hour_to": hour_to,
        "booking_type": booking_type,
        "is_cod":is_cod,
        "from_hour_no":from_no,
        "to_hour_no":to_no,
      };
      print("---------+++++++++++${jsonEncode(map)}");
      Uri uri = Uri.parse(Config.baseurl + Config.bookApi);
      print(uri);
      var response = await http.post(
        uri,
        body: jsonEncode(map),
      );
      print("---------===========" + response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print("---------===========" + result.toString());
        String bookresult = result["ResponseMsg"];
        showToastMessage(bookresult);
      }
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
