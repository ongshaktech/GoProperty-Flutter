// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../Api/config.dart';
import '../Api/data_store.dart';
import '../controller/homepage_controller.dart';
import '../controller/signup_controller.dart';
import '../model/fontfamily_model.dart';
import '../model/routes_helper.dart';
import '../screen/home_screen.dart';
import '../utils/Colors.dart';
import '../utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  SignUpController signUpController = Get.find();

  HomePageController homePageController = Get.find();

  List<String> list = ["All", "House", "Villa", "Apartment"];

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
    setState(() {
      homePageController.getFavouriteList(countryId: getData.read("countryId"));
    });
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: notifire.getfevAndSearch,
        appBar: AppBar(
          backgroundColor: notifire.getbgcolor,
          centerTitle: true,
          elevation: 0,
          title: Text(
            "Favorites".tr,
            style: TextStyle(
              fontFamily: FontFamily.gilroyBold,
              fontSize: 18,
              color: notifire.getwhiteblackcolor,
            ),
          ),
        ),
        body: Container(
          color: Colors.white,
          child: Center(
            child: Lottie.asset("assets/images/maintanance_banner.json"),
          ),
        ),
        // body: Column(
        //   children: [
        //
        //     GetBuilder<HomePageController>(builder: (context) {
        //       return homePageController.isfevorite
        //           ? homePageController.favouriteInfo!.propetylist.isNotEmpty
        //           // ? homePageController.favouriteInfo!.propetylist.isNotEmpty
        //               ? Expanded(
        //         flex: 1,
        //         child: ListView.builder(
        //           itemCount: homePageController
        //               .favouriteInfo?.propetylist.length,
        //           physics: BouncingScrollPhysics(),
        //           itemBuilder: (context, index) {
        //             return InkWell(
        //               onTap: () async {
        //                 await homePageController
        //                     .getPropertyDetailsApi(
        //                     id: homePageController.favouriteInfo
        //                         ?.propetylist[index].id ??
        //                         "");
        //                 Get.toNamed(
        //                   Routes.viewDataScreen,
        //                   // arguments: {
        //                   //   "price": homePageController
        //                   //       .favouriteInfo
        //                   //       ?.propetylist[index]
        //                   //       .price,
        //                   // },
        //                 );
        //               },
        //               child: Container(
        //                 height: 140,
        //                 margin: EdgeInsets.all(10),
        //                 child: Row(
        //                   children: [
        //                     Stack(
        //                       children: [
        //                         Container(
        //                           height: 140,
        //                           width: 130,
        //                           margin: EdgeInsets.all(10),
        //                           child: ClipRRect(
        //                             borderRadius:
        //                             BorderRadius.circular(15),
        //                             child: FadeInImage.assetNetwork(
        //                               fadeInCurve: Curves.easeInCirc,
        //                               placeholder:
        //                               "assets/images/ezgif.com-crop.gif",
        //                               height: 140,
        //                               image:
        //                               "${Config.imageUrl}${homePageController.favouriteInfo?.propetylist[index].image ?? ""}",
        //                               fit: BoxFit.cover,
        //                             ),
        //                             // child: Image.network(
        //                             //   "${Config.imageUrl}${homePageController.favouriteInfo?.propetylist[index].image ?? ""}",
        //                             //   fit: BoxFit.cover,
        //                             // ),
        //                           ),
        //                           decoration: BoxDecoration(
        //                             borderRadius:
        //                             BorderRadius.circular(15),
        //                           ),
        //                         ),
        //                         homePageController
        //                             .favouriteInfo
        //                             ?.propetylist[index]
        //                             .buyorrent ==
        //                             "1"
        //                             ? Positioned(
        //                           top: 15,
        //                           right: 20,
        //                           child: Container(
        //                             height: 30,
        //                             width: 45,
        //                             child: Row(
        //                               mainAxisAlignment:
        //                               MainAxisAlignment
        //                                   .center,
        //                               children: [
        //                                 Container(
        //                                   margin:
        //                                   const EdgeInsets
        //                                       .fromLTRB(
        //                                       0, 0, 3, 0),
        //                                   child: Image.asset(
        //                                     "assets/images/Rating.png",
        //                                     height: 12,
        //                                     width: 12,
        //                                   ),
        //                                 ),
        //                                 Text(
        //                                   homePageController
        //                                       .homeDatatInfo
        //                                       ?.homeData
        //                                       .featuredProperty[
        //                                   index]
        //                                       .rate ??
        //                                       "",
        //                                   style: TextStyle(
        //                                     fontFamily: FontFamily
        //                                         .gilroyMedium,
        //                                     color: blueColor,
        //                                   ),
        //                                 )
        //                               ],
        //                             ),
        //                             decoration: BoxDecoration(
        //                               color: Color(0xFFedeeef),
        //                               borderRadius:
        //                               BorderRadius.circular(
        //                                   15),
        //                             ),
        //                           ),
        //                         )
        //                             : Positioned(
        //                           top: 15,
        //                           right: 20,
        //                           child: Container(
        //                             height: 30,
        //                             width: 60,
        //                             alignment: Alignment.center,
        //                             child: Text(
        //                               "BUY".tr,
        //                               style: TextStyle(
        //                                   color: blueColor,
        //                                   fontWeight:
        //                                   FontWeight.w600),
        //                             ),
        //                             decoration: BoxDecoration(
        //                               color: Color(0xFFedeeef),
        //                               borderRadius:
        //                               BorderRadius.circular(
        //                                   15),
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                     SizedBox(
        //                       width: 8,
        //                     ),
        //                     Expanded(
        //                       child: Column(
        //                         crossAxisAlignment:
        //                         CrossAxisAlignment.start,
        //                         children: [
        //                           Row(
        //                             children: [
        //                               Expanded(
        //                                 child: Padding(
        //                                   padding:
        //                                   const EdgeInsets.only(
        //                                       top: 30),
        //                                   child: Text(
        //                                     homePageController
        //                                         .favouriteInfo
        //                                         ?.propetylist[
        //                                     index]
        //                                         .title ??
        //                                         "",
        //                                     maxLines: 2,
        //                                     style: TextStyle(
        //                                       fontSize: 17,
        //                                       fontFamily: FontFamily
        //                                           .gilroyBold,
        //                                       color: notifire
        //                                           .getwhiteblackcolor,
        //                                       overflow: TextOverflow
        //                                           .ellipsis,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ),
        //                               Padding(
        //                                 padding:
        //                                 const EdgeInsets.only(
        //                                     top: 20),
        //                                 child: InkWell(
        //                                   onTap: () {
        //                                     homePageController
        //                                         .chnageObjectIndex(
        //                                         index);
        //                                     bottomSheet();
        //                                   },
        //                                   child: Image.asset(
        //                                     "assets/images/Fev-Bold.png",
        //                                     height: 20,
        //                                     width: 20,
        //                                     color: blueColor,
        //                                   ),
        //                                 ),
        //                               ),
        //                               SizedBox(
        //                                 width: 20,
        //                               ),
        //                             ],
        //                           ),
        //                           Row(
        //                             children: [
        //                               Expanded(
        //                                 child: Text(
        //                                   homePageController
        //                                       .favouriteInfo
        //                                       ?.propetylist[index]
        //                                       .city ??
        //                                       "",
        //                                   maxLines: 1,
        //                                   style: TextStyle(
        //                                     color:
        //                                     notifire.getgreycolor,
        //                                     fontFamily: FontFamily
        //                                         .gilroyMedium,
        //                                     overflow:
        //                                     TextOverflow.ellipsis,
        //                                   ),
        //                                 ),
        //                               ),
        //                               Padding(
        //                                 padding:
        //                                 EdgeInsets.only(top: 8),
        //                                 child: Column(
        //                                   children: [
        //                                     Text(
        //                                       "${currency}${homePageController.favouriteInfo?.propetylist[index].price ?? ""}",
        //                                       style: TextStyle(
        //                                         fontSize: 17,
        //                                         fontFamily: FontFamily
        //                                             .gilroyBold,
        //                                         color: blueColor,
        //                                       ),
        //                                     ),
        //                                     homePageController
        //                                         .favouriteInfo
        //                                         ?.propetylist[
        //                                     index]
        //                                         .buyorrent ==
        //                                         "1"
        //                                         ? Text(
        //                                       "/night".tr,
        //                                       style: TextStyle(
        //                                         color: notifire
        //                                             .getgreycolor,
        //                                         fontFamily:
        //                                         FontFamily
        //                                             .gilroyMedium,
        //                                       ),
        //                                     )
        //                                         : SizedBox(),
        //                                   ],
        //                                 ),
        //                               ),
        //                               SizedBox(
        //                                 width: 10,
        //                               ),
        //                             ],
        //                           ),
        //                         ],
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //                 decoration: BoxDecoration(
        //                   color: notifire.getblackwhitecolor,
        //                   borderRadius: BorderRadius.circular(15),
        //                 ),
        //               ),
        //             );
        //           },
        //         ),
        //       )
        //           : Padding(
        //         padding: const EdgeInsets.symmetric(
        //             horizontal: 14, vertical: 5),
        //         child: Column(
        //           children: [
        //             SizedBox(height: Get.height * 0.10),
        //             Image(
        //               image: AssetImage(
        //                   "assets/images/searchDataEmpty.png"),
        //               height: Get.height * 0.28,
        //             ),
        //             SizedBox(height: Get.height * 0.04),
        //             Center(
        //               child: SizedBox(
        //                 width: Get.width * 0.80,
        //                 child: Text(
        //                   "Sorry, Favorite List Empty".tr,
        //                   textAlign: TextAlign.center,
        //                   style: TextStyle(
        //                     color: notifire.getwhiteblackcolor,
        //                     fontWeight: FontWeight.bold,
        //                     fontFamily: FontFamily.gilroyBold,
        //                     fontSize: 18,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       )
        //           : Expanded(
        //         child: Center(
        //           child: CircularProgressIndicator(),
        //         ),
        //       );
        //     }),
        //   ],
        // ),
      ),
    );
  }

  Future bottomSheet() {
    return Get.bottomSheet(
      GetBuilder<HomePageController>(builder: (context) {
        return Container(
          height: 350,
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Remove from Favorites?".tr,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: FontFamily.gilroyBold,
                  color: notifire.getwhiteblackcolor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Divider(
                  color: notifire.getgreycolor,
                ),
              ),
              Container(
                height: 140,
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
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              "${Config.imageUrl}${homePageController.favouriteInfo?.propetylist[homePageController.currentIndex].image ?? ""}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          right: 20,
                          child: Container(
                            height: 30,
                            width: 45,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.fromLTRB(0, 0, 3, 0),
                                  child: Icon(
                                    Icons.star,
                                    size: 18,
                                    color: yelloColor,
                                  ),
                                ),
                                Text(
                                  homePageController
                                      .favouriteInfo
                                      ?.propetylist[
                                  homePageController.currentIndex]
                                      .rate ??
                                      "",
                                  style: TextStyle(
                                    fontFamily: FontFamily.gilroyMedium,
                                    color: blueColor,
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFFedeeef),
                              borderRadius: BorderRadius.circular(15),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 30),
                                  child: Text(
                                    homePageController
                                        .favouriteInfo
                                        ?.propetylist[
                                    homePageController.currentIndex]
                                        .title ??
                                        "",
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: FontFamily.gilroyBold,
                                      color: notifire.getwhiteblackcolor,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  homePageController
                                      .favouriteInfo
                                      ?.propetylist[
                                  homePageController.currentIndex]
                                      .city ??
                                      "",
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: notifire.getgreycolor,
                                    fontFamily: FontFamily.gilroyMedium,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 8),
                                child: Column(
                                  children: [
                                    Text(
                                      "${currency}${homePageController.favouriteInfo?.propetylist[homePageController.currentIndex].price ?? ""}",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: FontFamily.gilroyBold,
                                        color: blueColor,
                                      ),
                                    ),
                                    homePageController
                                        .favouriteInfo
                                        ?.propetylist[homePageController
                                        .currentIndex]
                                        .buyorrent ==
                                        "1"
                                        ? Text(
                                      "/night".tr,
                                      style: TextStyle(
                                        color: notifire.getgreycolor,
                                        fontFamily:
                                        FontFamily.gilroyMedium,
                                      ),
                                    )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
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
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: Text(
                          "Cancel".tr,
                          style: TextStyle(
                            color: blueColor,
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFeef4ff),
                          borderRadius: BorderRadius.circular(45),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        homePageController.addFavouriteList(
                          pid: homePageController
                              .favouriteInfo
                              ?.propetylist[homePageController.currentIndex]
                              .id ??
                              "",
                          propertyType: homePageController
                              .favouriteInfo
                              ?.propetylist[homePageController.currentIndex]
                              .propertyType ??
                              "",
                        );
                        Get.back();
                      },
                      child: Container(
                        height: 60,
                        margin: EdgeInsets.all(15),
                        alignment: Alignment.center,
                        child: Text(
                          "Yes, Remove".tr,
                          style: TextStyle(
                            color: WhiteColor,
                            fontFamily: FontFamily.gilroyBold,
                            fontSize: 16,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: blueColor,
                          borderRadius: BorderRadius.circular(45),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          decoration: BoxDecoration(
            color: notifire.getblackwhitecolor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
        );
      }),
    );
  }
}
