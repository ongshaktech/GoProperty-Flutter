// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api/config.dart';
import '../Api/data_store.dart';
import '../controller/homepage_controller.dart';
import '../controller/selectcountry_controller.dart';
import '../model/fontfamily_model.dart';
import '../model/routes_helper.dart';
import '../utils/Colors.dart';
import '../utils/Custom_widget.dart';
import '../utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geoproperti/controller/search_controller.dart' as searchController;
class SelectCountryScreen extends StatefulWidget {
  const SelectCountryScreen({super.key});

  @override
  State<SelectCountryScreen> createState() => _SelectCountryScreenState();
}

class _SelectCountryScreenState extends State<SelectCountryScreen> {
  SelectCountryController selectCountryController = Get.find();
  HomePageController homePageController = Get.find();
  searchController.SearchController _searchController = Get.find();

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
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Container(
          height: 50,
          width: Get.size.width,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: GestButton(
            Width: Get.size.width,
            height: 50,
            buttoncolor: blueColor,
            margin: EdgeInsets.only(top: 5, left: 35, right: 35),
            buttontext: "Continue".tr,
            style: TextStyle(
              fontFamily: FontFamily.gilroyBold,
              color: WhiteColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            onclick: () {

              homePageController.getHomeDataApi(
                  countryId: getData.read("countryId"));
              homePageController.getCatWiseData(
                  countryId: getData.read("countryId"), cId: "0");
              _searchController.getSearchData(
                  countryId: getData.read("countryId"));
              Get.offAndToNamed(Routes.bottoBarScreen);
            },
          ),
        ),
      ),
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
          "Select Country".tr,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontFamily.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),
      ),
      body: GetBuilder<SelectCountryController>(builder: (context) {
        return SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Stack(
            alignment: Alignment.center,
            children: [
              selectCountryController.isLoading
              // ? SizedBox(
              //     height: Get.size.height,
              //     width: Get.size.width,
              // child:
                  ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  itemCount: selectCountryController
                      .countryInfo?.countryData.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 220,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        selectCountryController.changeCountryIndex(index);
                        save(
                            "countryId",
                            selectCountryController
                                .countryInfo?.countryData[index].id ??
                                "");
                        print("££££££££££££${getData.read("countryId")}");
                        save(
                            "countryName",
                            selectCountryController.countryInfo
                                ?.countryData[index].title ??
                                "");
                      },
                      child: Container(
                        height: 220,
                        margin: EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Container(
                              height: 150,
                              width: 150,
                              margin: EdgeInsets.all(8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl:
                                  "${Config.imageUrl}${selectCountryController.countryInfo?.countryData[index].img ?? ""}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${selectCountryController.countryInfo?.countryData[index].title ?? ""}",
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: FontFamily.gilroyBold,
                                color: notifire.getwhiteblackcolor,
                              ),
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: notifire.getblackwhitecolor,
                          border: getData.read("currentIndex") == index
                              ? Border.all(color: blueColor)
                              : Border.all(color: Colors.grey.shade200),
                        ),
                      ),
                    );
                  },
                ),
                // ),
              )
                  : Center(
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        );
      }),
    );
  }
}
