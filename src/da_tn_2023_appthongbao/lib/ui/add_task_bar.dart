import 'dart:convert';

import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/controllers/task_controller.dart';
import 'package:da_tn_2023_appthongbao/model/groups.dart';
import 'package:da_tn_2023_appthongbao/model/task.dart';
import 'package:da_tn_2023_appthongbao/services/firebase_api.dart';
import 'package:da_tn_2023_appthongbao/theme.dart';
import 'package:da_tn_2023_appthongbao/ui/button.dart';
import 'package:da_tn_2023_appthongbao/ui/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class Addtaskpage extends StatefulWidget {
  final group groups;
  const Addtaskpage({super.key,required this.groups});

  @override
  State<Addtaskpage> createState() => _AddtaskpageState(groups: this.groups);
}

class _AddtaskpageState extends State<Addtaskpage> {
final group groups;
_AddtaskpageState({required this.groups});
  //final TaskController _taskController=Get.put(TaskController());
  final TextEditingController _titleController =TextEditingController();
  final TextEditingController _noteController =TextEditingController();

  DateTime _selectedDate =DateTime.now();
  String _endTime="9:30PM";
  String _startTime= DateFormat("hh:mm a").format(DateTime.now()).toString();
  List<int> remindList=[
    5,
    10,
    15,
    20,
  ];
  int _selectedRemind=5;
  List<String> repeatList=[
   "none",
   "Daily",
   "Weekly",
   "Monthly",
  ];
  String _selectedrepeat="none";
   int _selectedColor=0;
   FirebaseNotify notifyFirebase=FirebaseNotify();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:_appBar() ,
       body: Container(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: SingleChildScrollView(

          child: Column(
            children: [
              Text(
                'Add Task',
                style: headingStyle,
              ),
              MyInputField(title: "Title", hint: "Enter your title",controller: _titleController,),
              MyInputField(title: "Note", hint: "Enter your note",controller: _noteController,),
              MyInputField(title: "date", hint: DateFormat.yMd().format(_selectedDate),
              widget: IconButton(onPressed: () {
             
                _getDateFormuser();
              },
              icon: Icon(Icons.calendar_today_outlined),
              ),
              ),
             
              Row(
                children: [
                  Expanded(
                    child: MyInputField(
                    title: "Start Date",
                     hint: _startTime,
                     widget: IconButton(
                      onPressed: () {
                        _getTimeFormuser(isStarTime: true);
                      },
                      icon: Icon(Icons.access_time_rounded,
                      color: Colors.grey,)),
                     ),
                     ),
                    
                     
                
                ],
              ),
              MyInputField(
                title: "remind", 
              hint: "$_selectedRemind minutes earl",
              widget: DropdownButton( 
              icon: Icon(Icons.keyboard_arrow_down,
              color:Colors.grey ,),
              iconSize: 32,
              elevation: 4,
              style: subtitleStyle,
              underline: Container(height: 0,
               color: Colors.black,),
              onChanged:  (String? newValue) {
                setState(() {
                  _selectedRemind =int.parse(newValue!);
                });
                
              }, 
              items: remindList.map<DropdownMenuItem<String>>((int value){
                return DropdownMenuItem<String>(
                   value: value.toString(),
                  child: Text(value.toString(), 
                  style: TextStyle(color: Colors.grey), ),
                );
              },
              ).toList(),
              ),
              
              ),
              SizedBox(height: 18,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _colorPallete(),
                  Mybutton(label: "create Task", ontap:(){ _validateDate();_guinotify();})
                   ],
              )
            ],
          ),
        ),
       ),
    );
  }
  _guinotify(){
    notifyFirebase.getDeviceToken().then((value) async{


      var body ={
        'to':'/topics/${groups.id}',
        'notification':{
          'title':'${_titleController.text}',
          'body':'${_noteController.text}',

        },
        'data':{
          'type':'msj',
          'id':'1010'
        }
        

      };
      var headers={
         "Content-Type": "application/json",
         'authorization': "key=AAAAzhortxw:APA91bFNL-3H0DDgJi_HnzecfYg2JD408xVLnilGi7Ei4FRc_IjHkEdHy28fiaQNQwdxcdbwjvk8lD2vl2AZIPU97Wih425crPgFjTAVnzXF00te_iZSwlqx4qd50Y8jX2mwONFNeLs2"

        };
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
      body:jsonEncode(body) ,
      headers:headers ,);
    });
  }
  _validateDate(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty){
      //add noctification
      _checkCreate();

    }else if(_titleController.text.isEmpty||_noteController.text.isEmpty){
      Get.snackbar("required", "All field are require !",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.white,
      colorText: CustomTheme.pinkColor,
      icon: Icon(Icons.warning_amber_rounded,
      color: Colors.red,)
      );
      
    }
  }
 _checkCreate(){
    NetworkHelper.noctificatonCreate(
        groups.id.toString(), 
        _titleController.text, 
        _noteController.text, 
        _selectedColor.toString(),
        DateFormat.yMd().format(_selectedDate), 
        _startTime.toString(), 
        _selectedRemind.toString()
        ).then((value) {
          if(value){
             Get.back();
          }
          else{
             Get.snackbar("ERORR", "Create fail!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.white,
            colorText: CustomTheme.pinkColor,
            icon: Icon(Icons.warning_amber_rounded,
            color: Colors.red,)
            );
          }

        });
 }
  _appBar(){
    return AppBar(
      elevation: 0,
       backgroundColor: Color(0xFFfbab66),
        leading: GestureDetector(
          onTap: (){
            Get.back();

          },
          child: Icon(Icons.arrow_back,
          size: 20,
          
          ),
        ),
       
    );
  }
  _getDateFormuser()async{
    DateTime? _pickerdate =  await showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020),
       lastDate: DateTime(2025)
       );
       if(_pickerdate!=null){
        setState(() {
          _selectedDate=_pickerdate;
          print(_selectedDate);
        });
       }else{
          print("it's null or something is wrong");
       }
  }
  _getTimeFormuser({required bool isStarTime})async{
   var _Pickedtime=await _showTimepicker();
  String _formatedTime =_Pickedtime.format(context);
  if(_Pickedtime==null){
    print("time cannel");
  }
  else if(isStarTime==true){
    setState(() {
       _startTime=_formatedTime;
    });
   
 
  }else if(isStarTime==false){
    setState(() {
         _endTime=_formatedTime;
    });
 

  }
  }
  _showTimepicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
     initialTime: TimeOfDay(
      hour: int.parse(_startTime.split(":")[0]),
     minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
     )
     );
  }
  _colorPallete(){
    return Column(
                    children:[
                      Text("Color",
                      style: titleStyle,
                      ),
                      Wrap(
                        children:List<Widget>.generate(
                          3,
                           (int index){
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                   _selectedColor=index;
                                });
                               
                              },
                              child: Padding(
                              padding: const EdgeInsets.only(right: 8.0,),
                           child: CircleAvatar(
                              radius: 14,
                              backgroundColor:index==0? 
                              CustomTheme.primaryClr:index==1?
                              CustomTheme.pinkColor:
                              CustomTheme.yellowClr,
                            child: _selectedColor==index? Icon(Icons.done,
                            color: Colors.white,
                            size: 16,
                            ):Container(),
                            )
                            ,)
                            );
                            
                            
                            
                            
                           }),
                      )
                    
                    ]
                  );
               

  }

}
