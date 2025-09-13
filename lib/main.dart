import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:provider/provider.dart';
import 'package:web_project1/Pages/loginPage.dart';
import 'package:web_project1/Provider/userlogin.dart';
import 'package:web_project1/splase_screen.dart';

import 'Provider/colore_provider.dart';
import 'common_button/scrool_screen.dart';
import 'ServerAndConfig/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserLoginProvider loginProvider = UserLoginProvider();
  dynamic user;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
   loadUser();
  }

  void loadUser()async{
     user = await loginProvider.getUser();
     setState(() {
       
     });
  }

  @override
  Widget build(BuildContext context){
    String version = Configuration.version;
    if (user == null) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ColorNotifire(),
          ),
        ],
        child: GetMaterialApp(
            locale: const Locale('en', 'US'),
            translations: AppTranslations(),
            title: "MBT Workorder Approve "+version,
            scrollBehavior: MyCustomScrollBehavior(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Jost-SemiBold',
              useMaterial3: false,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              dividerColor: Colors.transparent,
            ),
            //home: const Splase_Screen(),
            home: const LoginPage()),
      );
    } else {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ColorNotifire(),
          ),
        ],
        child: GetMaterialApp(
            locale: const Locale('en', 'US'),
            translations: AppTranslations(),
            title: "MBT Workorder Approve "+version,
            scrollBehavior: MyCustomScrollBehavior(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Jost-SemiBold',
              useMaterial3: false,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              dividerColor: Colors.transparent,
            ),
            home: const Splase_Screen(),
            //home: const Login_Screen()),
      ));
    }
  }
}

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'enter_mail': 'Enter your email',
        },
        'ur_th': {
          'enter_mail': 'ป้อน email',
        }
      };
}
