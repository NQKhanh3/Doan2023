import 'package:da_tn_2023_appthongbao/controllers/task_controller.dart';
import 'package:da_tn_2023_appthongbao/ui/noctification_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../theme.dart';
import 'button.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  final _taskController =Get.put(TaskController());
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          Container(
                  color: Colors.white,
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
          
       
      
    );
  }
   _appBar(){
    return AppBar(
      elevation: 0,
       backgroundColor: Colors.white,
      
        
        actions: [ Icon(Icons.person_outlined, size: 20,color: Colors.grey,),
        SizedBox(width: 20,),
       
          ],
          
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text( 'Groups',
                style: subHeadingStyle,
                ),

                
                ],
              ),
              
              ),
             
               Mybutton(label: '+ Add Group', ontap:() async {
                  await  Get.to(()=>noctificaton());

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
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            
             padding: const EdgeInsets.all(20),
            itemCount: 5,
          
            itemBuilder:  ( _, index) {
              
              return 
               GestureDetector(
                    onTap:() async {
                  await  Get.to(()=>noctificaton());
                      _taskController.getTasks();
               },
                    child:Container(
                  decoration: BoxDecoration(
                    color: _getBGClr(0),
                    borderRadius: BorderRadius.circular(15)),
                padding: const EdgeInsets.all(8),
               
                child:   Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            child: Text('A'),
                          ),
                        Text( 'nhom A',style:subHeadingStyle ,),
                        ],
                        
                      ),

                    ),
                    Text('@ten nhom truong')


                     
              ]))
                );
               
               
            }),
    );
  }
 
 }