// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_interpolation_to_compose_strings, avoid_print, unused_field, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_final_fields, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../controller/bookrealestate_controller.dart';
import '../controller/homepage_controller.dart';
import '../controller/reviewsummary_controller.dart';
import '../controller/wallet_controller.dart';
import '../model/fontfamily_model.dart';
import '../utils/Colors.dart';
import '../utils/Custom_widget.dart';
import '../utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookRealEstate extends StatefulWidget {
  const BookRealEstate({super.key});

  @override
  State<BookRealEstate> createState() => _BookRealEstateState();
}

class _BookRealEstateState extends State<BookRealEstate> {
  BookrealEstateController bookrealEstateController = Get.find();
  HomePageController homePageController = Get.find();
  ReviewSummaryController reviewSummaryController = Get.find();

  WalletController walletController = Get.find();

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

  List<Duration> list = [];

  int count = 1;

  var times=[
    "1:00 AM",
    "2:00 AM",
    "3:00 AM",
    "4:00 AM",
    "5:00 AM",
    "6:00 AM",
    "7:00 AM",
    "8:00 AM",
    "9:00 AM",
    "10:00 AM",
    "11:00 AM",
    "12:00 PM",
    "1:00 PM",
    "2:00 PM",
    "3:00 PM",
    "4:00 PM",
    "5:00 PM",
    "6:00 PM",
    "7:00 PM",
    "8:00 PM",
    "9:00 PM",
    "10:00 PM",
    "11:00 PM",
    "12:00 AM"];

  @override
  void initState() {
    super.initState();

    getdarkmodepreviousstate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<BookrealEstateController>();
  }

  @override
  Widget build(BuildContext contexttop) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    print("^^^^^^^^^^^${walletController.walletInfo?.wallet ?? ""}");
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      appBar: AppBar(
        backgroundColor: notifire.getbgcolor,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back,
            color: notifire.getwhiteblackcolor,
          ),
        ),
        title: Text(
          "Book Real Estate".tr,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontFamily.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: GetBuilder<BookrealEstateController>(builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Text(
                  "Select Date".tr,
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: FontFamily.gilroyBold,
                    color: notifire.getwhiteblackcolor,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: SfDateRangePicker(
                  controller: bookrealEstateController.controller,
                  todayHighlightColor:Color(0xFFeef4ff),
                  onSelectionChanged:
                  bookrealEstateController.onSelectionChanged,
                  selectionMode: reviewSummaryController.ptype==0?DateRangePickerSelectionMode.single:DateRangePickerSelectionMode.range,
                  enablePastDates: false,
                  startRangeSelectionColor:
                  bookrealEstateController.checkDateResult == "true"
                      ? blueColor
                      : RedColor,
                  endRangeSelectionColor:
                  bookrealEstateController.checkDateResult == "true"
                      ? blueColor
                      : RedColor,
                  headerStyle: DateRangePickerHeaderStyle(
                    textStyle: TextStyle(
                      fontFamily: FontFamily.gilroyMedium,
                      color: notifire.getwhiteblackcolor,
                    ),
                  ),
                  initialSelectedRange: PickerDateRange(
                    DateTime.now().subtract(
                      Duration(days: 0),
                    ),
                    DateTime.now().add(
                      const Duration(days: 0),
                    ),
                  ),
                  // backgroundColor: Color(0xFFeef4ff),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFeef4ff),
                  borderRadius: BorderRadius.circular(15),

                ),
              ),
              SizedBox(
                height: 10,
              ),
              reviewSummaryController.ptype==0?Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Check in time".tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: FontFamily.gilroyBold,
                          color: notifire.getwhiteblackcolor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Check out time".tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: FontFamily.gilroyBold,
                          color: notifire.getwhiteblackcolor,
                        ),
                      ),
                    ),
                  ),
                ],
              ):Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Check in".tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: FontFamily.gilroyBold,
                          color: notifire.getwhiteblackcolor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Check out".tr,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: FontFamily.gilroyBold,
                          color: notifire.getwhiteblackcolor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              if (reviewSummaryController.ptype==0) Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: ()async{

                      },
                      child: Container(
                        height: 55,
                        margin: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            DropdownButton(
                              underline: SizedBox(),
                                items: times.map((String e) =>
                                    DropdownMenuItem(
                                      child: Text("${e}"),value: e,
                                    )).toList(),
                                hint: Text("Check in time"),
                                value: bookrealEstateController.check_in_hour==''?null:bookrealEstateController.check_in_hour,
                                onChanged: (v){

                                var hour_num=0;

                                if(v.toString()=="1:00 AM"){hour_num=1;}
                                if(v.toString()=="2:00 AM"){hour_num=2;}
                                if(v.toString()=="3:00 AM"){hour_num=3;}
                                if(v.toString()=="4:00 AM"){hour_num=4;}
                                if(v.toString()=="5:00 AM"){hour_num=5;}
                                if(v.toString()=="6:00 AM"){hour_num=6;}
                                if(v.toString()=="7:00 AM"){hour_num=7;}
                                if(v.toString()=="8:00 AM"){hour_num=8;}
                                if(v.toString()=="9:00 AM"){hour_num=9;}
                                if(v.toString()=="10:00 AM"){hour_num=10;}
                                if(v.toString()=="11:00 AM"){hour_num=11;}
                                if(v.toString()=="12:00 PM"){hour_num=12;}
                                if(v.toString()=="1:00 PM"){hour_num=13;}
                                if(v.toString()=="2:00 PM"){hour_num=14;}
                                if(v.toString()=="3:00 PM"){hour_num=15;}
                                if(v.toString()=="4:00 PM"){hour_num=16;}
                                if(v.toString()=="5:00 PM"){hour_num=17;}
                                if(v.toString()=="6:00 PM"){hour_num=18;}
                                if(v.toString()=="7:00 PM"){hour_num=19;}
                                if(v.toString()=="8:00 PM"){hour_num=20;}
                                if(v.toString()=="9:00 PM"){hour_num=21;}
                                if(v.toString()=="10:00 PM"){hour_num=22;}
                                if(v.toString()=="11:00 PM"){hour_num=23;}
                                if(v.toString()=="12:00 AM"){hour_num=24;}

                              if(bookrealEstateController.check_out_hour_int!=0){
                                if(bookrealEstateController.check_out_hour_int>hour_num){
                                  context.CheckInHour(v,hour_num);
                                }else{
                                  context.CheckInHour(v,hour_num);
                                  bookrealEstateController.SetCheckOutDate("");
                                  Fluttertoast.showToast(msg: "You Can't Select Previous Time");

                                }
                              }else{

                                context.CheckInHour(v,hour_num);
                              }


                       // context.CheckInHour(v,hour_num);
                       // context.CheckOutHour(null,0);

                                print(v);
                                print(hour_num);


                                   }),

                            Image.asset(
                              "assets/images/clock.png",
                              height: 25,
                              width: 25,

                            ),

                          ],
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: notifire.getblackwhitecolor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: ()async{

                      },
                      child: Container(
                        height: 55,
                        margin: EdgeInsets.all(8),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            DropdownButton(
                                underline: SizedBox(),
                                items: times.map((String e) =>
                                    DropdownMenuItem(
                                      child: Text("${e}"),value: e,
                                    )).toList(),
                                hint: Text("Check out time"),
                                value: bookrealEstateController.check_out_hour==''?null:bookrealEstateController.check_out_hour,
                                onChanged: (v){

                                  var hour_num=0;

                                  if(v.toString()=="1:00 AM"){hour_num=1;}
                                  if(v.toString()=="2:00 AM"){hour_num=2;}
                                  if(v.toString()=="3:00 AM"){hour_num=3;}
                                  if(v.toString()=="4:00 AM"){hour_num=4;}
                                  if(v.toString()=="5:00 AM"){hour_num=5;}
                                  if(v.toString()=="6:00 AM"){hour_num=6;}
                                  if(v.toString()=="7:00 AM"){hour_num=7;}
                                  if(v.toString()=="8:00 AM"){hour_num=8;}
                                  if(v.toString()=="9:00 AM"){hour_num=9;}
                                  if(v.toString()=="10:00 AM"){hour_num=10;}
                                  if(v.toString()=="11:00 AM"){hour_num=11;}
                                  if(v.toString()=="12:00 PM"){hour_num=12;}
                                  if(v.toString()=="1:00 PM"){hour_num=13;}
                                  if(v.toString()=="2:00 PM"){hour_num=14;}
                                  if(v.toString()=="3:00 PM"){hour_num=15;}
                                  if(v.toString()=="4:00 PM"){hour_num=16;}
                                  if(v.toString()=="5:00 PM"){hour_num=17;}
                                  if(v.toString()=="6:00 PM"){hour_num=18;}
                                  if(v.toString()=="7:00 PM"){hour_num=19;}
                                  if(v.toString()=="8:00 PM"){hour_num=20;}
                                  if(v.toString()=="9:00 PM"){hour_num=21;}
                                  if(v.toString()=="10:00 PM"){hour_num=22;}
                                  if(v.toString()=="11:00 PM"){hour_num=23;}
                                  if(v.toString()=="12:00 AM"){hour_num=24;}

                                  if(bookrealEstateController.check_in_hour_int<hour_num){
                                    context.CheckOutHour(v,hour_num);
                                  }else{
                                    Fluttertoast.showToast(msg: "You Can't Select Previous Time");

                                  }


                                  print(v);
                                  print(hour_num);


                                }),

                            Image.asset(
                              "assets/images/clock.png",
                              height: 25,
                              width: 25,

                            ),

                          ],
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: notifire.getblackwhitecolor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   child: GestureDetector(
                  //     onTap: ()async{
                  //       var times=await showTimePicker(context:contexttop,
                  //
                  //           initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute));
                  //
                  //       context.CheckInHour("${times!.hour.toString()}:${times!.minute.toString()}");
                  //
                  //
                  //       print(times!.hour.toString()+"="+times!.minute.toString());
                  //     },
                  //     child: Container(
                  //       height: 55,
                  //       margin: EdgeInsets.all(8),
                  //       child: Row(
                  //         children: [
                  //           SizedBox(
                  //             width: 15,
                  //           ),
                  //           Text(
                  //             context.check_in_hour==""?"Check in time":"${context.check_in_hour}".tr,
                  //             style: TextStyle(
                  //               fontFamily: FontFamily.gilroyMedium,
                  //               color: notifire.getgreycolor,
                  //             ),
                  //           ),
                  //           Spacer(),
                  //           Image.asset(
                  //             "assets/images/clock.png",
                  //             height: 25,
                  //             width: 25,
                  //
                  //           ),
                  //           SizedBox(
                  //             width: 5,
                  //           ),
                  //         ],
                  //       ),
                  //       alignment: Alignment.center,
                  //       decoration: BoxDecoration(
                  //         color: notifire.getblackwhitecolor,
                  //         borderRadius: BorderRadius.circular(15),
                  //         border: Border.all(color: Colors.grey.shade200),
                  //       ),
                  //     ),
                  //   ),
                  // ),
               /*   Expanded(
                    child: GestureDetector(
                      onTap: ()async{
                        var times=await showTimePicker(context:contexttop,

                            initialTime: TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute));
                        // context.CheckOutHour("${times!.hour.toString()}:${times!.minute.toString()}");
                        print(times!.hour.toString()+"="+times!.minute.toString());
                      },
                      child: Container(
                        height: 55,
                        margin: EdgeInsets.all(8),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              context.check_out_hour==""?"Check out time":"${context.check_out_hour}".tr,
                              style: TextStyle(
                                fontFamily: FontFamily.gilroyMedium,
                                color: notifire.getgreycolor,
                              ),
                            ),
                            Spacer(),
                            Image.asset(
                              "assets/images/clock.png",
                              height: 25,
                              width: 25,

                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: notifire.getblackwhitecolor,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                      ),
                    ),
                  ),*/


                ],
              ) else Row(
                children: [

                  Expanded(
                    child: Container(
                      height: 55,
                      margin: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          bookrealEstateController.visible
                              ? Text(
                            bookrealEstateController.checkIn,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: notifire.getwhiteblackcolor,
                            ),
                          )
                              : Text(
                            "Check in".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: notifire.getgreycolor,
                            ),
                          ),
                          Spacer(),
                          Image.asset(
                            "assets/images/Calendar.png",
                            height: 25,
                            width: 25,
                            color: bookrealEstateController.visible
                                ? notifire.getwhiteblackcolor
                                : notifire.getgreycolor,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: notifire.getblackwhitecolor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 55,
                      margin: EdgeInsets.all(8),
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 15,
                          ),
                          bookrealEstateController.visible
                              ? Text(
                            bookrealEstateController.checkOut,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: notifire.getwhiteblackcolor,
                            ),
                          )
                              : Text(
                            "Check out".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: notifire.getgreycolor,
                            ),
                          ),
                          Spacer(),
                          Image.asset(
                            "assets/images/Calendar.png",
                            height: 25,
                            width: 25,
                            color: bookrealEstateController.visible
                                ? notifire.getwhiteblackcolor
                                : notifire.getgreycolor,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: notifire.getblackwhitecolor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                    ),
                  ),
                ],
              ),

              Container(
                height: 100,
                width: Get.size.width,
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Number of Guest".tr,
                              style: TextStyle(
                                color: notifire.getwhiteblackcolor,
                                fontFamily: FontFamily.gilroyBold,
                                fontSize: 17,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              "${"Allowed Max".tr} ${homePageController.homeDatatInfo?.homeData.cateWiseProperty[homePageController.currentIndex].plimit} ${"Guest".tr}",
                              style: TextStyle(
                                color: notifire.getwhiteblackcolor,
                                fontFamily: FontFamily.gilroyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: () {
                                if (bookrealEstateController.count > 1) {
                                  setState(() {
                                    bookrealEstateController.count--;
                                  });
                                }
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.remove,
                                  color: blueColor,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "${bookrealEstateController.count}",
                                  style: TextStyle(
                                      color: notifire.getwhiteblackcolor),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                if (bookrealEstateController.count <
                                    int.parse(homePageController
                                        .homeDatatInfo
                                        ?.homeData
                                        .cateWiseProperty[
                                    homePageController.currentIndex]
                                        .plimit ??
                                        "1")) {
                                  setState(() {
                                    bookrealEstateController.count++;
                                  });
                                }
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.add,
                                  color: blueColor,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: notifire.getblackwhitecolor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade200),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, left: 15),
                child: Text(
                  "Note to Owner (optional)".tr,
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: FontFamily.gilroyBold,
                    color: notifire.getwhiteblackcolor,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(15),
                child: TextFormField(
                  controller: reviewSummaryController.note,
                  minLines: 5,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  cursorColor: notifire.getwhiteblackcolor,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    hintText: "Notes".tr,
                    hintStyle: TextStyle(
                      fontFamily: FontFamily.gilroyMedium,
                      fontSize: 15,
                    ),
                  ),
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyMedium,
                    fontSize: 16,
                    color: notifire.getwhiteblackcolor,
                  ),
                ),
                decoration: BoxDecoration(
                  color: notifire.getblackwhitecolor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade100),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Booking for someone".tr,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: FontFamily.gilroyBold,
                      color: notifire.getwhiteblackcolor,
                    ),
                  ),
                  Spacer(),
                  Transform.scale(
                    scale: 1,
                    child: Checkbox(
                      value: bookrealEstateController.chack,
                      side: const BorderSide(color: Color(0xffC5CAD4)),
                      activeColor: blueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      onChanged: (newbool) {
                        bookrealEstateController.bookingForSomeOne(newbool);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              GestButton(
                Width: Get.size.width,
                height: 50,
                buttoncolor: blueColor,
                margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                buttontext: "Continue".tr,
                style: TextStyle(
                  fontFamily: FontFamily.gilroyBold,
                  color: WhiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                onclick: () {
                  if(reviewSummaryController.ptype==0){
                    if(bookrealEstateController.check_in_hour_int==0 || bookrealEstateController.check_out_hour_int==0){
                      Fluttertoast.showToast(msg: "PLease Select Time");
                    }else{
                      walletController.getReferData();
                      bookrealEstateController.checkDateApi(
                        pid: reviewSummaryController.id,
                      );
                    }
                  }else{
                    walletController.getReferData();
                    bookrealEstateController.checkDateApi(
                      pid: reviewSummaryController.id,
                    );
                  }




                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        }),
      ),
    );
  }
}
