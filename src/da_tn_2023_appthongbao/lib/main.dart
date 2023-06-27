import 'package:da_tn_2023_appthongbao/db/dbhelper.dart';
import 'package:da_tn_2023_appthongbao/pages/login_page.dart';
import 'package:da_tn_2023_appthongbao/ui/home_page.dart';
import 'package:da_tn_2023_appthongbao/ui/noctification_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=
FlutterLocalNotificationsPlugin();
Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await DBhelper.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      
      //home: LoginPage(),
     initialRoute: "/",
        getPages: [
       GetPage(name: "/", page: ()=>LoginPage()),
         GetPage(name: "/home", page: ()=>home_page())
      ]
    );
  }
}


