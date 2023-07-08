import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/model/Users.dart';
import 'package:da_tn_2023_appthongbao/model/groups.dart';
import 'package:da_tn_2023_appthongbao/theme.dart';
import 'package:flutter/material.dart';

class listUser_page extends StatefulWidget {
  final group groups;
  const listUser_page({super.key,required this.groups});

  @override
  State<listUser_page> createState() => _listUserState(groups: this.groups);
}

class _listUserState extends State<listUser_page> {
  final group groups;
  _listUserState({required this.groups});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,
    appBar: _appBar(),
    body:  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Text("List user: ",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
           Divider(),
            SizedBox(height: 20,),
            Expanded(
              child: 
                    FutureBuilder<List<userModel>>(
                      future: NetworkHelper.fecthuserforGroup(groups.id),
                      builder: (context, snapshot) {
                        if(snapshot.hasError){
                          return Center(child: Text('Error'),);
                        }
                        else if(snapshot.hasData){
                          var users = snapshot.data!;
                          return ListView.builder(
                              shrinkWrap: true,
                              itemCount: users.length,
                              itemBuilder: (context, index){
                                
                                return Card(
                                  shadowColor: Color.fromARGB(255, 0, 208, 52).withOpacity(0.5),
                                  child: ListTile(
                                          leading:   users[index].hinhDaiDien==null?
                                      CircleAvatar(
                                        backgroundColor: Colors.red,
                                        child: 
                                        Image(image: AssetImage('assets/img/pngwing.png') )
                                      
                                        ):CircleAvatar(
                                        backgroundImage: NetworkImage("${users[index].hinhDaiDien!}"),
                                        ),
                                        title:  Text(users[index].username!,style: titleStyle,),
                                         subtitle: Text(users[index].email!),
                                        
                                    
                                    ),
                                              
                                  );
                              
                              }
                            );
                      
                        }
                       return Center(
                          child: CircularProgressIndicator(),
                        );
                        }
                    ),
                      
                      ),
                  
               
                 
               
              ],
          
        ),
    ),
    );
    
  }
  _appBar(){
    return AppBar(
      elevation: 0,
       //backgroundColor: Colors.white,
      
        
      
         
    );
  }
}