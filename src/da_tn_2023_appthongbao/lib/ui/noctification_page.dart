import 'package:da_tn_2023_appthongbao/controllers/task_controller.dart';
import 'package:da_tn_2023_appthongbao/db/dbhelper.dart';
import 'package:da_tn_2023_appthongbao/model/task.dart';
import 'package:da_tn_2023_appthongbao/services/noctification_services.dart';
import 'package:da_tn_2023_appthongbao/theme.dart';
import 'package:da_tn_2023_appthongbao/ui/add_task_bar.dart';
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

class noctificaton extends StatefulWidget {
  const noctificaton({super.key});

  @override
  State<noctificaton> createState() => _noctificatonState();
}

class _noctificatonState extends State<noctificaton> {
  DateTime _selectedDate =DateTime.now();
  final _taskController =Get.put(TaskController());
  
  var notifyhelper;
  @override
 void initState() {
    // TODO: implement initState
    super.initState();
    notifyhelper=NotifyHelper();
    
  
   
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
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFfbab66),
              ),
              child: Center(
                 child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CircleAvatar(child: Text('T'),),
                   Text('GroupName',
                   style: substyle,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _paddingbutton(() => _showdaialoguser(context), 'add users',Icons.person_add,),
                        _paddingbutton(() => Get.to(()=>ManagesTaskpage()), 'manage',Icons.manage_history,),
                        _paddingbutton(() => Get.back(), 'out group',Icons.forward_outlined,),
                    
                       
                      ],
                    )
                    
                  ],
                 ),
              ),
            ),

            ListTile(
              
              title: Row(children: [
                  Icon(Icons.person),
                   Text('Members')

              ],),
              onTap: () async {
                // Update the state of the app
                // ...
                Get.to( listUser());
              },
            ),
        
          
        
          ],
        ),

      );
      
  }
  _paddingbutton(
    Function()?onTap,
    String text,
    IconData icons
    ){
    return  Padding(padding: EdgeInsets.only(top: 10,),
                        child:GestureDetector(
                          onTap: onTap,
                          child:Column(
                          children: [
                           CircleAvatar(
                            backgroundColor:  Colors.grey,
                            child: Icon(
                              icons,
                              color: Colors.white,
                              ),
                           ),
                           
                           Text(text,style: TextStyle(
                            
                            color: Colors.white
                           ),)
                          ],

                        ),
                        )
                       ,);
  }
  _ShowTasks(){     
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: _taskController.tasksList.length,
          itemBuilder: (_,index){
            Task task=_taskController.tasksList[index];
            print(task.toJson());
            if( task.repeat=="none"){
               return AnimationConfiguration.staggeredList(
            position: index, 
            child: SlideAnimation(
              child:FadeInAnimation(
                child: Row(children: [
                  GestureDetector(
                    onTap: (){
                      _showBottomSheet(context,task);
                   },
                    child: TaskTile(task),
                )
                ]
                )
               ,)
             )
             );
          
            }
            if(task.date==DateFormat.yMd().format(_selectedDate)){
              return AnimationConfiguration.staggeredList(
            position: index, 
            child: SlideAnimation(
              child:FadeInAnimation(
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      _showBottomSheet(context,task);
                    },
                    child: TaskTile(task),
                )
                ]
                )
                ,)
              )
              );
          
            }else{
              Container();
            }
        
           });
      }),
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
                Text("today",
                style: headingStyle,
                ),
                
                ],
              ),
              
              ),
             
               Mybutton(label: 'Add Task', ontap:() async {
                  await  Get.to(()=>Addtaskpage());
                      _taskController.getTasks();
                       NotifyHelper().ShowNotification(title: "hello",body: 'welcome');
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
       backgroundColor: Color(0xFFfbab66),
        leading: GestureDetector(
          onTap: (){
              Get.back();
            _taskController.getTasks();
           
          },
          child: Icon(Icons.arrow_back,
          size: 20,
          
          ),
        ),
        title: Text('Group Name'),
        actions: [ 
          Builder(builder: (context) => 
            IconButton(
            onPressed:() {
          Scaffold.of(context).openEndDrawer();
        },  icon:  Icon(Icons.person, size: 20,
        ),
        ),
          ),
        
        SizedBox(width: 20,)
],
    );
  }
  _showBottomSheet(BuildContext context,Task task){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted==1?
        
        MediaQuery.of(context).size.height*0.24:
        MediaQuery.of(context).size.height*0.32,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
            ),
            Spacer(),
            task.isCompleted==1?
            Container():_bottomSheetButton(
              label: "Task Completed",
               ontap: (){
                
                //_taskController.markTaskCompleted(task.id!);
                Get.to(detailNoctifi());
               },
                
               clr: CustomTheme.primaryClr,
               context:context,
               ),
             
                _bottomSheetButton(
              label: "Delete Task",
               ontap: (){
                _taskController.delete(task);
               
                 Get.back();
               }, 
               clr: Colors.red[300],
               context:context,
               ),
                   SizedBox(height: 20,),
                  _bottomSheetButton(
              label: "Close",
               ontap: (){
                Get.back();
               }, 
               isClose: true,
               clr: Colors.red[300],
               context:context,
               ),
                SizedBox(height: 10,),

          ],
        ),
      )
    );
  }  
  _bottomSheetButton({
    required String label,
    required Function()? ontap,
    required Color? clr,
    required BuildContext context,
    bool isClose=false
  }){
    return GestureDetector(
      onTap:ontap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        
        decoration: BoxDecoration(
          border: Border.all(width: 2,
         
          ),borderRadius: BorderRadius.circular(20),
           color: isClose==true?Colors.transparent:clr,
        ),
        child:Center(child: Text( 
          label,
          style: isClose?
          titleStyle:
          titleStyle.copyWith(color: Colors.white),
        ),) ,
      ),
    );
  }
  Future<void> _showdaialoguser(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
       
        return AlertDialog(
          title: const Text('Add Users'),
          backgroundColor: Colors.white70,
         
          content:
        
             Column(
                
              children: [
                  Row(
                    children: [
                      TextField(
                             autofocus: false,
                        decoration: InputDecoration(
                           hintText: 'search email',
                           hintStyle: subtitleStyle,
                            focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: CustomTheme.backgroundColor,
                            width: 0.8),
                            ),
                        ),
                          
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: IconButton(
                          icon: Icon(Icons.find_in_page_outlined),
                        onPressed: (){},)
                      )
                    ],
                  ),

                 Container(
                  width:400 ,
                  height:280,
                      
                    decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border(),
                              ),
                   child: ListView(
                            shrinkWrap: true,
                          children: [

                          
                          
                           ],),
                 ),    
           
                    
                    
              
                  
              ],
             
                     ),
        
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
          ],
        );
      },
    );
  }

} 

