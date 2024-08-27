// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, avoid_print, unnecessary_brace_in_string_interps, sized_box_for_whitespace, deprecated_member_use, unused_element, unnecessary_string_interpolations

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Api/config.dart';
import '../Api/data_store.dart';
import '../controller/login_controller.dart';
import '../controller/signup_controller.dart';
import '../model/fontfamily_model.dart';
import '../screen/bookinformation_screen.dart';
import '../utils/Colors.dart';
import '../utils/Custom_widget.dart';
import '../utils/Dark_lightmode.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController number = TextEditingController();

  LoginController loginController = Get.find();
  SignUpController signUpController = Get.find();

  String? path;
  String? networkimage;
  String? base64Image;
  final ImagePicker imgpicker = ImagePicker();
  PickedFile? imageFile;

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

  String selectValue = list.first;
  String selectCountry = countryList.first;

  @override
  void initState() {
    super.initState();
    fname.text;
    getData.read("UserLogin") != null
        ? setState(() {
      fname.text = getData.read("UserLogin")["name"] ?? "";
      number.text = getData.read("UserLogin")["mobile"] ?? "";
      email.text = getData.read("UserLogin")["email"] ?? "";
      networkimage = getData.read("UserLogin")["pro_pic"] ?? "";
      networkimage != "null"
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
          print(base64Image);
        });
      }
    })();
  }

  @override
  Widget build(BuildContext context) {
    notifire = Provider.of<ColorNotifire>(context, listen: true);
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
          "Profile".tr,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontFamily.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),
      ),
      body: GetBuilder<SignUpController>(builder: (context) {
        return SizedBox(
          height: Get.size.height,
          width: Get.size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                GetBuilder<LoginController>(builder: (context) {
                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          _openGallery(Get.context!);
                        },
                        child: SizedBox(
                          height: 120,
                          width: 120,
                          child: path == null
                              ? networkimage != ""
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.network(
                              "${Config.imageUrl}${networkimage ?? ""}",
                              fit: BoxFit.cover,
                            ),
                          )
                              : CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: Get.height / 17,
                            child: Image.asset(
                              "assets/images/profile-default.png",
                              fit: BoxFit.cover,
                            ),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image.file(
                              File(path.toString()),
                              width: Get.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 5,
                        right: -5,
                        child: InkWell(
                          onTap: () {
                            _openGallery(Get.context!);
                          },
                          child: Container(
                            height: 45,
                            width: 45,
                            padding: EdgeInsets.all(7),
                            child: Image.asset(
                              "assets/images/Edit.png",
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: fname,
                    cursorColor: notifire.getwhiteblackcolor,
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 14,
                      color: notifire.getwhiteblackcolor,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade100),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade100),
                      ),
                      hintText: "First Name".tr,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name'.tr;
                      }
                      return null;
                    },
                  ),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 15),
                //   child: TextFormField(
                //     controller: lname,
                //     cursorColor: notifire.getwhiteblackcolor,
                //     style: TextStyle(
                //       fontFamily: 'Gilroy',
                //       fontSize: 14,
                //       color: notifire.getwhiteblackcolor,
                //     ),
                //     decoration: InputDecoration(
                //       focusedBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(15),
                //         borderSide: BorderSide(color: Colors.grey.shade100),
                //       ),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(15),
                //         borderSide: BorderSide(color: Colors.grey.shade100),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(15),
                //         borderSide: BorderSide(color: Colors.grey.shade100),
                //       ),
                //       hintText: "Last Name",
                //     ),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return 'Please enter your last name';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // SizedBox(
                //   height: 20,
                // ),
                // Container(
                //   height: 50,
                //   width: Get.size.width,
                //   margin: EdgeInsets.symmetric(horizontal: 15),
                //   padding: EdgeInsets.only(left: 15, right: 15),
                //   child: DropdownButton(
                //     value: selectValue,
                //     icon: Image.asset(
                //       'assets/images/Arrow - Down.png',
                //       height: 20,
                //       width: 20,
                //     ),
                //     isExpanded: true,
                //     underline: SizedBox.shrink(),
                //     items: list.map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(
                //           value,
                //           style: TextStyle(
                //             fontFamily: 'Gilroy',
                //             fontSize: 14,
                //             color: notifire.getwhiteblackcolor,
                //           ),
                //         ),
                //       );
                //     }).toList(),
                //     onChanged: (value) {
                //       setState(() {
                //         selectValue = value ?? "";
                //       });
                //     },
                //   ),
                //   decoration: BoxDecoration(
                //     color: notifire.getblackwhitecolor,
                //     borderRadius: BorderRadius.circular(15),
                //     border: Border.all(color: Colors.grey.shade100),
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextFormField(
                    controller: email,
                    cursorColor: notifire.getwhiteblackcolor,
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 14,
                      color: notifire.getwhiteblackcolor,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade100),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.grey.shade100),
                      ),
                      // suffixIcon: Padding(
                      //   padding: const EdgeInsets.all(10),
                      //   child: Image.asset(
                      //     "assets/images/email.png",
                      //     height: 10,
                      //     width: 10,
                      //     color: notifire.getwhiteblackcolor,
                      //   ),
                      // ),
                      hintText: "Email".tr,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email'.tr;
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 50,
                  width: Get.size.width,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "+880",
                        style: TextStyle(
                          color: notifire.getwhiteblackcolor,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${number.text}",
                        style: TextStyle(
                          color: notifire.getwhiteblackcolor,
                          fontFamily: 'Gilroy',
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: notifire.getblackwhitecolor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade100),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                SizedBox(
                  height: 20,
                ),
                GestButton(
                  Width: Get.size.width,
                  height: 50,
                  buttoncolor: blueColor,
                  margin: EdgeInsets.only(top: 15, left: 30, right: 30),
                  buttontext: "Update".tr,
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyBold,
                    color: WhiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  onclick: () {
                    signUpController.editProfileApi(
                      name: fname.text,
                      email: email.text,
                      password: getData.read("UserLogin")["password"].toString(),
                      gender:selectValue
                    );
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  void _openGallery(BuildContext context) async {
    final pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      path = pickedFile.path;
      setState(() {});
      File imageFile = File(path.toString());
      List<int> imageBytes = imageFile.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      loginController.updateProfileImage(base64Image);
      setState(() {});
    }
  }
}
