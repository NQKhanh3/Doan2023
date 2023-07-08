import 'dart:ui';

import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/controllers/task_controller.dart';

import 'package:da_tn_2023_appthongbao/model/groups.dart';
import 'package:da_tn_2023_appthongbao/model/noctifi.dart';

import 'package:da_tn_2023_appthongbao/services/noctification_services.dart';
import 'package:da_tn_2023_appthongbao/theme.dart';
import 'package:da_tn_2023_appthongbao/ui/add_task_bar.dart';
import 'package:da_tn_2023_appthongbao/ui/add_users.dart';
import 'package:da_tn_2023_appthongbao/ui/button.dart';
import 'package:da_tn_2023_appthongbao/ui/list_user_page.dart';

import 'package:da_tn_2023_appthongbao/ui/manages_page.dart';
import 'package:da_tn_2023_appthongbao/ui/detail_noctifi_page.dart';
import 'package:da_tn_2023_appthongbao/ui/task_tile.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class noctificaton extends StatefulWidget {
  final group groups;
  
  const noctificaton({super.key,required this.groups});

  @override
  State<noctificaton> createState() => _noctificatonState(groups: this.groups);
}

class _noctificatonState extends State<noctificaton> {
final group groups;
late  List<noctifiModel> nocti=[];
_noctificatonState({required this.groups});
  DateTime _selectedDate =DateTime.now();
 
  
 
  @override
 void initState() {
    // TODO: implement initState
    super.initState();
    getCred();
  }
    int? id_user=1;
  void getCred()async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    setState(() {
        
         id_user =(pref.getInt('data')??0);
         
       
        
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appBar(),
      endDrawer: _showDrawer(),
      body: Column(
        children: [
          _apptaskbar(),
          _addDateBar(),
            SizedBox(height: 10,),
          _ShowTasks(),

          ],
      ),
    );
  }
  _showDrawer(){
    return Drawer(
       child: ListView(
           padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(child: 
                    Text(groups.name!.substring(0, 1).toUpperCase(),
                    style: TextStyle(fontSize: 30),),
                    radius: 50,
                    backgroundColor: Colors.white,),
                    
                   Text(groups.name!,
                   style: substyle,),
                  ],
                 ),
              ),
            ),
            _containerlistview('Members', Icons.person, () {
              
                   Get.to(listUser_page(groups: groups,));
                     // _taskController.getTasks();  
           }),
            _containerlistview('add users', Icons.person_add, () {
              if(id_user==groups.idLeader){
                   Get.to(addUser_page(groups: groups,));
                     // _taskController.getTasks();
                     
                }
                else{
                   Get.snackbar("Warring", "you are not a manager!",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.white,
                  colorText: CustomTheme.yellowClr,
                  icon: Icon(Icons.warning_amber_rounded,
                  color: Colors.red,)
                  );
             
            }
             }),
            _containerlistview('manage',Icons.manage_history, () {
              if(id_user==groups.idLeader){
                    Get.to(ManagesTaskpage(groups: groups,));
                     // _taskController.getTasks();
                     
                }
                else{
                   Get.snackbar("Warring", "you are not a manager!",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.white,
                  colorText: CustomTheme.yellowClr,
                  icon: Icon(Icons.warning_amber_rounded,
                  color: Colors.red,)
                  );
             
            }
             }),
            _containerlistview('edit group',Icons.manage_history, () {
              if(id_user==groups.idLeader){
                   Get.back();
                     // _taskController.getTasks();
                     
                }
                else{
                   Get.snackbar("Warring", "you are not a manager!",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.white,
                  colorText: CustomTheme.yellowClr,
                  icon: Icon(Icons.warning_amber_rounded,
                  color: Colors.red,)
                  );
             
            }
              }),
           
           SizedBox(height: 20,),
           Divider(),
            _containerlistview('out group', Icons.forward_outlined, (){
              
               _showdaialoguser(context);})  
            
         
           
        
          
        
          ],
        ),

      );
      
  }

  _ShowTasks(){     
    return Expanded(

      
      child:
      FutureBuilder<List<noctifiModel>>(
        future: NetworkHelper.showforGroup(groups.id),
        builder: (context, snapshot) {
          if(snapshot.hasError){
             return Center(
                  child: Text('Error'),
                );

          }else if(snapshot.hasData){
             nocti= snapshot.data!;
           // print('tong sô thong bao: ${nocti.length}');
          return ListView.builder(
          itemCount: nocti.length,

          
          itemBuilder: (_,index){
           
           
            
           if(nocti[index].ngay==DateFormat.yMd().format(_selectedDate)){
             return 
            AnimationConfiguration.staggeredList(
            position: index, 
            child: SlideAnimation(
              child:FadeInAnimation(
                child: Row(
                  children: [
                  GestureDetector(
                    onTap: () {
                      Get.to (detailNoctifi(notify: nocti[index],));
                      
                      //_showBottomSheet(context,nocti[index]);
                    },
                    child: TaskTile(nocti[index]),
                )
                ]
                )
                ,)
              )
              );
          
           }else{
            return Container();
            }
        
           });
     
     
          }
          return Center(
                child: CircularProgressIndicator(),
              );
        },
        )
       
      
     );
  }
  _addDateBar(){
    return Container(
            margin: const EdgeInsets.only(top: 20,left: 20),
            child: DatePicker(
              DateTime.now(),
              height: 100,
              width:80 ,
              initialSelectedDate:DateTime.now() ,
              selectionColor: CustomTheme.primaryClr,
              selectedTextColor: CustomTheme.white,
              dateTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                fontSize:20,
                fontWeight: FontWeight.w600,
                color: Colors.grey, 
              ),
              
              ),
              dayTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                fontSize:16,
                fontWeight: FontWeight.w600,
                color: Colors.grey, 
              ),
              
              ),
              monthTextStyle: GoogleFonts.lato(
                textStyle: TextStyle(
                fontSize:14,
                fontWeight: FontWeight.w600,
                color: Colors.grey, 
              ),
              
              ),
              onDateChange:(date){
                setState(() {
                  _selectedDate=date;
                });
                
              }
            ),
          );
        
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
                children: [
                Text( DateFormat.yMMMd().format(DateTime.now()),
                style: subHeadingStyle,
                ),
                Text("Today",
                style: headingStyle,
                ),
                
                ],
              ),
              
              ),

               Mybutton(label: 'Add Task', ontap:() async {
                if(id_user==groups.idLeader){
                   await  Get.to(Addtaskpage(groups: groups,));
                     // _taskController.getTasks();
                       //NotifyHelper().ShowNotification(title: "hello",body: 'welcome');
                }
                else{
                   Get.snackbar("Warring", "you are not a manager!",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.white,
                  colorText: CustomTheme.pinkColor,
                  icon: Icon(Icons.warning_amber_rounded,
                  color: Colors.red,)
                  );
                }

                 
               }
               
                )
  
            ],
          )
        ,
        );     
  }
  _appBar(){
    return AppBar(
      elevation: 0,
       
        leading:
         GestureDetector(
          onTap: (){
              Get.back();
            //_taskController.getTasks();
           
          },
          child: Icon(Icons.arrow_back,
          size: 20,
          
          ),
        ),
        title: Text(groups.name.toString(),style: TextStyle(
                        fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'WorkSansSemiBold',
                       fontFeatures: [
                        FontFeature.enable('smcp'),
                  ],),),
        actions: [ 
          Builder(builder: (context) => 
          GestureDetector(
            onTap: () async{
             
                    Scaffold.of(context).openEndDrawer();
                     // _taskController.getTasks();
                     
              
               
                 
            
            },
            child:  CircleAvatar(
            child: Text(groups.name!.substring(0, 1).toUpperCase()),
          )
          ,
          )
          
          ),
        
        SizedBox(width: 20,)
],
    );
  }
  Future<void> _showdaialoguser(BuildContext context,){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
       
        return AlertDialog(
          title: const Text('Leave group',style: TextStyle(),),
          content: Text('you definitely want to leave the group.'+
          'If you are the group leader, the group will be deleted.'),
        
            
        
          actions: <Widget>[
            
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Enable'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
             TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
               _checkoutGroup();
              },
            ),
          ],
        );
      },
    );
  }
 _checkoutGroup(){
  if(id_user!=groups.idLeader){
    NetworkHelper.outGroup(id_user!, groups.idLeader!);

  }else{
    print(groups.id!);
    NetworkHelper.DeleteGroup(groups.id!);
    
  }

 }
  _containerlistview(
    String? text,
    IconData? icon,
    Function()? ontap

  ){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 5),
                              color: Colors.deepOrange.withOpacity(.2),
                              spreadRadius: 5,
                              blurRadius: 10
                            )
                          ]
                        ),
                        child:ListTile(
                        leading: Icon(icon),
                
                    title: Text(text!),
    
              
                    onTap: 
                  // Update the state of the app
                  // ...
                  //print(DateFormat.yMd().format(_selectedDate));
                 ontap
                
              ), 
      ),
    );
  }
} 

