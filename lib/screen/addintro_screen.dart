// ignore_for_file: camel_case_types, use_key_in_widget_constructors, annotate_overrides, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import '../utils/Colors.dart';
import '../utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BoardingPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _BoardingScreenState createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingPage> {
  // creating all the widget before making our home screeen

  void initState() {
    getdarkmodepreviousstate();
    super.initState();

    _currentPage = 0;

    _slides = [
      Slide("assets/images/addintro1.png", "Go Primium",
          "List your villa and host people from around \n the world.".tr),
      Slide("assets/images/addintro2.png", "List any type of property",
          "Aepartments to villas and everything in betwwen can be listed.".tr),
      Slide("assets/images/addintro3.png", "Go live",
          "Embrace yourself to host travelers form across the globe.".tr),
    ];
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  int _currentPage = 0;
  List<Slide> _slides = [];
  PageController _pageController = PageController();

  // the list which contain the build slides
  List<Widget> _buildSlides() {
    return _slides.map(_buildSlide).toList();
  }

  late ColorNotifire notifire;

  Widget _buildSlide(Slide slide) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
    return Scaffold(
      backgroundColor: notifire.getbgcolor,
      body: Column(
        children: <Widget>[
          SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.04), //upar thi jagiya mukeli che
          // ignore: sized_box_for_whitespace
          Container(
            height: MediaQuery.of(context).size.height / 1.9, //imagee size
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.topRight,
            child: Image.asset(slide.image),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: Text(
              slide.heading,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: "Gilroy Bold",
                  color: notifire.getwhiteblackcolor), //heding Text
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(),
            child: Text(
              slide.subtext,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: notifire.getgreycolor,
                  fontFamily: "Gilroy Medium"), //subtext
            ),
          ),
        ],
      ),
    );
  }

  // handling the on page changed
  void _handlingOnPageChanged(int page) {
    setState(() => _currentPage = page);
  }

  // building page indicator
  Widget _buildPageIndicator() {
    Row row = Row(mainAxisAlignment: MainAxisAlignment.center, children: []);
    for (int i = 0; i < _slides.length; i++) {
      row.children.add(_buildPageIndicatorItem(i));
      if (i != _slides.length - 1)
        // ignore: curly_braces_in_flow_control_structures
        row.children.add(
          const SizedBox(
            width: 10,
          ),
        );
    }
    return row;
  }

  Widget _buildPageIndicatorItem(int index) {
    return Container(
      width: index == _currentPage ? 12 : 8,
      height: index == _currentPage ? 12 : 8,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: index == _currentPage ? Darkblue : greyColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Stack(
        children: <Widget>[
          PageView(
            controller: _pageController,
            onPageChanged: _handlingOnPageChanged,
            physics: const BouncingScrollPhysics(),
            children: _buildSlides(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: <Widget>[
                _buildPageIndicator(),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.06, //indicator set screen
                ),
                _currentPage == 2
                    ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                          color: Darkblue,
                          borderRadius: BorderRadius.circular(50)),
                      height: 50,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Get Started".tr,
                          style: TextStyle(
                              fontSize: 16,
                              color: WhiteColor,
                              fontFamily: "Gilroy Bold"),
                        ),
                      ),
                    ),
                  ),
                )
                    : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: () {
                      _pageController.nextPage(
                          duration: const Duration(microseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Darkblue,
                          borderRadius: BorderRadius.circular(50)),
                      height: 50,
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Next".tr,
                          style: TextStyle(
                              fontSize: 16,
                              color: WhiteColor,
                              fontFamily: "Gilroy Bold"),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height *
                      0.012, //indicator set screen
                ),
                // GestureDetector(
                //   onTap: () {},
                //   child: Text(
                //     "Skip",
                //     style: TextStyle(
                //       fontSize: 18,
                //       color: Darkblue,
                //       fontFamily: "Gilroy Bold",
                //     ),
                //   ),
                // ),
                // const SizedBox(height: 20)
              ],
            ),
          )
        ],
      ),
    );
  }

  getdarkmodepreviousstate() async {
    final prefs = await SharedPreferences.getInstance();
    bool? previusstate = prefs.getBool("setIsDark");
    if (previusstate == null) {
      notifire.setIsDark = false;
    } else {
      notifire.setIsDark = previusstate;
    }
  }
}

class Slide {
  String image;
  String heading;
  String subtext;

  Slide(this.image, this.heading, this.subtext);
}
