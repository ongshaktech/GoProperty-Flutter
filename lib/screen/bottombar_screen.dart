// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, prefer_typing_uninitialized_variables, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api/data_store.dart';
import '../controller/wallet_controller.dart';
import '../model/fontfamily_model.dart';
import '../screen/bottomSearch.dart';
import '../screen/favorite_screen.dart';
import '../screen/home_screen.dart';
import '../screen/login_screen.dart';
import '../screen/profile_screen.dart';
import '../utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottoBarScreen extends StatefulWidget {
  const BottoBarScreen({super.key});

  @override
  State<BottoBarScreen> createState() => _BottoBarScreenState();
}

late TabController tabController;

class _BottoBarScreenState extends State<BottoBarScreen>
    with TickerProviderStateMixin {
  WalletController walletController = Get.find();

  int _currentIndex = 0;
  int _selectIndex = 0;

  var isLogin;

  List<Widget> myChilders = [
    HomeScreen(),
    BottomSearchScreen(),
    FavoriteScreen(),
    // MassageScreen(),
    ProfileScreen(),
  ];

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
    isLogin = getData.read("UserLogin");
    tabController = TabController(length: 4, vsync: this);
    getdarkmodepreviousstate();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: myChilders,
      ),
      bottomNavigationBar: BottomAppBar(
        color: notifire.getbgcolor,
        child: TabBar(
          onTap: (index) {
            setState(() {});
            if (isLogin != null) {
              _currentIndex = index;
            } else {
              index != 0 ? Get.to(() => LoginScreen()) : const SizedBox();
            }
          },
          indicator: UnderlineTabIndicator(
            insets: EdgeInsets.only(bottom: 52),
            borderSide: BorderSide(color: notifire.getbgcolor, width: 2),
          ),
          labelColor: Colors.blueAccent,
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelColor: Colors.grey,
          controller: tabController,
          padding: const EdgeInsets.symmetric(vertical: 6),
          tabs: [
            Tab(
              child: Column(
                children: [
                  _currentIndex == 0
                      ? Image.asset(
                    "assets/images/HomeBold.png",
                    scale: 22,
                    color: Color(0xff3D5BF6),
                  )
                      : Image.asset(
                    "assets/images/Home.png",
                    scale: 22,
                    color: notifire.getwhiteblackcolor,
                  ),
                  // SizedBox(height: 1),
                  Text(
                    "Home".tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: FontFamily.gilroyMedium,
                      color:
                      _currentIndex == 0 ? Color(0xff3D5BF6) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Tab(
              child: Column(
                children: [
                  _currentIndex == 1
                      ? Image.asset(
                    "assets/images/searchBold.png",
                    scale: 22,
                    color: Color(0xff3D5BF6),
                  )
                      : Image.asset(
                    "assets/images/search (2).png",
                    scale: 22,
                    color: notifire.getwhiteblackcolor,
                  ),
                  // SizedBox(height: 3),
                  Text(
                    "Search".tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: FontFamily.gilroyMedium,
                      color:
                      _currentIndex == 1 ? Color(0xff3D5BF6) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   height: 50,
            //   width: 80,
            //   alignment: Alignment.topLeft,
            //   child: Tab(
            //     child: Column(
            //       children: [
            //         Image.asset(
            //           "assets/images/Search.png",
            //           scale: 21,
            //           color: notifire.getwhiteblackcolor,
            //         ),
            //         Text(
            //           "Search".tr,
            //           style: TextStyle(
            //             fontSize: 10,
            //             fontFamily: FontFamily.gilroyMedium,
            //             color: _currentIndex == 1
            //                 ? Color(0xff3D5BF6)
            //                 : Colors.grey,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            Tab(
              child: Column(
                children: [
                  _currentIndex == 2
                      ? Image.asset(
                    "assets/images/heartBold.png",
                    scale: 22,
                    color: Color(0xff3D5BF6),
                  )
                      : Image.asset(
                    "assets/images/heartline.png",
                    scale: 22,
                    color: notifire.getwhiteblackcolor,
                  ),
                  // SizedBox(height: 3),
                  Text(
                    "Favorite".tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: FontFamily.gilroyMedium,
                      color:
                      _currentIndex == 2 ? Color(0xff3D5BF6) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            Tab(
              child: Column(
                children: [
                  _currentIndex == 3
                      ? Image.asset(
                    "assets/images/userBold.png",
                    scale: 22,
                    color: Color(0xff3D5BF6),
                  )
                      : Image.asset(
                    "assets/images/userline.png",
                    scale: 22,
                    color: notifire.getwhiteblackcolor,
                  ),
                  // SizedBox(height: 3),
                  Text(
                    "Account".tr,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: FontFamily.gilroyMedium,
                      color:
                      _currentIndex == 3 ? Color(0xff3D5BF6) : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
