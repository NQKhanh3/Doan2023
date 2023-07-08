import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/db/dbhelper.dart';
import 'package:da_tn_2023_appthongbao/pages/login_page.dart';
import 'package:da_tn_2023_appthongbao/services/firebase_api.dart';
import 'package:da_tn_2023_appthongbao/ui/home_page.dart';
import 'package:da_tn_2023_appthongbao/ui/noctification_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=
FlutterLocalNotificationsPlugin();
Future <void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  //SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    //DeviceOrientation.portraitUp,
   // DeviceOrientation.portraitDown,

  //]);
    await Firebase.initializeApp();
 

 // await DBhelper.initDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final router = NetworkHelper();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: FutureBuilder(
        future: router.tryAutoLogin(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.red)
            );
          }
          else{
            if(snapshot.data==true){
              return home_page();
            }
            return LoginPage();
          }
        },
       ) ,
     initialRoute: "/",
        getPages: [
       GetPage(name: "/", page: ()=>LoginPage()),
         GetPage(name: "/home", page: ()=>home_page())
      ]
    );
  }
}


