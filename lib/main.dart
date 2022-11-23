import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:online_sms/utils/constant.dart';
import 'package:online_sms/utils/route_generator.dart';
import 'package:online_sms/utils/screens_bindings.dart';
import './app_theme.dart';
import './screens/screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Online SMS',
      theme: ThemeData(
          fontFamily: GoogleFonts.poppins().fontFamily,
        primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // theme: ThemeData(
      //   primaryColor: MyTheme.kPrimaryColor,
      //   accentColor: MyTheme.kAccentColor,
      //   textTheme: GoogleFonts.poppinsTextTheme(
      //     Theme.of(context).textTheme,
      //   ),
      //   primarySwatch: Colors.blue,
      //   visualDensity: VisualDensity.adaptivePlatformDensity,
      // ),
      // home: HomePage(),
      initialBinding: ScreensBindings(),
      getPages: RouteGenerator.getPages(),
      initialRoute: kLoginScreenRoute,
    );
  }
}
