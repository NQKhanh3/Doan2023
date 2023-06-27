import 'package:da_tn_2023_appthongbao/theme.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:da_tn_2023_appthongbao/controllers/task_controller.dart';
import 'package:intl/intl.dart';

class detailNoctifi extends StatefulWidget {
  const detailNoctifi({super.key});

  @override
  State<detailNoctifi> createState() => _detailNoctifiState();
}

class _detailNoctifiState extends State<detailNoctifi> {

  final _taskController =Get.put(TaskController());
  String _startTime= DateFormat("hh:mm a").format(DateTime.now()).toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:_appBar() ,
      body:Column(
      children: [
        SizedBox(height:20),
         Center(
          child: _showText('Hello, Khánh', headingStyle,),),
          
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
                _Titleheading(Icon(Icons.format_color_text,color:Colors.white,),'Title',colorTileStyle),
                _showText('nguyen quoc khánh',substyle ),
                _Titleheading(Icon(Icons.assignment,color:Colors.white,),'Note',colorTileStyle),
                _showText('khánh',substyle ),
                _Titleheading(Icon(Icons.access_time_rounded,color:Colors.white,),'Time',colorTileStyle),
                _showText(_startTime,substyle ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,

                  children: [Text('Viewer',style: subviewerText,),SizedBox(width: 10,)],
                  ),
                   SizedBox(height: 10,),
               _avatarmember()
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
  _Titleheading(Icon icon, String text,TextStyle style){
    return Padding(
      padding: EdgeInsets.only( left: 10,top: 20),
                child: Row(
                  children: [
                    
                   icon,
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