import 'dart:ui';

import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/model/Users.dart';
import 'package:da_tn_2023_appthongbao/model/groups.dart';
import 'package:da_tn_2023_appthongbao/model/noctifi.dart';
import 'package:da_tn_2023_appthongbao/theme.dart';
import 'package:da_tn_2023_appthongbao/ui/noctification_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class mygroup extends StatefulWidget {
  final userModel user ;
  mygroup({super.key,required this.user});

  @override
  State<mygroup> createState() => _mygroupState(users: this.user);
}

class _mygroupState extends State<mygroup> {
   final userModel users ;
  _mygroupState({required this.users});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_appBar() ,
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              child: const Row(
                children:[
                 Text('My Group',style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 176, 7),
              ),),
                ]
              ),
              
            ),
              Padding(
                padding: const EdgeInsets.only(left: 100),
                child: Divider(thickness: 2,color: Color.fromARGB(255, 150, 7, 7),),
              ),
              SizedBox(height: 20,),
              Expanded(
                child: FutureBuilder<List<group>>(
                  future: NetworkHelper.showid_leader(users.id),
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Text('Error');
                    }
                    else if(snapshot.hasData){
                     var groups= snapshot.data!;
                      return  ListView.builder(
                  shrinkWrap: true,
                  itemCount: groups.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => noctificaton(groups: groups[index]));
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left:30,right: 30, top: 20),
                      child: Container(
                        
                        decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
                             boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 5),
                                  color:  Color.fromARGB(255, 4, 145, 6)..withOpacity(.4),
                                  spreadRadius: 5,
                                  blurRadius: 10
                                )]                     
                        ),
                     
                        child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(groups[index].name!,)
                                    ),
                                  
                                    Card(
                                      child: FutureBuilder<List<noctifiModel>>(
                                        future: NetworkHelper.showforGroup(groups[index].id),
                                        builder: (context, snapshot) {
                                          if(snapshot.hasError){
                                            return Center(child: Text('chưa có thông báo',style: subTextstyle,));
                                            
                                          }else if(snapshot.hasData){
                                           var notifi =snapshot.data!;
                                           if(notifi.isNotEmpty){
                                             return  ListView.builder(
                                      itemCount: 1,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          leading: Icon(Icons.attach_file),
                                          title: Text(notifi[index].tieuDe!),
                                          subtitle: Text(notifi[index].time!),
                                        );
                                      },
                                    );
                                          
                                           }else{
                                            return ListTile(title: Text('chưa có thông báo'));
                                           }

                                           }
                                          return Text('chưa có thông báo');
                  
                                        },)
                  
                  
                                    )
                                  ],
                                ),
                  
                      ),
                    ),
                  );
                },
              
                );
             
                    } 
                   return Center(
                    child: CircularProgressIndicator(),
                   );
                  }
                  
                  ,)
                
                ) 
          ],
        ),
      ),
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
        title: Text(users.username.toString(),style: TextStyle(
                        fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 30,
                      fontFamily: 'WorkSansSemiBold',
                       fontFeatures: [
                        FontFeature.enable('smcp'),
                  ],),),
  
    );
  }
}