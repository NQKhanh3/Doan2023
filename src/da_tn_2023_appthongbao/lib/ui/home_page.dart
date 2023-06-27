import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/controllers/task_controller.dart';
import 'package:da_tn_2023_appthongbao/model/Users.dart';
import 'package:da_tn_2023_appthongbao/model/groups.dart';
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
  late  List<group> groups=[];
  late TextEditingController namecontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: _appBar(),
      body: SingleChildScrollView(
        
        child: Stack(
          
          children: [
            Container(
                
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.height,
              child: Image(
                image: AssetImage( 'assets/img/background2.png'),fit: BoxFit.cover,),),
            Column(
              children: [
                Container(
                       
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
          ],
        ),
      ),
          
       
      
    );
  }
   _appBar(){
    return AppBar(
      
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
                 _showdaialoguser(context,false);

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
    return FutureBuilder<List<group>>(
       future:  NetworkHelper.fecthGroup(),
      builder: (context, snapshot) {
         if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
         }
         else if(snapshot.hasData){
          groups = snapshot.data!;
           return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-255,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                
                 padding: const EdgeInsets.all(20),
                itemCount: groups.length,
              
                itemBuilder:  ( _, index) {
                  
                  return 
                   GestureDetector(
                        onTap:() async {
                      await  Get.to(()=>noctificaton());
                          _taskController.getTasks();
                   },
                   onDoubleTap: (){
                    _showBottomSheet(context,groups[index].id!);
                   },
                        child:Container(
                      decoration: BoxDecoration(
                        color: _getBGClr(0),
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.only(left: 5),
                   
                    child:   Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        ListTile(
                          leading:  CircleAvatar(
                            backgroundColor: Colors.cyan,
                            maxRadius: 10,
                                child: Text(groups[index].name!.substring(0, 1).toUpperCase()),
                              ),
                          title: 
                              Text( groups[index].name.toString(),style:groupNameStyle ,
                                  overflow: TextOverflow.ellipsis,
                              
                           
                           
                            
                          ),
    
                        ),
                        Text('@${groups[index].id_leader.toString()}')
    
    
                         
                  ]))
                    );
                   
                   
                }),
        );
     
         }
            return Center(
                child: CircularProgressIndicator(),
              );
        }
    );
  }
  Future<void> _showdaialoguser(BuildContext context,bool ai){
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: ai? const Text('update Group'): const Text('Add Group'),
          content:  TextField(
            controller: namecontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
                ),
                hintText: 'group name',
              labelText: ai?"text":null,
            ),
            

          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () { 
                ai?NetworkHelper.updateGroup(10,namecontroller.text):
                NetworkHelper.fecthGroupCreate(12,namecontroller.text);
                
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
  }
  _showBottomSheet(BuildContext context,int id){
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: MediaQuery.of(context).size.height*0.32,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
            ),
            Spacer(),
           _bottomSheetButton(
              label: "Completed",
               ontap: ()async{
                await  _showdaialoguser(context,true);
                //_taskController.markTaskCompleted(task.id!);
                  //Get.back();
               },
                
               clr: CustomTheme.primaryClr,
               context:context,
               ),
             
                _bottomSheetButton(
              label: "Delete",
               ontap: (){
                  NetworkHelper.DeleteGroup(id);
                 
                 Get.back();
               }, 
               clr: Colors.red[300],
               context:context,
               ),
                   SizedBox(height: 20,),
                  _bottomSheetButton(
              label: "Close",
               ontap: (){
                Get.back();
               }, 
               isClose: true,
               clr: Colors.red[300],
               context:context,
               ),
                SizedBox(height: 10,),

          ],
        ),
      )
    );
  }  
  _bottomSheetButton({
    required String label,
    required Function()? ontap,
    required Color? clr,
    required BuildContext context,
    bool isClose=false
  }){
    return GestureDetector(
      onTap:ontap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width*0.9,
        
        decoration: BoxDecoration(
          border: Border.all(width: 2,
         
          ),borderRadius: BorderRadius.circular(20),
           color: isClose==true?Colors.transparent:clr,
        ),
        child:Center(child: Text( 
          label,
          style: isClose?
          titleStyle:
          titleStyle.copyWith(color: Colors.white),
        ),) ,
      ),
    );
  }
 
 }