// // ignore_for_file: prefer_const_constructors

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../model/routes_helper.dart';
// import 'package:provider/provider.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (_) => ColorNotifire(),
//         ),
//       ],
//       child: GetMaterialApp(
//         debugShowCheckedModeBanner: false,

//         // home: SpleshScreen(),
//         initialRoute: Routes.initial,
//         getPages: getPages,
//       ),
//     ),
//   );
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/routes_helper.dart';
import '../screen/splesh_screen.dart';
import '../utils/Dark_lightmode.dart';
import '../utils/localstring.dart';
import 'package:provider/provider.dart';

import 'helpar/get_di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await di.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ColorNotifire(),
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Gilroy"),
        initialRoute: Routes.initial,
        translations: LocaleString(),
        locale: const Locale('en_US', 'en_US'),
        getPages: getPages,
        home: const Directionality(
            textDirection: TextDirection.ltr, // set this property
            child: SpleshScreen()),
        builder: EasyLoading.init(),
      ),
    ),
  );
}

// void main() async {
//   await GetStorage.init();
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MultiProvider(
//     providers: [ChangeNotifierProvider(create: (_) => ColorNotifire())],
//     child: GetMaterialApp(
//       translations: LocaleString(),
//       locale: const Locale('en_US', 'en_US'),
//       title: 'Kick off'.tr,
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "Gilroy"),
//       home: const 
//     ),
//   ));
// }
