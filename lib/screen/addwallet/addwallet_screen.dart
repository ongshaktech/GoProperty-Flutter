// ignore_for_file: sort_child_properties_last, prefer_const_constructors, unnecessary_brace_in_string_interps, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:get/get.dart';
import '../../Api/config.dart';
import '../../Api/data_store.dart';
import '../../controller/homepage_controller.dart';
import '../../controller/reviewsummary_controller.dart';
import '../../controller/wallet_controller.dart';
import '../../model/fontfamily_model.dart';
import '../../screen/home_screen.dart';
import '../../screen/payment/FlutterWave.dart';
import '../../screen/payment/InputFormater.dart';
import '../../screen/payment/PaymentCard.dart';
import '../../screen/payment/Paypal.dart';
import '../../screen/payment/Paytm.dart';
import '../../screen/payment/StripeWeb.dart';
import '../../utils/Colors.dart';
import '../../utils/Custom_widget.dart';
import '../../utils/Dark_lightmode.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddWalletScreen extends StatefulWidget {
  const AddWalletScreen({super.key});

  @override
  State<AddWalletScreen> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  WalletController walletController = Get.find();
  ReviewSummaryController reviewSummaryController = Get.find();
  HomePageController homePageController = Get.find();

  late Razorpay _razorpay;

  // String publicKeyTest = 'pk_test_71d15313379591407f0bf9786e695c2616eece54';
  final plugin = PaystackPlugin();

  int? _groupValue;
  String? selectidPay = "0";
  String razorpaykey = "";
  String? paymenttital;

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
    plugin.initialize(publicKey: Config.publicKeyTest);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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
          "Add Wallet".tr,
          style: TextStyle(
            fontSize: 17,
            fontFamily: FontFamily.gilroyBold,
            color: notifire.getwhiteblackcolor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.size.height,
          width: Get.size.width,
          child: GetBuilder<WalletController>(builder: (context) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: Get.height * 0.28,
                  width: Get.size.width,
                  margin: EdgeInsets.only(left: 15, top: 15, right: 15),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(top: 0, left: 15),
                        child: Text(
                          "Wallet".tr,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: FontFamily.gilroyBold,
                            color: WhiteColor,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15),
                        child: Text(
                          "${currency}${walletController.walletInfo?.wallet}",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 45,
                            fontFamily: FontFamily.gilroyBold,
                            color: WhiteColor,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0, left: 15),
                        child: Text(
                          "Your current Balance".tr,
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: FontFamily.gilroyBold,
                            color: WhiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/walletIMage.png"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 25),
                  child: Text(
                    "Add Amount".tr,
                    style: TextStyle(
                      fontSize: 17,
                      color: notifire.getwhiteblackcolor,
                      fontFamily: FontFamily.gilroyMedium,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: walletController.amount,
                    cursorColor: notifire.getwhiteblackcolor,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                      fontFamily: 'Gilroy',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: notifire.getwhiteblackcolor,
                    ),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: notifire.getgreycolor,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: notifire.getgreycolor,
                        ),
                      ),
                      prefixIcon: SizedBox(
                        height: 20,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: Image.asset(
                            'assets/images/graywallet.png',
                            width: 20,
                            color: buttonColor,
                          ),
                        ),
                      ),
                      hintText: "2000",
                      hintStyle: TextStyle(
                        color: notifire.getwhiteblackcolor,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Addamount(
                          Amount: "100",
                          onTap: () {
                            walletController.addAmount(price: "100");
                          }),
                      Addamount(
                          Amount: "200",
                          onTap: () {
                            walletController.addAmount(price: "200");
                          }),
                      Addamount(
                          Amount: "300",
                          onTap: () {
                            walletController.addAmount(price: "300");
                          }),
                      // InkWell(
                      //   onTap: () {
                      //     walletController.addAmount(price: "100");
                      //   },
                      //   child: Container(
                      //     height: 40,
                      //     width: 80,
                      //     alignment: Alignment.center,
                      //     margin: EdgeInsets.all(10),
                      //     child: Text(
                      //       "100",
                      //       style: TextStyle(
                      //         color: notifire.getwhiteblackcolor,
                      //       ),
                      //     ),
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: notifire.getgreycolor,
                      //       ),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: InkWell(
                      //     onTap: () {
                      //       walletController.addAmount(price: "200");
                      //     },
                      //     child: Container(
                      //       height: 40,
                      //       width: 80,
                      //       alignment: Alignment.center,
                      //       margin: EdgeInsets.all(10),
                      //       child: Text(
                      //         "200",
                      //         style: TextStyle(
                      //           color: notifire.getwhiteblackcolor,
                      //         ),
                      //       ),
                      //       decoration: BoxDecoration(
                      //         border: Border.all(
                      //           color: notifire.getgreycolor,
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: InkWell(
                      //     onTap: () {
                      //       walletController.addAmount(price: "300");
                      //     },
                      //     child: Container(
                      //       height: 40,
                      //       width: 80,
                      //       alignment: Alignment.center,
                      //       margin: EdgeInsets.all(10),
                      //       child: Text(
                      //         "300",
                      //         style: TextStyle(
                      //           color: notifire.getwhiteblackcolor,
                      //         ),
                      //       ),
                      //       decoration: BoxDecoration(
                      //         border: Border.all(
                      //           color: notifire.getgreycolor,
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Addamount(
                          Amount: "400",
                          onTap: () {
                            walletController.addAmount(price: "400");
                          }),
                      Addamount(
                          Amount: "500",
                          onTap: () {
                            walletController.addAmount(price: "500");
                          }),
                      Addamount(
                          Amount: "600",
                          onTap: () {
                            walletController.addAmount(price: "600");
                          }),
                      // Expanded(
                      //   child: InkWell(
                      //     onTap: () {
                      //       walletController.addAmount(price: "400");
                      //     },
                      //     child: Container(
                      //       height: 40,
                      //       width: 80,
                      //       alignment: Alignment.center,
                      //       margin: EdgeInsets.all(10),
                      //       child: Text(
                      //         "400",
                      //         style: TextStyle(
                      //           color: notifire.getwhiteblackcolor,
                      //         ),
                      //       ),
                      //       decoration: BoxDecoration(
                      //         border: Border.all(
                      //           color: notifire.getgreycolor,
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: InkWell(
                      //     onTap: () {
                      //       walletController.addAmount(price: "500");
                      //     },
                      //     child: Container(
                      //       height: 40,
                      //       width: 80,
                      //       alignment: Alignment.center,
                      //       margin: EdgeInsets.all(10),
                      //       child: Text(
                      //         "500",
                      //         style: TextStyle(
                      //           color: notifire.getwhiteblackcolor,
                      //         ),
                      //       ),
                      //       decoration: BoxDecoration(
                      //         border: Border.all(
                      //           color: notifire.getgreycolor,
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Expanded(
                      //   child: InkWell(
                      //     onTap: () {
                      //       walletController.addAmount(price: "600");
                      //     },
                      //     child: Container(
                      //       height: 40,
                      //       width: 80,
                      //       alignment: Alignment.center,
                      //       margin: EdgeInsets.all(10),
                      //       child: Text(
                      //         "600",
                      //         style: TextStyle(
                      //           color: notifire.getwhiteblackcolor,
                      //         ),
                      //       ),
                      //       decoration: BoxDecoration(
                      //         border: Border.all(
                      //           color: notifire.getgreycolor,
                      //         ),
                      //         borderRadius: BorderRadius.circular(10),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestButton(
                  Width: Get.size.width,
                  height: 50,
                  buttoncolor: blueColor,
                  margin: EdgeInsets.only(top: 15, left: 35, right: 35),
                  buttontext: "ADD".tr,
                  style: TextStyle(
                    fontFamily: FontFamily.gilroyBold,
                    color: WhiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  onclick: () {
                    paymentSheett();
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Future paymentSheett() {
    return showModalBottomSheet(
      backgroundColor: notifire.getbgcolor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      context: context,
      builder: (context) {
        return Wrap(children: [
          StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 10),
                    Center(
                      child: Container(
                        height: Get.height / 80,
                        width: Get.width / 5,
                        decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                    SizedBox(height: Get.height / 50),
                    Row(children: [
                      SizedBox(width: Get.width / 14),
                      Text("Select Payment Method".tr,
                          style: TextStyle(
                              color: notifire.getwhiteblackcolor,
                              fontSize: Get.height / 40,
                              fontFamily: 'Gilroy_Bold')),
                    ]),
                    SizedBox(height: Get.height / 50),
                    //! --------- List view paymente ----------
                    SizedBox(
                      height: Get.height * 0.50,
                      child:
                      GetBuilder<ReviewSummaryController>(builder: (context) {
                        return reviewSummaryController.isLodding
                            ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: reviewSummaryController
                              .paymentInfo?.paymentdata.length,
                          itemBuilder: (ctx, i) {
                            return reviewSummaryController
                                .paymentInfo?.paymentdata[i].pShow !=
                                "0"
                                ? Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8),
                              child: sugestlocationtype(
                                borderColor: selectidPay ==
                                    reviewSummaryController
                                        .paymentInfo
                                        ?.paymentdata[i]
                                        .id
                                    ? buttonColor
                                    : const Color(0xffD6D6D6),
                                title: reviewSummaryController
                                    .paymentInfo
                                    ?.paymentdata[i]
                                    .title ??
                                    "",
                                titleColor: notifire.getwhiteblackcolor,
                                val: 0,
                                image: Config.imageUrl +
                                    reviewSummaryController.paymentInfo!
                                        .paymentdata[i].img,
                                adress: reviewSummaryController
                                    .paymentInfo
                                    ?.paymentdata[i]
                                    .subtitle ??
                                    "",
                                ontap: () async {
                                  setState(() {
                                    razorpaykey =
                                        reviewSummaryController
                                            .paymentInfo!
                                            .paymentdata[i]
                                            .attributes;
                                    paymenttital =
                                        reviewSummaryController
                                            .paymentInfo!
                                            .paymentdata[i]
                                            .title;
                                    selectidPay =
                                        reviewSummaryController
                                            .paymentInfo
                                            ?.paymentdata[i]
                                            .id ??
                                            "";
                                    _groupValue = i;
                                  });
                                },
                                radio: Radio(
                                  activeColor: buttonColor,
                                  value: i,
                                  groupValue: _groupValue,
                                  onChanged: (value) {
                                    setState(() {});
                                  },
                                ),
                              ),
                            )
                                : SizedBox();
                          },
                        )
                            : Center(
                          child: CircularProgressIndicator(),
                        );
                      }),
                    ),
                    Container(
                      height: 80,
                      width: Get.size.width,
                      alignment: Alignment.center,
                      child: GestButton(
                        Width: Get.size.width,
                        height: 50,
                        buttoncolor: blueColor,
                        margin: EdgeInsets.only(top: 10, left: 30, right: 30),
                        buttontext: "Continue".tr,
                        style: TextStyle(
                          fontFamily: FontFamily.gilroyBold,
                          color: WhiteColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        onclick: () {
                          //!---- Stripe Payment ------

                          print("CLICKED");
                          walletController.getWalletUpdateData();
                          // homePageController.getHomeDataApi();
                          walletController.amount.text = "";

                          // // openCheckout();
                          // if (paymenttital == "Razorpay") {
                          //   Get.back();
                          //   openCheckout();
                          // } else if (paymenttital == "Pay TO Owner") {
                          // } else if (paymenttital == "Paypal") {
                          //   Get.to(() => PayPalPayment(
                          //       totalAmount: walletController.amount.text))!
                          //       .then((otid) {
                          //     if (otid != null) {
                          //       walletController.getWalletUpdateData();
                          //       // homePageController.getHomeDataApi();
                          //       walletController.amount.text = "";
                          //       showToastMessage("Payment Successfully".tr);
                          //     } else {
                          //       Get.back();
                          //     }
                          //   });
                          // } else if (paymenttital == "Stripe") {
                          //   Get.back();
                          //   stripePayment();
                          // } else if (paymenttital == "PayStack") {
                          //   chargeCard(
                          //     int.parse(walletController.amount.text),
                          //     getData.read("UserLogin")["email"],
                          //   );
                          // } else if (paymenttital == "FlutterWave") {
                          //   Get.to(() => Flutterwave(
                          //     totalAmount: walletController.amount.text,
                          //     email: getData
                          //         .read("UserLogin")["email"]
                          //         .toString(),
                          //   ))!
                          //       .then((otid) {
                          //     if (otid != null) {
                          //       walletController.getWalletUpdateData();
                          //       // homePageController.getHomeDataApi();
                          //       walletController.amount.text = "";
                          //       showToastMessage("Payment Successfully");
                          //     } else {
                          //       Get.back();
                          //     }
                          //   });
                          // } else if (paymenttital == "Paytm") {
                          //   Get.to(() => PayTmPayment(
                          //     totalAmount: walletController.amount.text,
                          //     uid: getData
                          //         .read("UserLogin")["id"]
                          //         .toString(),
                          //   ))!
                          //       .then((otid) {
                          //     if (otid != null) {
                          //       walletController.getWalletUpdateData();
                          //       // homePageController.getHomeDataApi();
                          //       walletController.amount.text = "";
                          //       showToastMessage("Payment Successfully");
                          //     } else {
                          //       Get.back();
                          //     }
                          //   });
                          // } else if (paymenttital == "SenangPay") {}
                        },
                      ),
                      decoration: BoxDecoration(
                        color: notifire.getblackwhitecolor,
                      ),
                    ),
                  ],
                );
              }),
        ]);
      },
    );
  }

  @override
  void dispose() {
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    _razorpay.clear();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardTypee cardType = CardUtils.getCardTypeFrmNumber(input);
    setState(() {
      _paymentCard.type = cardType;
    });
  }

  Widget sugestlocationtype(
      {Function()? ontap,
        title,
        val,
        image,
        adress,
        radio,
        Color? borderColor,
        Color? titleColor}) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return InkWell(
            splashColor: Colors.transparent,
            onTap: ontap,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width / 18),
              child: Container(
                height: Get.height / 10,
                decoration: BoxDecoration(
                    border: Border.all(color: borderColor!, width: 1),
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(11)),
                child: Row(
                  children: [
                    SizedBox(width: Get.width / 55),
                    Container(
                        height: Get.height / 12,
                        width: Get.width / 5.5,
                        decoration: BoxDecoration(
                            color: const Color(0xffF2F4F9),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: FadeInImage(
                              placeholder:
                              const AssetImage("assets/images/loading2.gif"),
                              image: NetworkImage(image)),
                          // Image.network(image, height: Get.height / 08)
                        )),
                    SizedBox(width: Get.width / 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: Get.height * 0.01),
                        Text(title,
                            style: TextStyle(
                              fontSize: Get.height / 55,
                              fontFamily: 'Gilroy_Bold',
                              color: titleColor,
                            )),
                        SizedBox(
                          width: Get.width * 0.50,
                          child: Text(adress,
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: Get.height / 65,
                                  fontFamily: 'Gilroy_Medium',
                                  color: Colors.grey)),
                        ),
                      ],
                    ),
                    const Spacer(),
                    radio
                  ],
                ),
              ),
            ),
          );
        });
  }

  //!-------- Razorpay ----------//

  void openCheckout() async {
    var username = getData.read("UserLogin")["name"] ?? "";
    var mobile = getData.read("UserLogin")["mobile"] ?? "";
    var email = getData.read("UserLogin")["email"] ?? "";
    var options = {
      'key': razorpaykey,
      'amount': int.parse(walletController.amount.text) * 100,
      'name': username,
      'description': "",
      'timeout': 300,
      'prefill': {'contact': mobile, 'email': email},
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    walletController.getWalletUpdateData();
    // homePageController.getHomeDataApi();
    walletController.amount.text = "";
    showToastMessage("Payment Successfully");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(
        'Error Response: ${"ERROR: " + response.code.toString() + " - " + response.message!}');
    showToastMessage(response.message!);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showToastMessage(response.walletName!);
  }

  //!-------- Stripe Patment --------//

  final _formKey = GlobalKey<FormState>();
  var numberController = TextEditingController();
  final _paymentCard = PaymentCardCreated();
  var _autoValidateMode = AutovalidateMode.disabled;
  bool isloading = false;

  final _card = PaymentCardCreated();
  stripePayment() {
    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      backgroundColor: notifire.getbgcolor,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Ink(
                    child: Column(
                      children: [
                        SizedBox(height: Get.height / 45),
                        Center(
                          child: Container(
                            height: Get.height / 85,
                            width: Get.width / 5,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.4),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(height: Get.height * 0.03),
                              Text("Add Your payment information".tr,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      letterSpacing: 0.5)),
                              SizedBox(height: Get.height * 0.02),
                              Form(
                                key: _formKey,
                                autovalidateMode: _autoValidateMode,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      style: TextStyle(color: Colors.black),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        LengthLimitingTextInputFormatter(19),
                                        CardNumberInputFormatter()
                                      ],
                                      controller: numberController,
                                      onSaved: (String? value) {
                                        _paymentCard.number =
                                            CardUtils.getCleanedNumber(value!);

                                        CardTypee cardType =
                                        CardUtils.getCardTypeFrmNumber(
                                            _paymentCard.number.toString());
                                        setState(() {
                                          _card.name = cardType.toString();
                                          _paymentCard.type = cardType;
                                        });
                                      },
                                      onChanged: (val) {
                                        CardTypee cardType =
                                        CardUtils.getCardTypeFrmNumber(val);
                                        setState(() {
                                          _card.name = cardType.toString();
                                          _paymentCard.type = cardType;
                                        });
                                      },
                                      validator: CardUtils.validateCardNum,
                                      decoration: InputDecoration(
                                        prefixIcon: SizedBox(
                                          height: 10,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 14,
                                              horizontal: 6,
                                            ),
                                            child: CardUtils.getCardIcon(
                                              _paymentCard.type,
                                            ),
                                          ),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: buttonColor,
                                          ),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: buttonColor,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: buttonColor,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: buttonColor,
                                          ),
                                        ),
                                        hintText:
                                        "What number is written on card?".tr,
                                        hintStyle: TextStyle(color: Colors.grey),
                                        labelStyle: TextStyle(color: Colors.grey),
                                        labelText: "Number".tr,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        Flexible(
                                          flex: 4,
                                          child: TextFormField(
                                            style: TextStyle(color: Colors.grey),
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(4),
                                            ],
                                            decoration: InputDecoration(
                                                prefixIcon: SizedBox(
                                                  height: 10,
                                                  child: Padding(
                                                    padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 14),
                                                    child: Image.asset(
                                                      'assets/images/card_cvv.png',
                                                      width: 6,
                                                      color: buttonColor,
                                                    ),
                                                  ),
                                                ),
                                                focusedErrorBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: buttonColor,
                                                  ),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: buttonColor,
                                                  ),
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: buttonColor,
                                                  ),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: buttonColor)),
                                                hintText:
                                                "Number behind the card".tr,
                                                hintStyle:
                                                TextStyle(color: Colors.grey),
                                                labelStyle:
                                                TextStyle(color: Colors.grey),
                                                labelText: 'CVV'),
                                            validator: CardUtils.validateCVV,
                                            keyboardType: TextInputType.number,
                                            onSaved: (value) {
                                              _paymentCard.cvv = int.parse(value!);
                                            },
                                          ),
                                        ),
                                        SizedBox(width: Get.width * 0.03),
                                        Flexible(
                                          flex: 4,
                                          child: TextFormField(
                                            style: TextStyle(color: Colors.black),
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                              LengthLimitingTextInputFormatter(4),
                                              CardMonthInputFormatter()
                                            ],
                                            decoration: InputDecoration(
                                              prefixIcon: SizedBox(
                                                height: 10,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 14),
                                                  child: Image.asset(
                                                    'assets/images/calender.png',
                                                    width: 10,
                                                    color: buttonColor,
                                                  ),
                                                ),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: buttonColor,
                                                ),
                                              ),
                                              focusedErrorBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: buttonColor,
                                                ),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: buttonColor,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: buttonColor,
                                                ),
                                              ),
                                              hintText: 'MM/YY'.tr,
                                              hintStyle:
                                              TextStyle(color: Colors.black),
                                              labelStyle:
                                              TextStyle(color: Colors.grey),
                                              labelText: "Expiry Date".tr,
                                            ),
                                            validator: CardUtils.validateDate,
                                            keyboardType: TextInputType.number,
                                            onSaved: (value) {
                                              List<int> expiryDate =
                                              CardUtils.getExpiryDate(value!);
                                              _paymentCard.month = expiryDate[0];
                                              _paymentCard.year = expiryDate[1];
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: Get.height * 0.055),
                                    Container(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width: Get.width,
                                        child: CupertinoButton(
                                          onPressed: () {
                                            _validateInputs();
                                          },
                                          color: buttonColor,
                                          child: Text(
                                            "Pay ${currency}${walletController.amount.text}",
                                            style: TextStyle(fontSize: 17.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.065),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            });
      },
    );
  }

  void _validateInputs() {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() {
        _autoValidateMode =
            AutovalidateMode.always; // Start validating on every change.
      });
      showToastMessage("Please fix the errors in red before submitting.".tr);
    } else {
      var username = getData.read("UserLogin")["name"] ?? "";
      var email = getData.read("UserLogin")["email"] ?? "";
      _paymentCard.name = username;
      _paymentCard.email = email;
      _paymentCard.amount = walletController.amount.text;
      form.save();

      Get.to(() => StripePaymentWeb(paymentCard: _paymentCard))!.then((otid) {
        Get.back();
        //! order Api call
        if (otid != null) {
          //! Api Call Payment Success
          walletController.getWalletUpdateData();
          // homePageController.getHomeDataApi();
          walletController.amount.text = "";
          showToastMessage("Payment Successfully");
        }
      });

      showToastMessage("Payment card is valid".tr);
    }
  }

  //!-------- PayStack ----------//

  String _getReference() {
    var platform = (Platform.isIOS) ? 'iOS' : 'Android';
    final thisDate = DateTime.now().millisecondsSinceEpoch;
    return 'ChargedFrom${platform}_$thisDate';
  }

  chargeCard(int amount, String email) async {
    Get.back();
    var charge = Charge()
      ..amount = amount * 100
      ..reference = _getReference()
      ..putCustomField(
        'custom_id',
        '846gey6w',
      ) //to pass extra parameters to be retrieved on the response from Paystack
      ..email = email;

    CheckoutResponse response = await plugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    if (response.status == true) {
      walletController.getWalletUpdateData();

      walletController.amount.text = "";
      showToastMessage("Payment Successfully".tr);
    } else {
      showToastMessage('Payment Failed!!!'.tr);
    }
  }

  // ignore: non_constant_identifier_names
  Addamount({Function()? onTap, String? Amount}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40,
        width: 90,
        alignment: Alignment.center,
        margin: EdgeInsets.all(8),
        child: Text(
          Amount!,
          style: TextStyle(
            color: notifire.getwhiteblackcolor,
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: notifire.getgreycolor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
