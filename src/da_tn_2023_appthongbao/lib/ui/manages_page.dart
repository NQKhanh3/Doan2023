import 'package:da_tn_2023_appthongbao/controllers/task_controller.dart';
import 'package:da_tn_2023_appthongbao/model/task.dart';
import 'package:da_tn_2023_appthongbao/theme.dart';
import 'package:da_tn_2023_appthongbao/ui/add_task_bar.dart';
import 'package:da_tn_2023_appthongbao/ui/detail_noctifi_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagesTaskpage extends StatefulWidget {
  const ManagesTaskpage({super.key});

  @override
  State<ManagesTaskpage> createState() => ManagesTaskpageState();
}

class ManagesTaskpageState extends State<ManagesTaskpage> {
   final _taskController =Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_appBar() ,
      body: Column(
        children: [
          _showTaskFormgridview()
         
        ],
      ),
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
    return Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            
             padding: const EdgeInsets.all(20),
            itemCount: _taskController.tasksList.length,
          
            itemBuilder:  ( _, index) {
                Task? task=_taskController.tasksList[index];
              return 
               GestureDetector(
                    onTap: () {
                      _showBottomSheet(context,task);
                    },
                    child:Container(
                  decoration: BoxDecoration(
                    color: _getBGClr(task?.color??0),
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(8),
               
                child:   Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                  Text( task.title.toString(),style:titleStyle ,),
                       Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${task!.startTime}",
                      style: GoogleFonts.lato(
                        textStyle:
                        TextStyle(fontSize: 14, color: Colors.grey[100]),
                      ),
                    ),
               
                  ],
              ),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_outlined,
                      color: Colors.grey[200],
                      size: 18,
                    ),
                    SizedBox(width: 4),
                    Text(
                      "${task!.date}",
                      style: GoogleFonts.lato(
                        textStyle:
                        TextStyle(fontSize: 13, color: Colors.grey[100]),
                      ),
                    ),
                  ],
              ),
                   SizedBox(height: 12),
                Text(
                  task?.note??"",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                  ),
                ),
                  ]))
                );
               
               
            }),
    );
  }
  _appBar(){
    return AppBar(
      elevation: 0,
       backgroundColor:Color(0xFFfbab66) ,
        leading: GestureDetector(
          onTap: (){
              Get.back();
          
           
          },
          child: Icon(Icons.arrow_back,
          size: 20,
         
          
          ),
        ),
        title: Text('Group Name',style: headingStyle,),
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
          
            _bottomSheetButton(
              label: "Task Completed",
               ontap: (){
                
                //_taskController.markTaskCompleted(task.id!);
                Get.to(detailNoctifi());
               },
                
               clr: CustomTheme.primaryClr,
               context:context,
               ),
              _bottomSheetButton(
              label: "Re-UP",
               ontap: (){
                Get.to(Addtaskpage());
               }, 
               isClose: true,
               clr: Colors.red[300],
               context:context,
               ),
                  SizedBox(height: 20,),
                   _bottomSheetButton(
              label: "Delete Task",
               ontap: (){
                _taskController.delete(task);
               
                 Get.back();
               }, 
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
}