// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/addproperties_controller.dart';
import '../model/fontfamily_model.dart';
import '../utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddPropertiesOne extends StatefulWidget {
  const AddPropertiesOne({super.key});

  @override
  State<AddPropertiesOne> createState() => _AddPropertiesOneState();
}

class _AddPropertiesOneState extends State<AddPropertiesOne> {
  AddPropertiesController addPropertiesController = Get.find();

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
      appBar: AppBar(
        backgroundColor: notifire.getbgcolor,
        elevation: 0,
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Image.asset(
              "assets/images/x.png",
              height: 25,
              width: 25,
              color: notifire.getwhiteblackcolor,
            ),
          ),
        ),
        title: Text(
          "Coupons".tr,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontFamily.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Text(
              "Property Title".tr,
              style: TextStyle(
                fontFamily: FontFamily.gilroyBold,
                fontSize: 17,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              // controller: signUpController.name,
              controller: addPropertiesController.pTitle,
              cursorColor: notifire.getwhiteblackcolor,
              style: TextStyle(
                fontFamily: 'Gilroy',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: notifire.getwhiteblackcolor,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: notifire.getgreycolor),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    "assets/images/user.png",
                    height: 10,
                    width: 10,
                    color: notifire.getgreycolor,
                  ),
                ),
                labelText: "Full Name".tr,
                labelStyle: TextStyle(
                  color: notifire.getgreycolor,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name'.tr;
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
