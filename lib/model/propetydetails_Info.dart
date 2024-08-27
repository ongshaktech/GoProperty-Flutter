// To parse this JSON data, do
//
//     final propetydetailsInfo = propetydetailsInfoFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

PropetydetailsInfo propetydetailsInfoFromJson(String str) =>
    PropetydetailsInfo.fromJson(json.decode(str));

String propetydetailsInfoToJson(PropetydetailsInfo data) =>
    json.encode(data.toJson());

class PropetydetailsInfo {
  PropetydetailsInfo({
    required this.propetydetails,
    required this.facility,
    required this.gallery,
    required this.reviewlist,
    required this.totalReview,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  Propetydetails propetydetails;
  List<Facility> facility;
  List<dynamic> gallery;
  List<Reviewlist> reviewlist;
  int totalReview;
  String responseCode;
  String result;
  String responseMsg;

  factory PropetydetailsInfo.fromJson(Map<String, dynamic> json) =>
      PropetydetailsInfo(
        propetydetails: Propetydetails.fromJson(json["propetydetails"]),
        facility: List<Facility>.from(
            json["facility"].map((x) => Facility.fromJson(x))),
        gallery: List<dynamic>.from(json["gallery"].map((x) => x)),
        reviewlist: List<Reviewlist>.from(
            json["reviewlist"].map((x) => Reviewlist.fromJson(x))),
        totalReview: json["total_review"],
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "propetydetails": propetydetails.toJson(),
        "facility": List<dynamic>.from(facility.map((x) => x.toJson())),
        "gallery": List<dynamic>.from(gallery.map((x) => x)),
        "reviewlist": List<dynamic>.from(reviewlist.map((x) => x.toJson())),
        "total_review": totalReview,
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Facility {
  Facility({
    required this.img,
    required this.title,
  });

  String img;
  String title;

  factory Facility.fromJson(Map<String, dynamic> json) => Facility(
        img: json["img"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "img": img,
        "title": title,
      };
}

class Propetydetails {
  Propetydetails({
    required this.id,
    required this.title,
    required this.rate,
    required this.city,
    required this.image,
    required this.propertyType,
    required this.propertyTitle,
    required this.price,
    required this.buyorrent,
    required this.isEnquiry,
    required this.address,
    required this.beds,
    required this.ownerImage,
    required this.ownerName,
    required this.bathroom,
    required this.sqrft,
    required this.description,
    required this.latitude,
    required this.mobile,
    required this.longtitude,
    required this.hour_price,
    required this.min_hour,
    required this.isFavourite,
  });

  String id;
  String title;
  String rate;
  String city;
  List<String> image;
  String propertyType;
  String propertyTitle;
  String price;
  String buyorrent;
  int isEnquiry;
  String address;
  String beds;
  String ownerImage;
  String ownerName;
  String bathroom;
  String sqrft;
  String description;
  String latitude;
  String mobile;
  String longtitude;
  String hour_price;
  String min_hour;
  int isFavourite;

  factory Propetydetails.fromJson(Map<String, dynamic> json) => Propetydetails(
        id: json["id"],
        title: json["title"],
        rate: json["rate"],
        city: json["city"],
        image: List<String>.from(json["image"].map((x) => x)),
        propertyType: json["property_type"],
        propertyTitle: json["property_title"],
        price: json["price"],
        buyorrent: json["buyorrent"],
        isEnquiry: json["is_enquiry"],
        address: json["address"],
        beds: json["beds"],
        ownerImage: json["owner_image"],
        ownerName: json["owner_name"],
        bathroom: json["bathroom"],
        sqrft: json["sqrft"],
        description: json["description"],
        latitude: json["latitude"],
        mobile: json["mobile"],
        longtitude: json["longtitude"],
    hour_price: json["hour_price"],
    min_hour: json["min_hour"],
        isFavourite: json["IS_FAVOURITE"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "rate": rate,
        "city": city,
        "image": List<dynamic>.from(image.map((x) => x)),
        "property_type": propertyType,
        "property_title": propertyTitle,
        "price": price,
        "buyorrent": buyorrent,
        "is_enquiry": isEnquiry,
        "address": address,
        "beds": beds,
        "owner_image": ownerImage,
        "owner_name": ownerName,
        "bathroom": bathroom,
        "sqrft": sqrft,
        "description": description,
        "latitude": latitude,
        "mobile": mobile,
        "longtitude": longtitude,
        "hour_price": hour_price,
        "min_hour": min_hour,
        "IS_FAVOURITE": isFavourite,
      };
}

class Reviewlist {
  Reviewlist({
    required this.userImg,
    required this.userTitle,
    required this.userRate,
    required this.userDesc,
  });

  String userImg;
  String userTitle;
  String userRate;
  String userDesc;

  factory Reviewlist.fromJson(Map<String, dynamic> json) => Reviewlist(
        userImg: json["user_img"],
        userTitle: json["user_title"],
        userRate: json["user_rate"],
        userDesc: json["user_desc"],
      );

  Map<String, dynamic> toJson() => {
        "user_img": userImg,
        "user_title": userTitle,
        "user_rate": userRate,
        "user_desc": userDesc,
      };
}
