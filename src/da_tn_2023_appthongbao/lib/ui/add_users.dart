import 'dart:ui';

import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/model/Users.dart';
import 'package:da_tn_2023_appthongbao/model/group_user.dart';
import 'package:da_tn_2023_appthongbao/model/groups.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class addUser_page extends StatefulWidget {
  final group groups;
  const addUser_page({super.key,required this.groups});

  @override
  State<addUser_page> createState() => _addUser_pageState(groups: this.groups);
}

class _addUser_pageState extends State<addUser_page> {
  final group groups;
  _addUser_pageState({required this.groups});
  late List<userModel> user=[];
  late List<group_user> groupUser=[];
  void _updateList(String value){
    List<userModel> results =[];
    if(value.isEmpty){
      results = user;
    }
    else{
      results=user.where((element) => 
      element.email!.toLowerCase().
      contains(value.toLowerCase())).toList();
    }
    setState(() {
      user=results;
    });

  }
   @override
 void initState() {
    // TODO: implement initState
    //user=await NetworkHelper.fecthUser();
    super.initState();
    getDB();
    
   
  }
  var isloading=false;
  void getDB()async{
     //notify= await NetworkHelper.fecthnoctifi();
     user= await NetworkHelper.fecthUser();
     groupUser=await NetworkHelper.fecthGroup_user();
    }
    checktontai(int value){
      
        List<group_user> id_gruop=[];
        List<group_user> results=[];  

        id_gruop=groupUser.where((e) => e.idGroup == groups.id).toList();
        results =id_gruop.where((e) => e.idUser == value).toList();
        if(results.isNotEmpty){
          return true;
        }
        return false;

        
        
        
      
        
      
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar:_appBar() ,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Search Email user",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            TextField(
              onChanged: (value) => _updateList(value),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black26,
                border: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                   ),
                   hintText: "eg: @gmail.com",
                   prefixIcon: Icon(Icons.search),
                   prefixIconColor: Colors.grey
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child:user.isNotEmpty?

                 ListView.builder(
                  itemCount: user.length,
                  itemBuilder:(context, index) {
                    var isloading=true;
                    return Card (
                      child: ListTile(
                        leading: user[index].hinhDaiDien==null?
                        CircleAvatar(
                          child: 
                          Image(image: AssetImage('assets/img/pngwing.png'))
                        
                        ):CircleAvatar(
                          backgroundImage: NetworkImage("${user[index].hinhDaiDien!}"),
                        ),
                         title: Text(user[index].username!),
                         subtitle: Text(user[index].email!), 
                         
                         trailing: !checktontai(user[index].id!)? GestureDetector(
                           
                           onTap: (){
                            setState(() {
                              isloading=!isloading
                              ;
                            });
                            NetworkHelper.fecthCreateG_U(user[index].id!.toString(), groups.id.toString());
                          },
                           child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            height: 35,
                            width: 100,
                            decoration: BoxDecoration(
                                color: isloading?Colors.blue.shade700:Colors.transparent,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: isloading?Colors.transparent:Colors.grey.shade700,
                                )
                            ),
                              child: Center(child: Text("Add",style: TextStyle(color: Colors.white),) ,) ,
                             ),
                         ):null, 
                        
                      ),
                    );
                  },  
             
            ):Center(
              child: Text('No results Users'),)
              )
        ]),
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
        title: Center(
          child: Text("Add User",style: TextStyle(
                          fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 30,
                        fontFamily: 'WorkSansSemiBold',
                        ),),
        ),
  
    );
  }

}