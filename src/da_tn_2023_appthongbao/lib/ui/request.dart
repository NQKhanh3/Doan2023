import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/model/Users.dart';
import 'package:da_tn_2023_appthongbao/model/group_user.dart';
import 'package:da_tn_2023_appthongbao/model/groups.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Request_page extends StatefulWidget {
   final userModel user ;
  const Request_page ({super.key,required this.user});

  @override
  State<Request_page > createState() => _Request_pageState(users:this.user );
}

class _Request_pageState extends State<Request_page > {
   final userModel users ;
  _Request_pageState({required this.users});
    late List<userModel> user=[];
    late List<group> groups=[];
  late List<group_user> groupUser=[];
   @override
 void initState() {
    // TODO: implement initState
    //user=await NetworkHelper.fecthUser();
    super.initState();
    getDB();
  }
  void _update(){
    List<group_user> results =[];
   
 
      results=groupUser.where((element) => 
      element.idUser == users.id
      ).toList();
 
    setState(() {
      groupUser=results;
    });

  }
    void getDB()async{
     //notify= await NetworkHelper.fecthnoctifi();
     user= await NetworkHelper.fecthUser();
     groupUser=await NetworkHelper.fecthGroup_user();
     groups=await NetworkHelper.fecthGroup();
    }
    _nameuser(int value){
      List<userModel> results=[];
      List<group> data=[];
      data =groups.where((element) => element.id ==value).toList();
     results= user.where((e) => e.id==groups[0].idLeader).toList(); 
     
      if(results.isNotEmpty){
        return ListTile(
          title: Row(
            children: [
              Text("${results[0].username }",style: TextStyle(fontWeight: FontWeight.bold),),
               Text(' mời bạn tham gia vào nhóm của họ'),
            ],
          ),
        );

      }
      return Container();
    }
    _button(String? text,Function()? ontap,bool bool){
      return  OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor:  bool?Colors.blue:Colors.grey.shade100,
                ),
              onPressed: ontap,
              child: Text(text.toString() ,style: TextStyle(
                color: bool? Colors.white:Colors.black
              ),),
            );
    }
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
           Text("List your request: ",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold),),
           Divider(),
            SizedBox(height: 20,),
            Expanded(
              child:  
                  FutureBuilder<List<group_user>>(
                    future: NetworkHelper.fecthGroup_userbyIduser(users.id),
                    builder: (context, snapshot) {
                      if(snapshot.hasError){
                        return Center(child: Text("ERROR"),);
                      }
                      if(snapshot.hasData){
                        var g=snapshot.data!;
                      return 
                       ListView.builder(
                          shrinkWrap: true,
                          itemCount: g.length,
                          itemBuilder: (context, index){
                            
                            return AnimationConfiguration.staggeredList(
                      position: index, 
                      child: SlideAnimation(
                        child:FadeInAnimation(
                          child:
                            Card(
                              color: Colors.black12,
                              shadowColor: Color.fromARGB(255, 0, 208, 52).withOpacity(0.5),
                              child: Column(
                                children: [
                                 _nameuser(g[index].idGroup!),
                                  
                                  if(g[index].trangThai==0)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                     _button("OK", 
                                     (){NetworkHelper.show_request(g[index].idUser, g[index].idGroup);}, true),
                                      _button("Revome", 
                                      () => {NetworkHelper.DeleteGroup_user(g[index].id!)}, false),
                                      
                                  ],)
                                ],
                              )
                            )
                        )
                      )
                                );
                          }
                        );
                    
                      }
                      else return Container();
                     }
                  )

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