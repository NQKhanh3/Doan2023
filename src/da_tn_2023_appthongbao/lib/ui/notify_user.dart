import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/model/Users.dart';
import 'package:da_tn_2023_appthongbao/model/groups.dart';
import 'package:da_tn_2023_appthongbao/model/noctifi.dart';
import 'package:da_tn_2023_appthongbao/theme.dart';
import 'package:da_tn_2023_appthongbao/ui/detail_noctifi_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class notifyuser_page extends StatefulWidget {
  final userModel user;
  const notifyuser_page({super.key,required this.user});

  @override
  State<notifyuser_page> createState() => _notifyuser_pageState(user: this.user);
}

class _notifyuser_pageState extends State<notifyuser_page> {
  final userModel user;
  _notifyuser_pageState({required this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<List<group>>(
              future: NetworkHelper.fecthGroupsforuser(user.id!),
              

              builder: (context, snapshot) {
                if(snapshot.hasError){
                  return Center(child: Text('ERROR'),);
                }
                else if(snapshot.hasData){
                  var groups =snapshot.data!;
                     return Expanded(
                  child: ListView.builder(
                    shrinkWrap: false,
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(groups[index].name!,style: subHeadingStyle,),
                          Divider(thickness: 1.3),
                        
                           _showTaskFormgridview(groups[index])

                          
                         
                        ],
                      ),
                    );
                    
                    
                  },));
              
                }
                return Center(
                          child: CircularProgressIndicator(),);
             }
             
            )
      
      
           // _showTaskFormgridview();
           
          ],
        ),
      ),

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
    DateTime _selectedDate =DateTime.now();
  _showTaskFormgridview(group group){
    return  FutureBuilder<List<noctifiModel>>(
              future:  NetworkHelper.showforGroup(group.id),
              builder: (context, snapshot) {
         if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
         } else if(snapshot.hasData){
          var nocti = snapshot.data!;

          if(nocti.isEmpty){
            return Center(child: Text('không có thông báo'),);
          }
           return ListView.builder(
           
             padding: const EdgeInsets.all(20),
            shrinkWrap: true,
           
            itemCount: nocti.length,
            itemBuilder:  ( _, index) {
                var task=nocti[index];
              return task.ngay == DateFormat.yMd().format(_selectedDate)?
              
              GestureDetector(
                        onTap: () {
                          Get.to( detailNoctifi(notify: task,));
                          //_showBottomSheet(context,task);
                        },
                        child:Container(
                      decoration: BoxDecoration(
                        color: _getBGClr(task?.mauSac??0),
                        borderRadius: BorderRadius.circular(15)),
                    padding: const EdgeInsets.all(8),
                   
                    child:   Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                      Text( task.tieuDe.toString(),style:titleStyle ,),
                      
                               
                       SizedBox(height: 12),
                    Flexible(
                      child: Text(
                        task?.noiDung??"",
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                        ),
                        overflow:TextOverflow.fade ,
                      ),
                    ),
                      ]))
                   
                 
               ):Container() ;
               
               
            });
   
         }return Center(
                child: CircularProgressIndicator(),
              );
              }
             
            );
  }
 
   _appBar(){
    return AppBar(
      elevation: 0,
       backgroundColor:Color(0xFFfbab66) ,
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
 
}