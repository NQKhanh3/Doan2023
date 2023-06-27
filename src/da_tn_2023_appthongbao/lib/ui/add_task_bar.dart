import 'package:da_tn_2023_appthongbao/controllers/task_controller.dart';
import 'package:da_tn_2023_appthongbao/model/task.dart';
import 'package:da_tn_2023_appthongbao/theme.dart';
import 'package:da_tn_2023_appthongbao/ui/button.dart';
import 'package:da_tn_2023_appthongbao/ui/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Addtaskpage extends StatefulWidget {
  const Addtaskpage({super.key});

  @override
  State<Addtaskpage> createState() => _AddtaskpageState();
}

class _AddtaskpageState extends State<Addtaskpage> {

  final TaskController _taskController=Get.put(TaskController());
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
                     SizedBox(width: 12,),
                      Expanded(
                    child: MyInputField(
                    title: "End Date",
                     hint: _endTime,
                     widget: IconButton(
                      onPressed: () {
                        _getTimeFormuser(isStarTime: false);
                      },
                      icon: Icon(Icons.access_time_rounded,
                      color: Colors.grey,
                      ),
                      ),
                     ),
                     )
                
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
              MyInputField(
                title: "Repeat", 
              hint: "$_selectedrepeat",
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
                  _selectedrepeat =newValue!;
                });
                
              }, 
              items: repeatList.map<DropdownMenuItem<String>>((String? value){
                return DropdownMenuItem<String>(
                   value: value,
                  child: Text(value!, 
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
                  Mybutton(label: "create Task", ontap:()=> _validateDate())
                   ],
              )
            ],
          ),
        ),
       ),
    );
  }
  _validateDate(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty){
      _addTaskToDB();
    
      Get.back();

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
  _addTaskToDB() async {
    int value = await _taskController.addtask(
      task:Task(
        note: _noteController.text,
        title: _titleController.text,
        date: DateFormat.yMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        remind: _selectedRemind,
        repeat: _selectedrepeat,
        color: _selectedColor,
        isCompleted: 0,
    )
    );
    
    print("my id :"+"$value");
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
        actions: [ Icon(Icons.person, size: 20,),
        SizedBox(width: 20,)
],
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
