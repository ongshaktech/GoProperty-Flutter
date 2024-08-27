// ignore_for_file: sort_child_properties_last, prefer_const_constructors, unnecessary_brace_in_string_interps, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

class OurRecommendationScreen extends StatefulWidget {
  const OurRecommendationScreen({super.key});

  @override
  State<OurRecommendationScreen> createState() =>
      _OurRecommendationScreenState();
}

class _OurRecommendationScreenState extends State<OurRecommendationScreen> {
  late ColorNotifire notifire;
  SignUpController signUpController = Get.find();
  HomePageController homePageController = Get.find();

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
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
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
            "Our Recommendation".tr,
            style: TextStyle(
              fontSize: 17,
              fontFamily: FontFamily.gilroyBold,
              color: notifire.getwhiteblackcolor,
            ),
          ),
        ),
        body: GetBuilder<HomePageController>(builder: (context) {
          return Column(
            children: [
              SizedBox(
                height: 55,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: ListView.builder(
                    itemCount: homePageController
                        .homeDatatInfo?.homeData.catlist.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          homePageController.changeOurCurrentIndex(index);
                          homePageController.getCatWiseData(
                            cId: homePageController
                                .homeDatatInfo?.homeData.catlist[index].id,
                            countryId: getData.read("countryId"),
                          );
                        },
                        child: Container(
                          height: 50,
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.only(
                              left: 5, right: 5, top: 7, bottom: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.network(
                                "${Config.imageUrl}${homePageController.homeDatatInfo?.homeData.catlist[index].img ?? ""}",
                                color:
                                homePageController.ourCurrentIndex == index
                                    ? WhiteColor
                                    : blueColor,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                homePageController.homeDatatInfo?.homeData
                                    .catlist[index].title ??
                                    "",
                                style: TextStyle(
                                  fontFamily: FontFamily.gilroyBold,
                                  color: homePageController.ourCurrentIndex ==
                                      index
                                      ? WhiteColor
                                      : blueColor,
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: blueColor, width: 2),
                            borderRadius: BorderRadius.circular(25),
                            color: homePageController.ourCurrentIndex == index
                                ? blueColor
                                : notifire.getblackwhitecolor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              homePageController.isCatWise
                  ? Expanded(
                child: homePageController
                    .catWiseInfo!.propertyCat.isNotEmpty
                    ? GridView.builder(
                  itemCount: homePageController
                      .catWiseInfo?.propertyCat.length,
                  gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 271,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () async {
                        homePageController.chnageObjectIndex(index);
                        await homePageController
                            .getPropertyDetailsApi(
                          id: homePageController
                              .catWiseInfo?.propertyCat[index].id,
                        );
                        Get.toNamed(
                          Routes.viewDataScreen,
                          // arguments: {
                          //   "price": homePageController
                          //       .homeDatatInfo
                          //       ?.homeData
                          //       .cateWiseProperty[index]
                          //       .price,
                          // }
                        );
                      },
                      child: Container(
                        height: 271,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  height: 140,
                                  width: Get.size.width,
                                  margin: EdgeInsets.all(8),
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(15),
                                    child: FadeInImage.assetNetwork(
                                      fadeInCurve:
                                      Curves.easeInCirc,
                                      placeholder:
                                      "assets/images/ezgif.com-crop.gif",
                                      height: 130,
                                      width: Get.size.width,
                                      image:
                                      "${Config.imageUrl}${homePageController.catWiseInfo?.propertyCat[index].image ?? ""}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                homePageController
                                    .catWiseInfo
                                    ?.propertyCat[index]
                                    .buyorrent ==
                                    "1"
                                    ? Positioned(
                                  top: 15,
                                  right: 20,
                                  child: Container(
                                    height: 30,
                                    width: 45,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .center,
                                      children: [
                                        Container(
                                          margin:
                                          const EdgeInsets
                                              .fromLTRB(
                                              0, 0, 3, 0),
                                          child: Image.asset(
                                            "assets/images/Rating.png",
                                            height: 15,
                                            width: 15,
                                          ),
                                        ),
                                        Text(
                                          "${homePageController.catWiseInfo?.propertyCat[index].rate ?? ""}",
                                          style: TextStyle(
                                            fontFamily: FontFamily
                                                .gilroyMedium,
                                            color: blueColor,
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                      Color(0xFFedeeef),
                                      borderRadius:
                                      BorderRadius
                                          .circular(15),
                                    ),
                                  ),
                                )
                                    : Positioned(
                                  top: 15,
                                  right: 20,
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    alignment:
                                    Alignment.center,
                                    child: Text(
                                      "BUY".tr,
                                      style: TextStyle(
                                          color: blueColor,
                                          fontWeight:
                                          FontWeight
                                              .w600),
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                      Color(0xFFedeeef),
                                      borderRadius:
                                      BorderRadius
                                          .circular(15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                height: 128,
                                width: Get.size.width,
                                margin: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          left: 10),
                                      child: Text(
                                        homePageController
                                            .catWiseInfo
                                            ?.propertyCat[index]
                                            .title ??
                                            "",
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontFamily:
                                          FontFamily.gilroyBold,
                                          color: notifire
                                              .getwhiteblackcolor,
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          left: 10, top: 6),
                                      child: Text(
                                        homePageController
                                            .catWiseInfo
                                            ?.propertyCat[index]
                                            .city ??
                                            "",
                                        maxLines: 1,
                                        style: TextStyle(
                                          color:
                                          notifire.getgreycolor,
                                          fontFamily: FontFamily
                                              .gilroyMedium,
                                          overflow:
                                          TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          left: 10),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(top: 7),
                                            child: Text(
                                              "${currency}${homePageController.catWiseInfo?.propertyCat[index].price ?? ""}",
                                              style: TextStyle(
                                                color: blueColor,
                                                fontFamily:
                                                FontFamily
                                                    .gilroyBold,
                                                fontSize: 17,
                                              ),
                                            ),
                                          ),
                                          homePageController
                                              .catWiseInfo
                                              ?.propertyCat[
                                          index]
                                              .buyorrent ==
                                              "1"
                                              ? Padding(
                                            padding:
                                            const EdgeInsets
                                                .only(
                                                left: 8,
                                                top: 7),
                                            child: Text(
                                              "/night",
                                              style:
                                              TextStyle(
                                                color: notifire
                                                    .getgreycolor,
                                                fontFamily:
                                                FontFamily
                                                    .gilroyMedium,
                                              ),
                                            ),
                                          )
                                              : Text(""),

                                          // Spacer(),
                                          // InkWell(
                                          //   onTap: () {
                                          //     if (homePageController
                                          //         .selectedIndex
                                          //         .contains(
                                          //             index)) {
                                          //       homePageController
                                          //           .selectedIndex
                                          //           .remove(index);
                                          //       homePageController
                                          //           .changeaddOrRemove();
                                          //       homePageController
                                          //           .addFavouriteList(
                                          //         pid: homePageController
                                          //             .homeDatatInfo
                                          //             ?.homeData
                                          //             .featuredProperty[
                                          //                 index]
                                          //             .id,
                                          //         propertyType: homePageController
                                          //             .homeDatatInfo
                                          //             ?.homeData
                                          //             .featuredProperty[
                                          //                 index]
                                          //             .propertyType,
                                          //       );
                                          //     } else {
                                          //       homePageController
                                          //           .selectedIndex
                                          //           .add(index);
                                          //       homePageController
                                          //           .changeaddOrRemove();
                                          //       homePageController
                                          //           .addFavouriteList(
                                          //         pid: homePageController
                                          //             .homeDatatInfo
                                          //             ?.homeData
                                          //             .featuredProperty[
                                          //                 index]
                                          //             .id,
                                          //         propertyType: homePageController
                                          //             .homeDatatInfo
                                          //             ?.homeData
                                          //             .featuredProperty[
                                          //                 index]
                                          //             .propertyType,
                                          //       );
                                          //     }
                                          //     setState(() {});
                                          //   },
                                          //   child: homePageController
                                          //           .selectedIndex
                                          //           .contains(index)
                                          //       ? Padding(
                                          //           padding: EdgeInsets
                                          //               .only(
                                          //                   top: 10,
                                          //                   right:
                                          //                       15),
                                          //           child:
                                          //               Image.asset(
                                          //             "assets/images/favorite.png",
                                          //             color:
                                          //                 blueColor,
                                          //             height: 20,
                                          //             width: 20,
                                          //           ),
                                          //         )
                                          //       : Padding(
                                          //           padding: EdgeInsets
                                          //               .only(
                                          //                   top: 10,
                                          //                   right:
                                          //                       15),
                                          //           child:
                                          //               Image.asset(
                                          //             "assets/images/Fev-Bold.png",
                                          //             color:
                                          //                 blueColor,
                                          //             height: 20,
                                          //             width: 20,
                                          //           ),
                                          //         ),
                                          // )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                        ),
                      ),
                    );
                  },
                )
                    : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 5),
                  child: Column(
                    children: [
                      SizedBox(height: Get.height * 0.10),
                      Image(
                        image: AssetImage(
                          "assets/images/searchDataEmpty.png",
                        ),
                        height: 110,
                        width: 110,
                      ),
                      Center(
                        child: SizedBox(
                          width: Get.width * 0.80,
                          child: Text(
                            "Sorry, there is no any nearby \n category or data not found"
                                .tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: notifire.getgreycolor,
                              fontFamily: FontFamily.gilroyBold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  : Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
