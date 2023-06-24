import 'package:da_tn_2023_appthongbao/ui/noctification_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../theme.dart';
import 'button.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appBar(),
      body: Column(
        children: [
          _apptaskbar()
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
             
               Mybutton(label: '+ Add Group', ontap:() async {
                  await  Get.to(()=>noctificaton());
                      ;
               }
               
                )
  
            ],
          )
        ,
        );     
  }
 }