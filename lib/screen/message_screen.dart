// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable

import 'package:badges/badges.dart' as badge;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/fontfamily_model.dart';
import '../utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MassageScreen extends StatefulWidget {
  @override
  State<MassageScreen> createState() => _MassageScreenState();
}

class _MassageScreenState extends State<MassageScreen> {
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
      backgroundColor: notifire.getbgcolor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.bottomRight,
                    padding: EdgeInsets.all(17),
                    child: Image.asset(
                      'assets/images/back.png',
                      color: notifire.getwhiteblackcolor,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Text(
                        'Massage'.tr,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: notifire.getwhiteblackcolor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            searchBar(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ListTile(
                      leading: badge.Badge(
                        badgeColor: Colors.green,
                        shape: badge.BadgeShape.circle,
                        badgeContent: Text(''),
                        position:
                        badge.BadgePosition.bottomEnd(bottom: -5, end: 8),
                        animationType: badge.BadgeAnimationType.slide,
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            "Dania".tr,
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: FontFamily.gilroyBold,
                              color: notifire.getwhiteblackcolor,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "23:15",
                            style: TextStyle(
                              fontFamily: FontFamily.gilroyMedium,
                              color: notifire.getgreycolor,
                            ),
                          )
                        ],
                      ),
                      subtitle: Text(
                        "Oh hello Willam",
                        style: TextStyle(
                          fontFamily: FontFamily.gilroyBlack,
                          color: notifire.getwhiteblackcolor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchBar() {
    return Container(
      width: Get.size.width,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Padding(
        padding: const EdgeInsets.only(left: 7, right: 20),
        child: TextFormField(
          cursorColor: Colors.black,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search...",
            hintStyle: TextStyle(
              color: notifire.getlightblack,
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(9),
              child: Image.asset(
                "assets/images/SearchHomescreen.png",
                height: 10,
                width: 10,
                fit: BoxFit.cover,
                color: notifire.getwhiteblackcolor,
              ),
            ),
            suffixIcon: Padding(
              padding: const EdgeInsets.all(9),
              child: Image.asset(
                "assets/images/Filter.png",
                height: 10,
                width: 10,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: notifire.getblackwhitecolor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
