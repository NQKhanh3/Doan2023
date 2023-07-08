import 'dart:ui';

import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/controllers/task_controller.dart';
import 'package:da_tn_2023_appthongbao/model/groups.dart';
import 'package:da_tn_2023_appthongbao/model/noctifi.dart';
import 'package:da_tn_2023_appthongbao/model/task.dart';
import 'package:da_tn_2023_appthongbao/theme.dart';
import 'package:da_tn_2023_appthongbao/ui/add_task_bar.dart';
import 'package:da_tn_2023_appthongbao/ui/detail_noctifi_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagesTaskpage extends StatefulWidget {
  final group groups;
  ManagesTaskpage({super.key,required this.groups});

  @override
  State<ManagesTaskpage> createState() => ManagesTaskpageState(groups: this.groups);
}

class ManagesTaskpageState extends State<ManagesTaskpage> {
  late  List<noctifiModel> nocti=[];
  final group groups;

  ManagesTaskpageState({required this.groups});
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
            child: FutureBuilder<List<noctifiModel>>(
              future:  NetworkHelper.showforGroup(groups.id),
              builder: (context, snapshot) {
         if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
         } else if(snapshot.hasData){
          nocti = snapshot.data!;
           return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            
             padding: const EdgeInsets.all(20),
            itemCount: nocti.length,
          
            itemBuilder:  ( _, index) {
                var task=nocti[index];
              return 
               AnimatedContainer(
                duration: Duration(seconds: 3),
                 child: GestureDetector(
                      onTap: () {
                        _showBottomSheet(context,task);
                      },
                      child:Container(
                    decoration: BoxDecoration(
                      color: _getBGClr(task?.mauSac??0),
                      borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(8),
                 
                  child:   Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                    Text( task.tieuDe.toString(),style:titleStyle ,),
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
                        "${task!.time}",
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
                        "${task!.ngay}",
                        style: GoogleFonts.lato(
                          textStyle:
                          TextStyle(fontSize: 13, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                             ),
                     SizedBox(height: 12),
                  Text(
                    task?.noiDung??"",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                    ),
                  ),
                    ]))
                  ),
               );
               
               
            });
   
         }return Center(
                child: CircularProgressIndicator(),
              );
              }
            ) 
            
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
        title: Text(groups.name!,style: TextStyle(
                        fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'WorkSansSemiBold',
                       fontFeatures: [
                        FontFeature.enable('smcp'),
                  ],),),
    );
  }
   _showBottomSheet(BuildContext context,noctifiModel task){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: 
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
                Get.to(detailNoctifi(notify: task,));
               },
                
               clr: CustomTheme.primaryClr,
               context:context,
               ),
              _bottomSheetButton(
              label: "Re-UP",
               ontap: (){
               Get.back();
               }, 
               isClose: true,
               clr: Colors.red[300],
               context:context,
               ),
                  SizedBox(height: 20,),
                   _bottomSheetButton(
              label: "Delete Task",
               ontap: ()async{
                await NetworkHelper.DeleteNotify(task.id!).then((value) {
                  if(value==true){
                     Get.back();
                       Get.snackbar("Sucessful", "Good",
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.white,
                  colorText: Colors.green,
                  icon: Icon(Icons.warning_amber_rounded,
                  color: Colors.green,)
                  );
                  
                  }
                  else{
                       Get.back();
                  Get.snackbar("Wating", "",
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.white,
                  colorText: CustomTheme.yellowClr,
                  icon: Icon(Icons.warning_amber_rounded,
                  color: CustomTheme.yellowClr,)
                  );
              
                }
                }
                
                );
                
               
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