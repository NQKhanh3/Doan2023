import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/model/Users.dart';
import 'package:da_tn_2023_appthongbao/model/noctifi.dart';
import 'package:da_tn_2023_appthongbao/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:da_tn_2023_appthongbao/controllers/task_controller.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class detailNoctifi extends StatefulWidget {
  final noctifiModel notify;
  const detailNoctifi({super.key,required this.notify});

  @override
  State<detailNoctifi> createState() => _detailNoctifiState(notify: this.notify);
}

class _detailNoctifiState extends State<detailNoctifi> {
  
  final noctifiModel notify;
  late  List<userModel> users=[];
  _detailNoctifiState({required this.notify});
  final _taskController =Get.put(TaskController());
  String _startTime= DateFormat("hh:mm a").format(DateTime.now()).toString();
     @override
  void initState(){
    super.initState();
    getCred();
    getnDB();

  }
    void getnDB()async{
    
     users= await NetworkHelper.fecthUser();
    }
  int? id=13;
  void getCred()async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    setState(() {
        //access_token = pref.getString('login')!;
        id =(pref.getInt('data')??0);
    });
  }
    _getname(){
      List<userModel> results =[];
      results=users.where((element) => 
      element.id==id).toList();
      if(results.isNotEmpty){
        return _showText('Hello, ${results[0].username}', headingStyle,);
      }
        return _showText('Hello, Khánh', headingStyle,);
    } 
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_appBar() ,
      body:Column(
      children: [
        SizedBox(height:20),
         Center(
          child: _getname(),),
          
           Center(
          child: _showText("you have a new reminder", subTextstyle)),
          SizedBox(height:30),
          Container(
            height: 450,
           width: MediaQuery.of(context).size.width*0.9,
            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(40),
              color: CustomTheme.primaryClr,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              
              children: [
                _Titleheading(Icons.format_color_text,'Title',colorTileStyle),
                _showText(notify.tieuDe!,substyle ),
                _Titleheading(Icons.assignment,'Note',colorTileStyle),
                _showText(notify.noiDung!,substyle ),
                _Titleheading(Icons.access_time_rounded,'Time',colorTileStyle),
                
                  _showText('${notify.ngay!} - ${notify.time!}',substyle ),
                  
                
               
                SizedBox(height: 20,),
                //Row(
                  //mainAxisAlignment: MainAxisAlignment.end,

                  //children: [Text('Viewer',style: subviewerText,),SizedBox(width: 10,)],
                 // ),
                 //  SizedBox(height: 10,),
               //_avatarmember()
              ],

            ),
          )

      ]) ,
    );
  }
 Future<void> _showdaialoguser(BuildContext context){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
       
        return AlertDialog(
          title: const Text('list of users viewed'),
          backgroundColor: Colors.white70,
         
          content: 
          
          
          
           Expanded(
        
             child: Column(
                
              children: [
                 Container(
                      height: 530 ,
                    width: 280,
                    decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                               
                              ),
                   child: ListView(
                            shrinkWrap: true,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                               
                              ),
                                child: ListTile(
                                  
                                  title:  Row(
                                    children: [
                                      CircleAvatar(
                                            child: Text('T'),
                                            backgroundColor: Colors.red,
                                      ),
                                      SizedBox(width: 10,),
                                       Text('username',style: titleStyle,)
                                    ],
                                  ),
                                      subtitle: Text('@email'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                               
                              ),
                                child: ListTile(
                                  
                                  title:  Row(
                                    children: [
                                      CircleAvatar(
                                            child: Text('T'),
                                            backgroundColor: Colors.red,
                                      ),
                                      SizedBox(width: 10,),
                                       Text('username',style: titleStyle,)
                                    ],
                                  ),
                                      subtitle: Text('@email'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                               
                              ),
                                child: ListTile(
                                  
                                  title:  Row(
                                    children: [
                                      CircleAvatar(
                                            child: Text('T'),
                                            backgroundColor: Colors.red,
                                      ),
                                      SizedBox(width: 10,),
                                       Text('username',style: titleStyle,)
                                    ],
                                  ),
                                      subtitle: Text('@email'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                               
                              ),
                                child: ListTile(
                                  
                                  title:  Row(
                                    children: [
                                      CircleAvatar(
                                            child: Text('T'),
                                            backgroundColor: Colors.red,
                                      ),
                                      SizedBox(width: 10,),
                                       Text('username',style: titleStyle,)
                                    ],
                                  ),
                                      subtitle: Text('@email'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                               
                              ),
                                child: ListTile(
                                  
                                  title:  Row(
                                    children: [
                                      CircleAvatar(
                                            child: Text('T'),
                                            backgroundColor: Colors.red,
                                      ),
                                      SizedBox(width: 10,),
                                       Text('username',style: titleStyle,)
                                    ],
                                  ),
                                      subtitle: Text('@email'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                               
                              ),
                                child: ListTile(
                                  
                                  title:  Row(
                                    children: [
                                      CircleAvatar(
                                            child: Text('T'),
                                            backgroundColor: Colors.red,
                                      ),
                                      SizedBox(width: 10,),
                                       Text('username',style: titleStyle,)
                                    ],
                                  ),
                                      subtitle: Text('@email'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                               
                              ),
                                child: ListTile(
                                  
                                  title:  Row(
                                    children: [
                                      CircleAvatar(
                                            child: Text('T'),
                                            backgroundColor: Colors.red,
                                      ),
                                      SizedBox(width: 10,),
                                       Text('username',style: titleStyle,)
                                    ],
                                  ),
                                      subtitle: Text('@email'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                               
                              ),
                                child: ListTile(
                                  
                                  title:  Row(
                                    children: [
                                      CircleAvatar(
                                            child: Text('T'),
                                            backgroundColor: Colors.red,
                                      ),
                                      SizedBox(width: 10,),
                                       Text('username',style: titleStyle,)
                                    ],
                                  ),
                                      subtitle: Text('@email'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                               
                              ),
                                child: ListTile(
                                  
                                  title:  Row(
                                    children: [
                                      CircleAvatar(
                                            child: Text('T'),
                                            backgroundColor: Colors.red,
                                      ),
                                      SizedBox(width: 10,),
                                       Text('username',style: titleStyle,)
                                    ],
                                  ),
                                      subtitle: Text('@email'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                               
                              ),
                                child: ListTile(
                                  
                                  title:  Row(
                                    children: [
                                      CircleAvatar(
                                            child: Text('T'),
                                            backgroundColor: Colors.red,
                                      ),
                                      SizedBox(width: 10,),
                                       Text('username',style: titleStyle,)
                                    ],
                                  ),
                                      subtitle: Text('@email'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                               
                              ),
                                child: ListTile(
                                  
                                  title:  Row(
                                    children: [
                                      CircleAvatar(
                                            child: Text('T'),
                                            backgroundColor: Colors.red,
                                      ),
                                      SizedBox(width: 10,),
                                       Text('username',style: titleStyle,)
                                    ],
                                  ),
                                      subtitle: Text('@email'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                               
                              ),
                                child: ListTile(
                                  
                                  title:  Row(
                                    children: [
                                      CircleAvatar(
                                            child: Text('T'),
                                            backgroundColor: Colors.red,
                                      ),
                                      SizedBox(width: 10,),
                                       Text('username',style: titleStyle,)
                                    ],
                                  ),
                                      subtitle: Text('@email'),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                               
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                               
                              ),
                                child: ListTile(
                                  
                                  title:  Row(
                                    children: [
                                      CircleAvatar(
                                            child: Text('T'),
                                            backgroundColor: Colors.red,
                                      ),
                                      SizedBox(width: 10,),
                                       Text('username',style: titleStyle,)
                                    ],
                                  ),
                                      subtitle: Text('@email'),
                                ),
                              ),
                            ),
                           
                           ],),
                 ),
           
                    
                    
              
                  
              ],
             
                     ),
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
  _avatarmember(){
    return  GestureDetector(
      onTap: () {
        _showdaialoguser(context);
      },
      child: Container(
        padding: EdgeInsets.only(left: 10),
        child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                       
                      children: [

                             CircleAvatar(
                          child: Text('T'),
                          backgroundColor: Colors.red,),
                        
                           CircleAvatar(
                          child: Text('K'),
                          backgroundColor: Colors.blue,),
                         
                        
                             CircleAvatar(
                          child: Text('N'),
                          backgroundColor: Colors.yellow,),
                          
                           CircleAvatar(
                            child: Text('+10',style: TextStyle(color: Colors.black54),),
                            backgroundColor: Colors.grey,),
                        
    
    
                          ],
                        )
                       
      
                 
      ),
    );
  }
  _Titleheading(IconData icon, String text,TextStyle style){
    return Padding(
      padding: EdgeInsets.only( left: 10,top: 20),
                child: Row(
                  children: [
                    
                   Icon(icon,color:Colors.white,)
                   ,
                   SizedBox(width: 10,),
                    _showText(text, style),
                  ],
                )
                );
  }
  _showText(String _text, TextStyle _style ){
    return Padding(padding: EdgeInsets.only( left: 10,top: 10),child: Text(_text,
    style: _style,),) ;
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
    );
  }
 
}