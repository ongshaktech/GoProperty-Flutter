// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, sort_child_properties_last, prefer_const_literals_to_create_immutables, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, unused_local_variable, no_leading_underscores_for_local_identifiers, avoid_print, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks, use_build_context_synchronously
import 'dart:convert';
import 'dart:io';
import 'package:geoproperti/controller/search_controller.dart' as SearchController;
import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../Api/config.dart';
import '../Api/data_store.dart';
import '../controller/homepage_controller.dart';
import '../controller/search_controller.dart';
import '../controller/signup_controller.dart';
import '../model/fontfamily_model.dart';
import '../model/routes_helper.dart';
import '../utils/Colors.dart';
import '../utils/Dark_lightmode.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var lat;
var long;
var first;
var currency;
// var tWallet;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomePageController homePageController = Get.find();
  SignUpController signUpController = Get.find();
  bool isLoding = false;
  Position? currentLocation;
  String fevId = "";

  String userName = "";
  String? base64Image;

  String? networkimage;

  @override
  void initState() {
    print("----CXX${getData.read("UserLogin")}");
    lat == null ? getUserLocation() : getUserLocation1();
    super.initState();
    getData.read("UserLogin") != null
        ? setState(() {
      userName = getData.read("UserLogin")["name"] ?? "";
      networkimage = getData.read("UserLogin")["pro_pic"] ?? "";
      getData.read("UserLogin")["pro_pic"] != "null"
          ? setState(() {
        networkimageconvert();
      })
          : const SizedBox();
    })
        : null;
    getdarkmodepreviousstate();
  }

  networkimageconvert() {
    (() async {
      http.Response response =
      await http.get(Uri.parse(Config.imageUrl + networkimage.toString()));
      if (mounted) {
        print(response.bodyBytes);
        setState(() {
          base64Image = const Base64Encoder().convert(response.bodyBytes);
        });
      }
    })();
  }

  Future<Position> locateUser() async {
    return Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future getUserLocation() async {
    isLoding = true;
    setState(() {});
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {}
    var currentLocation = await locateUser();
    debugPrint('location: ${currentLocation.latitude}');
    lat = currentLocation.latitude;
    long = currentLocation.longitude;

    List<Placemark> addresses = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude);
    setState(() {
      if (getData.read("homeCall") == true) {
        setState(() {
          homePageController.getHomeDataApi(
            countryId: getData.read("countryId"),
          );
        });
        save("homeCall", false);
      }
      first = addresses.first.name;
    });
  }

  Future getUserLocation1() async {
    isLoding = true;
    setState(() {});
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {}
    var currentLocation = await locateUser();
    debugPrint('location: ${currentLocation.latitude}');
    // setState(() {
    // if (getData.read("homeCall") == true) {
    //   setState(() {
    // homePageController.getHomeDataApi(
    //   countryId: getData.read("countryId"),
    // );
    // });
    // save("homeCall", false);
    // }
    // uid = getData.read("UserLogin") != null
    //     ? getData.read("UserLogin")["id"] ?? "0"
    //     : "0";
    // // homeController.getHomePageData();
    // homePageApi();
    // });
  }

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
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return WillPopScope(
      onWillPop: () => exit(0),
      child: Scaffold(
        backgroundColor: notifire.getbgcolor,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            toolbarHeight: 100,
            automaticallyImplyLeading: false,
            backgroundColor: notifire.getblackwhitecolor,
            elevation: 0,
            title: Row(
              children: [
                getData.read("UserLogin") != null
                    ? InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "${Config.imageUrl}${networkimage ?? ""}"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                )
                    : InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/images/profile-default.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello Welcome 👋".tr,
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontFamily: FontFamily.gilroyMedium,
                        fontSize: 14,
                      ),
                    ),
                    userName != ""
                        ? Text(
                      userName,
                      style: TextStyle(
                        color: notifire.getwhiteblackcolor,
                        fontFamily: FontFamily.gilroyBold,
                        fontSize: 18,
                      ),
                    )
                        : Text(
                      "User".tr,
                      style: TextStyle(
                        color: notifire.getwhiteblackcolor,
                        fontFamily: FontFamily.gilroyBold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                )
              ],
            ),
            // title: InkWell(
            //   onTap: () async {
            //     if (first != "") {
            //       Get.to(SearchLocationScreen());
            //     }
            //   },
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(left: 8),
            //         child: Row(
            //           children: [
            //             Text(
            //               "Location",
            //               style: TextStyle(
            //                 fontFamily: FontFamily.gilroyMedium,
            //                 fontSize: 12,
            //                 color: notifire.getwhiteblackcolor,
            //               ),
            //             ),
            //             Icon(
            //               Icons.keyboard_arrow_down,
            //               color: notifire.getwhiteblackcolor,
            //               size: 16,
            //             )
            //           ],
            //         ),
            //       ),
            //       SizedBox(
            //         height: 5,
            //       ),
            //       GetBuilder<HomePageController>(builder: (context) {
            //         return Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: [
            //             Image.asset(
            //               "assets/images/Location.png",
            //               height: 25,
            //               width: 25,
            //               fit: BoxFit.cover,
            //               color: Color(0xff3D5BF6),
            //             ),
            //             SizedBox(
            //               width: 5,
            //             ),
            //             homePageController.searchLocation == ""
            //                 ? Flexible(
            //                     fit: FlexFit.loose,
            //                     child: Text(
            //                       "${first ?? ""}",
            //                       style: TextStyle(
            //                         fontFamily: FontFamily.gilroyBold,
            //                         color: notifire.getwhiteblackcolor,
            //                         overflow: TextOverflow.ellipsis,
            //                         fontSize: 15,
            //                       ),
            //                     ),
            //                   )
            //                 : Flexible(
            //                     fit: FlexFit.loose,
            //                     child: Text(
            //                       "${homePageController.searchLocation}",
            //                       style: TextStyle(
            //                         fontFamily: FontFamily.gilroyBold,
            //                         color: notifire.getwhiteblackcolor,
            //                         overflow: TextOverflow.ellipsis,
            //                         fontSize: 15,
            //                       ),
            //                     ),
            //                   ),
            //           ],
            //         );
            //       }),
            //     ],
            //   ),
            // ),
            actions: [
              InkWell(
                onTap: () {
                  if (getData.read("UserLogin") != null) {
                    Get.toNamed(Routes.notificationScreen);
                  } else {
                    Get.toNamed(Routes.login);
                  }
                },
                child: badge.Badge(
                  badgeColor: Colors.red,
                  shape: badge.BadgeShape.circle,
                  badgeContent: Text(''),
                  animationType: badge.BadgeAnimationType.slide,
                  position: badge.BadgePosition.topEnd(end: 10, top: 14),
                  child: CircleAvatar(
                    radius: 24,
                    child: Container(
                      height: 50,
                      width: 50,
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/images/Notification.png",
                        height: 25,
                        width: 25,
                        color: notifire.getwhiteblackcolor,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                    ),
                    backgroundColor: notifire.getboxcolor,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () {
            return Future.delayed(
              Duration(seconds: 2),
                  () {
                homePageController.getHomeDataApi(
                  countryId: getData.read("countryId"),
                );
                homePageController.getCatWiseData(
                  cId: "0",
                  countryId: getData.read("countryId"),
                );
              },
            );
          },
          child: GetBuilder<HomePageController>(builder: (context) {
            // tWallet = homePageController.homeDatatInfo?.homeData.wallet ?? "";
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: homePageController.isLoading
                  ? Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  // searchBar(),
                  searchWidget(),
                  SizedBox(
                    height: 20,
                  ),
                  categoryAndSeeAllWidget("Featured".tr, "See All".tr),
                  listFeatured(),
                  categoryAndSeeAllWidget(
                      "Our Recommendation".tr, "See All".tr),
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
                              homePageController
                                  .changeCategoryIndex(index);
                              homePageController.getCatWiseData(
                                cId: homePageController.homeDatatInfo
                                    ?.homeData.catlist[index].id,
                                countryId: getData.read("countryId"),
                              );

                            },
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.all(8),
                              margin: EdgeInsets.only(
                                  left: 5, right: 5, top: 7, bottom: 7),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Image.network(
                                    "${Config.imageUrl}${homePageController.homeDatatInfo?.homeData.catlist[index].img ?? ""}",
                                    height: 25,
                                    width: 25,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    homePageController
                                        .homeDatatInfo
                                        ?.homeData
                                        .catlist[index]
                                        .title ??
                                        "",
                                    style: TextStyle(
                                      fontFamily: FontFamily.gilroyBold,
                                      color: homePageController
                                          .catCurrentIndex ==
                                          index
                                          ? WhiteColor
                                          : blueColor,
                                    ),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: blueColor, width: 2),
                                borderRadius: BorderRadius.circular(25),
                                color:
                                homePageController.catCurrentIndex ==
                                    index
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
                      ? homePageController
                      .catWiseInfo!.propertyCat.isNotEmpty
                      ? GridView.builder(
                    itemCount: homePageController
                        .catWiseInfo?.propertyCat.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 290,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          print(index);
                          homePageController
                              .chnageObjectIndex(index);
                          await homePageController
                              .getPropertyDetailsApi(
                            id: homePageController.catWiseInfo
                                ?.propertyCat[index].id,
                          );
                          Get.toNamed(Routes.viewDataScreen
                            // arguments: {
                            //   "price": homePageController
                            //       .homeDatatInfo
                            //       ?.homeData
                            //       .cateWiseProperty[index]
                            //       .price,
                            // },
                          );
                        },
                        child: Container(
                          height: 270,
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
                                      BorderRadius.circular(
                                          15),
                                      child: FadeInImage
                                          .assetNetwork(
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
                                      ?.propertyCat[
                                  index]
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
                                            margin: const EdgeInsets
                                                .fromLTRB(
                                                0,
                                                0,
                                                3,
                                                0),
                                            child: Image
                                                .asset(
                                              "assets/images/Rating.png",
                                              height: 15,
                                              width: 15,
                                            ),
                                          ),
                                          Text(
                                            "${homePageController.catWiseInfo?.propertyCat[index].rate ?? ""}",
                                            style:
                                            TextStyle(
                                              fontFamily:
                                              FontFamily
                                                  .gilroyMedium,
                                              color:
                                              blueColor,
                                            ),
                                          )
                                        ],
                                      ),
                                      decoration:
                                      BoxDecoration(
                                        color: Color(
                                            0xFFedeeef),
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            15),
                                      ),
                                    ),
                                  )
                                      : Positioned(
                                    top: 15,
                                    right: 20,
                                    child: Container(
                                      height: 30,
                                      width: 60,
                                      alignment: Alignment
                                          .center,
                                      child: Text(
                                        "BUY".tr,
                                        style: TextStyle(
                                            color:
                                            blueColor,
                                            fontWeight:
                                            FontWeight
                                                .w600),
                                      ),
                                      decoration:
                                      BoxDecoration(
                                        color: Color(
                                            0xFFedeeef),
                                        borderRadius:
                                        BorderRadius
                                            .circular(
                                            15),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  constraints: BoxConstraints(
                                    minHeight: 138
                                  ),

                                  margin: EdgeInsets.all(5),
                                  child: ListView(
                                    children: [
                                      Padding(
                                        padding:
                                        const EdgeInsets
                                            .only(left: 10),
                                        child: Text(
                                          homePageController
                                              .catWiseInfo
                                              ?.propertyCat[
                                          index]
                                              .title ??
                                              "",
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontFamily:
                                            FontFamily
                                                .gilroyBold,
                                            color: notifire
                                                .getwhiteblackcolor,
                                            overflow:
                                            TextOverflow
                                                .ellipsis,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets
                                            .only(
                                            left: 10,
                                            top: 6),
                                        child: Text(
                                          homePageController
                                              .catWiseInfo
                                              ?.propertyCat[
                                          index]
                                              .city ??
                                              "",
                                          maxLines: 1,
                                          style: TextStyle(
                                            color: notifire
                                                .getgreycolor,
                                            fontFamily: FontFamily
                                                .gilroyMedium,
                                            overflow:
                                            TextOverflow
                                                .ellipsis,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                        const EdgeInsets
                                            .only(left: 10),
                                        child: Column(
                                          children: [
                                            homePageController.catWiseInfo?.propertyCat[index].hour_price!="0"?Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      top: 7),
                                                  child: Text(
                                                    "${currency}${homePageController.catWiseInfo?.propertyCat[index].hour_price ?? ""}",
                                                    style:
                                                    TextStyle(
                                                      color:
                                                      blueColor,
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
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left: 3,
                                                      top: 7),
                                                  child: Text(
                                                    "/hour"
                                                        .tr,
                                                    style:
                                                    TextStyle(
                                                      color: notifire
                                                          .getgreycolor,
                                                      fontFamily:
                                                      FontFamily.gilroyMedium,
                                                    ),
                                                  ),
                                                )
                                                    : Text(""),
                                              ],
                                            ):SizedBox(),
                                            homePageController.catWiseInfo?.propertyCat[index].price!="0"?Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(
                                                      top: 7),
                                                  child: Text(
                                                    "${currency}${homePageController.catWiseInfo?.propertyCat[index].price ?? ""}",
                                                    style:
                                                    TextStyle(
                                                      color:
                                                      blueColor,
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
                                                  padding: const EdgeInsets
                                                      .only(
                                                      left: 3,
                                                      top: 7),
                                                  child: Text(
                                                    "/night"
                                                        .tr,
                                                    style:
                                                    TextStyle(
                                                      color: notifire
                                                          .getgreycolor,
                                                      fontFamily:
                                                      FontFamily.gilroyMedium,
                                                    ),
                                                  ),
                                                )
                                                    : Text(""),
                                              ],
                                            ):SizedBox(),
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
                            border: Border.all(
                                color: Color(0xFFedeeef)),
                            borderRadius:
                            BorderRadius.circular(10),
                            color: notifire.getblackwhitecolor,
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
                                fontFamily:
                                FontFamily.gilroyBold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                      : Center(
                    child: CircularProgressIndicator(),
                  )
                ],
              )
                  : SizedBox(
                height: Get.height,
                width: Get.width,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget searchWidget() {
    SearchController.SearchController searchController = Get.put(SearchController.SearchController());
    return InkWell(
      onTap: () {
        searchController.search.text = "";
        Get.toNamed(Routes.homeSearchScreen);
      },
      child: Container(
        height: 50,
        width: Get.size.width,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Image.asset(
                "assets/images/SearchHomescreen.png",
                height: 22,
                width: 22,
                fit: BoxFit.cover,
                color: notifire.getlightblack,
              ),
            ),
            Text(
              "Search".tr,
              style: TextStyle(
                fontFamily: FontFamily.gilroyMedium,
                color: notifire.getlightblack,
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          // color: Color(0xFFf5f5f5),
          color: notifire.getlightblackwhite,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget categoryAndSeeAllWidget(String name, String buttonName) {
    return Row(
      children: [
        SizedBox(
          width: 15,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontFamily.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),
        Spacer(),
        TextButton(
          onPressed: () {
            if (name == "Featured".tr) {
              Get.toNamed(Routes.featuredScreen);
            }
            if (name == "Our Recommendation".tr) {
              homePageController.getCatWiseData();
              Get.toNamed(Routes.ourRecommendationScreen);
            }
          },
          child: Text(
            buttonName,
            style: TextStyle(
              fontFamily: FontFamily.gilroyBold,
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget listFeatured() {
    return GetBuilder<HomePageController>(builder: (context) {
      return SizedBox(
        height: 320,
        width: Get.size.width,
        child: homePageController
            .homeDatatInfo!.homeData.featuredProperty.isNotEmpty
            ? ListView.builder(
          itemCount: homePageController
              .homeDatatInfo?.homeData.featuredProperty.length,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            print("CURRENCY ${homePageController.homeDatatInfo?.homeData.currency}");
            currency =
                homePageController.homeDatatInfo?.homeData.currency ?? "";
            return InkWell(
              onTap: () async {
                homePageController.chnageObjectIndex(index);
                await homePageController.getPropertyDetailsApi(
                    id: homePageController.homeDatatInfo?.homeData
                        .featuredProperty[index].id);
                Get.toNamed(
                  Routes.viewDataScreen,
                  // arguments: {
                  //   "price": homePageController
                  //       .homeDatatInfo?.homeData.featuredProperty[index].price,
                  // },
                );
              },
              child: Container(
                height: 320,
                width: 240,
                margin: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Stack(
                    // alignment: Alignment.bottomCenter,
                    children: [
                      SizedBox(
                        height: 320,
                        width: 240,
                        child: FadeInImage.assetNetwork(
                          fadeInCurve: Curves.easeInCirc,
                          placeholder: "assets/images/ezgif.com-crop.gif",
                          height: 320,
                          width: 240,
                          placeholderCacheHeight: 320,
                          placeholderCacheWidth: 240,
                          placeholderFit: BoxFit.fill,
                          // placeholderScale: 1.0,
                          image:
                          "${Config.imageUrl}${homePageController.homeDatatInfo?.homeData.featuredProperty[index].image ?? ""}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.6, 0.8, 1.5],
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.5),
                              Colors.black.withOpacity(0.5),
                            ],
                          ),
                          //border: Border.all(color: lightgrey),
                        ),
                      ),
                      homePageController.homeDatatInfo?.homeData
                          .featuredProperty[index].buyorrent ==
                          "1"
                          ? Positioned(
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
                                margin: const EdgeInsets.fromLTRB(
                                    0, 0, 3, 0),
                                child: Image.asset(
                                  "assets/images/Rating.png",
                                  height: 15,
                                  width: 15,
                                ),
                              ),
                              Text(
                                "${homePageController.homeDatatInfo?.homeData.featuredProperty[index].rate ?? ""}",
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
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      )
                          : Positioned(
                        top: 15,
                        right: 20,
                        child: Container(
                          height: 30,
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            "BUY".tr,
                            style: TextStyle(
                                color: blueColor,
                                fontWeight: FontWeight.w600),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFedeeef),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Container(
                          constraints: BoxConstraints(
                            minHeight: 125,
                            minWidth: 240
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height:  homePageController.homeDatatInfo?.homeData.featuredProperty[index].price!=0?0:10,),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 10),
                                child: Text(
                                  homePageController
                                      .homeDatatInfo
                                      ?.homeData
                                      .featuredProperty[index]
                                      .title ??
                                      "",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontFamily: FontFamily.gilroyBold,
                                    color: WhiteColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 10),
                                child: Text(
                                  homePageController
                                      .homeDatatInfo
                                      ?.homeData
                                      .featuredProperty[index]
                                      .city ??
                                      "",
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: FontFamily.gilroyMedium,
                                    color: WhiteColor,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              homePageController.homeDatatInfo?.homeData.featuredProperty[index].hour_price!="0"?Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 10),
                                    child: Text(
                                      "${currency}${homePageController.homeDatatInfo?.homeData.featuredProperty[index].hour_price}",
                                      style: TextStyle(
                                        color: WhiteColor,
                                        fontFamily: FontFamily.gilroyBold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  homePageController
                                      .homeDatatInfo
                                      ?.homeData
                                      .featuredProperty[index]
                                      .buyorrent ==
                                      "1"
                                      ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, top: 10),
                                    child: Text(
                                      "/hour".tr,
                                      style: TextStyle(
                                        color: WhiteColor,
                                        fontFamily:
                                        FontFamily.gilroyMedium,
                                      ),
                                    ),
                                  )
                                      : Text(""),
                                  // Spacer(),
                                  // InkWell(
                                  //   onTap: () {
                                  //     if (getData.read("UserLogin") != null) {
                                  //       homePageController.addFavouriteList(
                                  //         pid: homePageController
                                  //             .homeDatatInfo
                                  //             ?.homeData
                                  //             .featuredProperty[index]
                                  //             .id,
                                  //         propertyType: homePageController
                                  //             .homeDatatInfo
                                  //             ?.homeData
                                  //             .featuredProperty[index]
                                  //             .propertyType,
                                  //       );
                                  //     }
                                  //   },
                                  //   child: homePageController
                                  //               .homeDatatInfo
                                  //               ?.homeData
                                  //               .featuredProperty[index]
                                  //               .isFavourite ==
                                  //           1
                                  //       ? Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               top: 10, right: 15),
                                  //           child: Image.asset(
                                  //             "assets/images/Fev-Bold.png",
                                  //             color: WhiteColor,
                                  //             height: 20,
                                  //             width: 20,
                                  //           ),
                                  //         )
                                  //       : Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               top: 10, right: 15),
                                  //           child: Image.asset(
                                  //             "assets/images/favorite.png",
                                  //             color: WhiteColor,
                                  //             height: 20,
                                  //             width: 20,
                                  //           ),
                                  //         ),
                                  // )
                                ],
                              ):SizedBox(),
                              homePageController.homeDatatInfo?.homeData.featuredProperty[index].price!="0"?Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 12, top: 5),
                                    child: Text(
                                      "${currency}${homePageController.homeDatatInfo?.homeData.featuredProperty[index].price}",
                                      style: TextStyle(
                                        color: WhiteColor,
                                        fontFamily: FontFamily.gilroyBold,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  homePageController
                                      .homeDatatInfo
                                      ?.homeData
                                      .featuredProperty[index]
                                      .buyorrent ==
                                      "1"
                                      ? Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, top: 10),
                                    child: Text(
                                      "/night".tr,
                                      style: TextStyle(
                                        color: WhiteColor,
                                        fontFamily:
                                        FontFamily.gilroyMedium,
                                      ),
                                    ),
                                  )
                                      : Text(""),
                                  // Spacer(),
                                  // InkWell(
                                  //   onTap: () {
                                  //     if (getData.read("UserLogin") != null) {
                                  //       homePageController.addFavouriteList(
                                  //         pid: homePageController
                                  //             .homeDatatInfo
                                  //             ?.homeData
                                  //             .featuredProperty[index]
                                  //             .id,
                                  //         propertyType: homePageController
                                  //             .homeDatatInfo
                                  //             ?.homeData
                                  //             .featuredProperty[index]
                                  //             .propertyType,
                                  //       );
                                  //     }
                                  //   },
                                  //   child: homePageController
                                  //               .homeDatatInfo
                                  //               ?.homeData
                                  //               .featuredProperty[index]
                                  //               .isFavourite ==
                                  //           1
                                  //       ? Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               top: 10, right: 15),
                                  //           child: Image.asset(
                                  //             "assets/images/Fev-Bold.png",
                                  //             color: WhiteColor,
                                  //             height: 20,
                                  //             width: 20,
                                  //           ),
                                  //         )
                                  //       : Padding(
                                  //           padding: const EdgeInsets.only(
                                  //               top: 10, right: 15),
                                  //           child: Image.asset(
                                  //             "assets/images/favorite.png",
                                  //             color: WhiteColor,
                                  //             height: 20,
                                  //             width: 20,
                                  //           ),
                                  //         ),
                                  // )
                                ],
                              ):SizedBox(),

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            );
          },
        )
            : Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
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
      );
    });
  }
}
