import 'dart:ui';

import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/controllers/task_controller.dart';
import 'package:da_tn_2023_appthongbao/model/Users.dart';
import 'package:da_tn_2023_appthongbao/model/groups.dart';
import 'package:da_tn_2023_appthongbao/model/noctifi.dart';
import 'package:da_tn_2023_appthongbao/services/firebase_api.dart';
import 'package:da_tn_2023_appthongbao/ui/myGroup_page.dart';
import 'package:da_tn_2023_appthongbao/ui/noctification_page.dart';
import 'package:da_tn_2023_appthongbao/ui/notify_user.dart';
import 'package:da_tn_2023_appthongbao/ui/profileUser_page.dart';
import 'package:da_tn_2023_appthongbao/ui/request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme.dart';
import 'button.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  
  String access_token ="";
  
  
  //final _taskController =Get.put(TaskController());
  late  List<group> groups=[];
  late  List<noctifiModel> notify=[];
  late  List<userModel> users=[];
  late TextEditingController namecontroller=TextEditingController();
  late TextEditingController newPasscontroller=TextEditingController();
  late TextEditingController oldPasscontroller=TextEditingController();
  late TextEditingController comfirmPasscontroller=TextEditingController();
  
  FirebaseNotify notifyFirebase=FirebaseNotify();
  
  @override
  void initState(){
    super.initState();
    notifyFirebase.requestNotifyPermission();
    notifyFirebase.firebaseInit();
    //notifyFirebase.isTokenrefresh();
    notifyFirebase.getDeviceToken().then((value){
      print('token:');
      print(value);
    });
    
    
    getCred();
    getnotify();

    
  }
    int? id=13;
    void getnotify()async{
     notify= await NetworkHelper.fecthnoctifi();
     users= await NetworkHelper.fecthUser();
    }
  void getCred()async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    setState(() {
         access_token = pref.getString('login')!;
         id =(pref.getInt('data')??0);
         
       
        
    });

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      //appBar: _appBar(),
      drawer: _showDrawer(),
      body: FutureBuilder<userModel>(
          future: NetworkHelper.fecthusersById(id.toString()),
          builder: (context, snapshot) {
            if(snapshot.hasError){
               return Text('Error');
         
            }else if(snapshot.hasData){
              var user=snapshot.data!;
              return  SingleChildScrollView(
        
        child: Stack(
          
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Image(
                image: AssetImage( 'assets/img/background2.png'),fit: BoxFit.cover,),),
            Column(
              children: [
                SizedBox(height: 20,),
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,

                    children: [
                      Text(user.username!,style: TextStyle(
                        fontWeight: FontWeight.w800,
                      color: Color.fromARGB(241, 32, 19, 212),
                      fontSize: 30,
                      fontFamily: 'WorkSansSemiBold',
                       fontFeatures: [
                        FontFeature.enable('smcp'),
                  ],),),
                      SizedBox(width: 20,),
                       Builder(builder: (context) => 
                        GestureDetector(
                        onTap: () {
                         Scaffold.of(context).openDrawer();
                          //_showdaialoguser(context, true);
                        },
                        child:  user.hinhDaiDien.toString().isEmpty?CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: 30,
                         child: 
                          Image(image: AssetImage('assets/img/gundam.png')),
                        
                        ):CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: 30,
                        backgroundImage: NetworkImage("${user.hinhDaiDien}")  
                         
                        
                        )
                      )
                       )
                     ],
                  ),
                ),
                Container(
                       
                      width: MediaQuery.of(context).size.width,
                      height: 150,
                      child: _apptaskbar()
                      ),
                       Column(
                  children: [ 
                   
                   _showTaskFormgridview()
                  
                  ],)
              ],
            ),
          ],
        ),
      );
          
          }
             return Center(
                    child: CircularProgressIndicator(),
                    );
          },  

   ),
      
    );
  }
    _cardgroup(group groups){
     
      if(notify[1].idGroup==groups.id)
      return Card(
            child: 
                  ListView.builder(
            itemCount: 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.attach_file),
                title: Text(notify[index].tieuDe!),
                subtitle: Text(notify[index].time!),
              );
            },
          )
              


          );
          else 
          return
          Card(
            child: ListView(
               shrinkWrap: true,
              children:[
                 ListTile(title: Center(child: Text('chưa có thông báo',style: subTextstyle,))),
            
              ] ));
    }
    _apptaskbar(){
  return Container(
            margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
          
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                //Text( 'Groups',
               // style: subHeadingStyle,
                //),
                Expanded(child: Image(image: AssetImage('assets/img/ninja.png'),))

                
                ],
              ),
              
              ),
             
               Mybutton(label: '+ Add Group', ontap:() async {
                 _showdaialoguser(context,false);

               }
               
                )
  
            ],
          )
        ,
        );     
  }
   _getBGClr(int no) {
    switch (no) {
      case 0:
        return CustomTheme.primaryClr;
      case 1:
        return CustomTheme.pinkColor;
      case 2:
        return CustomTheme.yellowClr;
      default:
        return CustomTheme.primaryClr;
    }
  }
   _showTaskFormgridview(){
    return FutureBuilder<List<group>>(
       future:  NetworkHelper.fecthGroupsforuser(id),
      builder: (context, snapshot) {
         if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
         }
         else if(snapshot.hasData){
          groups = snapshot.data!;
          
           return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-300,
          
                child: ListView.builder(
                  shrinkWrap: false,
                 padding: const EdgeInsets.all(20),
                itemCount: groups.length,
                itemBuilder:  ( _, index) {
                 
                  notifyFirebase.getTopic('${groups[index].id}');
                 
                  return 
                   GestureDetector(
                        onTap:() async {
                      await  Get.to(()=>noctificaton(groups: groups[index]));
                          //_taskController.getTasks();
                   },
                  
                        child:Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            
                              decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(40), ),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 5),
                                color: const Color.fromARGB(255, 34, 255, 34).withOpacity(.4),
                                spreadRadius: 5,
                                blurRadius: 10
                              )
                            ]
                          ),
                          child:   Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [                        
                          ListTile(
                            leading:  CircleAvatar(
                              backgroundColor: Colors.cyan,
                              maxRadius: 15,
                                  child: Text(groups[index].name!.substring(0, 1).toUpperCase()),
                                ),
                            title: 
                                Text( groups[index].name.toString(),style:subHeadingStyle ,
                                    overflow: TextOverflow.ellipsis,  
                            ),
 
                          ),
                           
                           _cardgroup(groups[index])
                           ])),
                        )
                    );
    
                },
                
                
                ),
        

        );
     
         }
            return Center(
                child: CircularProgressIndicator(),
              );
        }
    );
  }
  Future<void> _showdaialoguser(BuildContext context,bool ai){
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: ai? const Text('update Group'): const Text('Add Group'),
          content:  TextField(
            controller: namecontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
                ),
                hintText: 'group name',
              
            ),
            

          ),
          actions: <Widget>[
            TextButton(
              onPressed: (){ 
                Navigator.pop(context, 'Cancel');
                },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () { 
                
                NetworkHelper.fecthGroupCreate(id.toString(),namecontroller.text);
                
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
  }
   _showDrawer(){
    return Drawer(
        child: FutureBuilder<userModel>(
          future: NetworkHelper.fecthusersById(id.toString()),
          builder: (context, snapshot) {
            if(snapshot.hasError){
               return Text('Error');
         
            }else if(snapshot.hasData){
              var user=snapshot.data!;
              return
              ListView(
           padding: EdgeInsets.zero,
          children: [
          
            
            UserAccountsDrawerHeader(
             accountName: Text(user.username!,
                   style: TextStyle(color: Colors.white),),
             accountEmail:  Text(user.email!,
                   style: TextStyle(color: Colors.white),),
             currentAccountPicture: 
                    user.hinhDaiDien.toString().isEmpty?CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: 30,
                         child: 
                          Image(image: AssetImage('assets/img/pngwing.png')),
                        
                        ):CircleAvatar(
                        backgroundColor: Colors.white,
                        maxRadius: 30,
                        backgroundImage: NetworkImage("${user.hinhDaiDien}")  
                         
                        
                        ) ,
            ),
          
        
     
            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text('Profile'),
              onTap: () async {
                Get.to(userProfile(user: user,));
              },
            ),

              ListTile(
              leading: Icon(FontAwesome5.bell),
              title: Text('Request'),
              onTap: () async {
                Get.to(Request_page(user: user,));
              },
            ),

            ListTile(
              leading: Icon(FontAwesome5.th),
              title: Text('My groups'),
              onTap: () async {
                Get.to(mygroup(user: user));
              },
            ),

              ListTile(
              leading: Icon(FontAwesome5.calendar_alt),
              title: Text('My noctificantins'),
              onTap: () async {
                Get.to(notifyuser_page(user: user,));
              },
            ),
              ListTile(
              leading: Icon(FontAwesome5.info),
              title: Text('change password'),
              onTap: () async {
                _dialogchangepassword(context);
              },
            ),
            Divider(),
              ListTile(
              leading: Icon(Icons.arrow_circle_left_rounded),
              title: Text('Exit'),
              onTap: () async {
              await NetworkHelper.logOut();
              },
            ),
        
          ],
        );
           
            } return Center(
                child: CircularProgressIndicator(),
              );
          }
         
        )
      );
      
  }

 _dialogchangepassword(BuildContext context,){
  return showDialog<String>(
        context: context,

        builder: (BuildContext context) => new AlertDialog(
          scrollable: true,
          shape:  RoundedRectangleBorder(
              borderRadius:
                BorderRadius.all(
                  Radius.circular(10.0))),
          title:  const Text('Change password'),
          content:  Builder(
            builder: (context) {
              var height = MediaQuery.of(context).size.height;
              var width = MediaQuery.of(context).size.width;

              return Container(
                height:height*0.5 ,
                width: width*0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                    
                      padding: EdgeInsets.all(10),
                      child: Text('Old Password:'),),
                    TextField(
                       obscureText: true,
                      controller: oldPasscontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'old password...',
                        
                      ),
                      
              
                    ),
                    SizedBox(height: 10,),
                    Padding(
                    
                      padding: EdgeInsets.all(10),
                      child: Text('New Password:'),),
                     TextField(
                      obscureText: true,
                      controller: newPasscontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'new password...',
                          
                        
                      ),
                      
              
                    ),
                    SizedBox(height: 10,),
                    Padding(
                    
                      padding: EdgeInsets.all(10),
                      child: Text('Confirm Password:'),),
                     TextField(
                       obscureText: true,
                      controller: comfirmPasscontroller,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                          ),
                          hintText: 'confirm password...',
                        
                      ),
                      
              
                    ),
                  ],
                ),
              );
            }
          ),
          
          actions: <Widget>[
            TextButton(
              onPressed: (){ 
                Navigator.pop(context, 'Cancel');
                },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () { 
                
               _checkPassword();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
  
 }
 _checkPassword(){
  if(newPasscontroller.text.isNotEmpty&&
  oldPasscontroller.text.isNotEmpty&&
  comfirmPasscontroller.text.isNotEmpty){
    if(newPasscontroller.text==comfirmPasscontroller.text){
      NetworkHelper.ChangePassword(oldPasscontroller.text, id.toString(),newPasscontroller.text).then((value){
        if(value==true){
           Get.snackbar("successfull", "cần đăng nhập lại !",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: CustomTheme.pinkColor,
      icon: Icon(Icons.warning_amber_rounded,
      color: Colors.green,));
          NetworkHelper.logOut();
        }
        else{
            Get.snackbar("Error", "don't !",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: CustomTheme.pinkColor,
      icon: Icon(Icons.warning_amber_rounded,
      color: Colors.red,));
        }

      });
    }
  }
 }

 }