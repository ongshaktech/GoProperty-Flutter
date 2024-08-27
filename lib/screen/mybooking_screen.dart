// ignore_for_file: prefer_const_constructors, unused_field, prefer_const_literals_to_create_immutables, sort_child_properties_last, avoid_print, unnecessary_brace_in_string_interps, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api/config.dart';
import '../Api/data_store.dart';
import '../controller/bookingdetails_controller.dart';
import '../controller/homepage_controller.dart';
import '../controller/mybooking_controller.dart';
import '../model/fontfamily_model.dart';
import '../model/routes_helper.dart';
import '../screen/home_screen.dart';
import '../utils/Colors.dart';
import '../utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyBookingScreen extends StatefulWidget {
  const MyBookingScreen({super.key});

  @override
  State<MyBookingScreen> createState() => _MyBookingScreenState();
}

class _MyBookingScreenState extends State<MyBookingScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;

  MyBookingController myBookingController = Get.find();
  HomePageController homePageController = Get.find();
  BookingDetailsController bookingDetailsController = Get.find();

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
    _tabController = TabController(length: 2, vsync: this);
    myBookingController.statusWiseBooking();
    super.initState();
    getdarkmodepreviousstate();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
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
        appBar: AppBar(
          backgroundColor: notifire.getbgcolor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              if (getData.read("backHome") == true) {
                Get.toNamed(Routes.bottoBarScreen);
                save("backHome", false);
              } else {
                Get.back();
              }
            },
            icon: Icon(
              Icons.arrow_back,
              color: notifire.getwhiteblackcolor,
            ),
          ),
          title: Text(
            "My Booking".tr,
            style: TextStyle(
              fontSize: 17,
              fontFamily: FontFamily.gilroyBold,
              color: notifire.getwhiteblackcolor,
            ),
          ),
        ),
        body: SizedBox(
          height: Get.size.height,
          width: Get.size.width,
          child: Column(
            children: [
              SizedBox(
                height: 50,
                child: TabBar(
                  controller: _tabController,
                  unselectedLabelColor: notifire.getgreycolor,
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: FontFamily.gilroyBold,
                    fontSize: 16,
                  ),
                  labelColor: blueColor,
                  onTap: (value) {
                    if (value == 0) {
                      myBookingController.statusWiseBook = "active";
                      myBookingController.statusWiseBooking();
                    } else {
                      myBookingController.statusWiseBook = "completed";
                      myBookingController.statusWiseBooking();
                    }
                  },
                  tabs: [
                    Tab(
                      text: "Active".tr,
                    ),
                    Tab(
                      text: "Completed".tr,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    activeWidget(),
                    completedWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget activeWidget() {
    return GetBuilder<MyBookingController>(builder: (context) {
      return SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: myBookingController.isLoading
            ? myBookingController.statusWiseBookInfo!.statuswise.isNotEmpty
            ? ListView.builder(
          itemCount: myBookingController
              .statusWiseBookInfo?.statuswise.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () async {
                    await homePageController.getPropertyDetailsApi(
                        id: myBookingController.statusWiseBookInfo
                            ?.statuswise[index].propId ??
                            "");
                    Get.toNamed(Routes.viewDataScreen);
                  },
                  child: Container(
                    height: 150,
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 140,
                              width: 130,
                              margin: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(15),
                                child: FadeInImage.assetNetwork(
                                  fadeInCurve: Curves.easeInCirc,
                                  placeholder:
                                  "assets/images/ezgif.com-crop.gif",
                                  height: 140,
                                  image:
                                  "${Config.imageUrl}${myBookingController.statusWiseBookInfo?.statuswise[index].propImg ?? ""}",
                                  fit: BoxFit.cover,
                                ),
                                // child: Image.network(
                                //   "${Config.imageUrl}${myBookingController.statusWiseBookInfo?.statuswise[index].propImg ?? ""}",
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(15),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              right: 20,
                              child: Container(
                                height: 30,
                                width: 45,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                      const EdgeInsets.fromLTRB(
                                          0, 0, 3, 0),
                                      child: Image.asset(
                                        "assets/images/Rating.png",
                                        height: 12,
                                        width: 12,
                                      ),
                                    ),
                                    Text(
                                      myBookingController
                                          .statusWiseBookInfo
                                          ?.statuswise[index]
                                          .totalRate ??
                                          "",
                                      style: TextStyle(
                                        fontFamily:
                                        FontFamily.gilroyMedium,
                                        color: blueColor,
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFedeeef),
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 30),
                                child: Text(
                                  myBookingController
                                      .statusWiseBookInfo
                                      ?.statuswise[index]
                                      .propTitle ??
                                      "",
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: FontFamily.gilroyBold,
                                    color:
                                    notifire.getwhiteblackcolor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: 15,
                              // ),
                              // Text(
                              //   "(${myBookingController.statusWiseBookInfo?.statuswise[index].totalDay ?? ""} day)",
                              //   style: TextStyle(
                              //     color: notifire.getgreycolor,
                              //     fontFamily: FontFamily.gilroyMedium,
                              //   ),
                              // ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${currency}${int.parse(myBookingController.statusWiseBookInfo?.statuswise[index].propPrice ?? "") * int.parse(myBookingController.statusWiseBookInfo?.statuswise[index].totalDay ?? "")}",
                                    style: TextStyle(
                                      fontFamily:
                                      FontFamily.gilroyBold,
                                      fontSize: 20,
                                      color: blueColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "/${myBookingController.statusWiseBookInfo?.statuswise[index].totalDay ?? ""} ${"days".tr}",
                                    style: TextStyle(
                                      color: notifire.getgreycolor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              myBookingController
                                  .statusWiseBookInfo
                                  ?.statuswise[index]
                                  .pMethodId !=
                                  "2"
                                  ? Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 30,
                                    padding:
                                    EdgeInsets.symmetric(
                                        horizontal: 6),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Paid".tr,
                                      style: TextStyle(
                                        color: blueColor,
                                        fontFamily: FontFamily
                                            .gilroyMedium,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: blueColor),
                                      borderRadius:
                                      BorderRadius.circular(
                                          5),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              )
                                  : Row(
                                mainAxisAlignment:
                                MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    height: 30,
                                    padding:
                                    EdgeInsets.symmetric(
                                        horizontal: 6),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Not Paid".tr,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: FontFamily
                                            .gilroyMedium,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.red),
                                      borderRadius:
                                      BorderRadius.circular(
                                          5),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: notifire.getblackwhitecolor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: notifire.getgreycolor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          myBookingController.bookingCancle(
                            myBookingController.statusWiseBookInfo
                                ?.statuswise[index].bookId,
                          );
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Cancel".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: WhiteColor,
                              fontSize: 15,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: blueColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          bookingDetailsController.getbookingDetails(
                            bookId: myBookingController
                                .statusWiseBookInfo
                                ?.statuswise[index]
                                .bookId ??
                                "",
                          );
                          Get.toNamed(
                            Routes.eReceiptScreen,
                            arguments: {
                              "Completed": "Active",
                            },
                          );
                        },
                        child: Container(
                          height: 40,
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "E-Receipt".tr,
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: blueColor,
                              fontSize: 15,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: blueColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        )
            : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset(
                  "assets/images/bookingEmpty.png",
                  height: 110,
                  width: 100,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Go & Book your favorite service".tr,
                style: TextStyle(
                  color: notifire.getgreycolor,
                  fontFamily: FontFamily.gilroyBold,
                ),
              )
            ],
          ),
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }

  Widget completedWidget() {
    return GetBuilder<MyBookingController>(builder: (context) {
      return SizedBox(
        height: Get.size.height,
        width: Get.size.width,
        child: myBookingController.isLoading
            ? myBookingController.statusWiseBookInfo!.statuswise.isNotEmpty
            ? ListView.builder(
          itemCount: myBookingController
              .statusWiseBookInfo?.statuswise.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () async {
                    await homePageController.getPropertyDetailsApi(
                        id: myBookingController.statusWiseBookInfo
                            ?.statuswise[index].propId ??
                            "");
                    Get.toNamed(Routes.viewDataScreen);
                  },
                  child: Container(
                    height: 155,
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 140,
                              width: 130,
                              margin: EdgeInsets.all(10),
                              child: ClipRRect(
                                borderRadius:
                                BorderRadius.circular(15),
                                child: FadeInImage.assetNetwork(
                                  fadeInCurve: Curves.easeInCirc,
                                  placeholder:
                                  "assets/images/ezgif.com-crop.gif",
                                  height: 140,
                                  image:
                                  "${Config.imageUrl}${myBookingController.statusWiseBookInfo?.statuswise[index].propImg ?? ""}",
                                  fit: BoxFit.cover,
                                ),
                                // child: Image.network(
                                //   "${Config.imageUrl}${myBookingController.statusWiseBookInfo?.statuswise[index].propImg ?? ""}",
                                //   fit: BoxFit.cover,
                                // ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(15),
                              ),
                            ),
                            Positioned(
                              top: 15,
                              right: 20,
                              child: Container(
                                height: 30,
                                width: 45,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                      const EdgeInsets.fromLTRB(
                                          0, 0, 3, 0),
                                      child: Image.asset(
                                        "assets/images/Rating.png",
                                        height: 12,
                                        width: 12,
                                      ),
                                    ),
                                    Text(
                                      myBookingController
                                          .statusWiseBookInfo
                                          ?.statuswise[index]
                                          .totalRate ??
                                          "",
                                      style: TextStyle(
                                        fontFamily:
                                        FontFamily.gilroyMedium,
                                        color: blueColor,
                                      ),
                                    )
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFFedeeef),
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                const EdgeInsets.only(top: 30),
                                child: Text(
                                  myBookingController
                                      .statusWiseBookInfo
                                      ?.statuswise[index]
                                      .propTitle ??
                                      "",
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: FontFamily.gilroyBold,
                                    color:
                                    notifire.getwhiteblackcolor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              // SizedBox(
                              //   height: 15,
                              // ),
                              // Text(
                              //   "(${myBookingController.statusWiseBookInfo?.statuswise[index].totalDay ?? ""} day)",
                              //   style: TextStyle(
                              //     color: notifire.getgreycolor,
                              //     fontFamily: FontFamily.gilroyMedium,
                              //   ),
                              // ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${currency}${int.parse(myBookingController.statusWiseBookInfo?.statuswise[index].propPrice ?? "") * int.parse(myBookingController.statusWiseBookInfo?.statuswise[index].totalDay ?? "")}",
                                    style: TextStyle(
                                      fontFamily:
                                      FontFamily.gilroyBold,
                                      fontSize: 20,
                                      color: blueColor,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "/${myBookingController.statusWiseBookInfo?.statuswise[index].totalDay ?? ""} days",
                                    style: TextStyle(
                                      color: notifire.getgreycolor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              InkWell(
                                onTap: () {
                                  bookingDetailsController
                                      .getbookingDetails(
                                    bookId: myBookingController
                                        .statusWiseBookInfo
                                        ?.statuswise[index]
                                        .bookId ??
                                        "",
                                  );
                                  Get.toNamed(
                                    Routes.eReceiptScreen,
                                    arguments: {
                                      "Completed": "Completed"
                                    },
                                  );
                                },
                                child: Container(
                                  height: 35,
                                  width: 120,
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "E-Receipt".tr,
                                    style: TextStyle(
                                      color: blueColor,
                                      fontFamily:
                                      FontFamily.gilroyMedium,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    border:
                                    Border.all(color: blueColor),
                                    borderRadius:
                                    BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: notifire.getblackwhitecolor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(
                    color: notifire.getgreycolor,
                  ),
                ),
              ],
            );
          },
        )
            : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Image.asset(
                  "assets/images/bookingEmpty.png",
                  height: 110,
                  width: 100,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Go & Book your favorite service".tr,
                style: TextStyle(
                  color: notifire.getgreycolor,
                  fontFamily: FontFamily.gilroyBold,
                ),
              ),
            ],
          ),
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}
