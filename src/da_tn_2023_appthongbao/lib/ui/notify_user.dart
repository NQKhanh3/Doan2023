import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/model/Users.dart';
import 'package:da_tn_2023_appthongbao/model/groups.dart';
import 'package:da_tn_2023_appthongbao/model/noctifi.dart';
import 'package:da_tn_2023_appthongbao/theme.dart';
import 'package:da_tn_2023_appthongbao/ui/detail_noctifi_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
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
                          Text(groups[index].name!,style: subtitleStyle,),
                          Divider(),
                          _showTaskFormgridview(groups[index].id)

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
  _showTaskFormgridview(groups){
    return Expanded(
            child: FutureBuilder<List<noctifiModel>>(
              future:  NetworkHelper.showforGroup(groups.id),
              builder: (context, snapshot) {
         if (snapshot.hasError) {
                return Center(
                  child: Text('Error'),
                );
         } else if(snapshot.hasData){
          var nocti = snapshot.data!;
           return GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            
             padding: const EdgeInsets.all(20),
            itemCount: nocti.length,
          
            itemBuilder:  ( _, index) {
                var task=nocti[index];
              return 
               AnimatedContainer(
                duration: Duration(seconds: 3),
                 child: GestureDetector(
                      onTap: () {
                        detailNoctifi(notify: task,);
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
                         Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${task!.time}",
                        style: GoogleFonts.lato(
                          textStyle:
                          TextStyle(fontSize: 14, color: Colors.grey[100]),
                        ),
                      ),
                 
                    ],
                             ),
                             Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today_outlined,
                        color: Colors.grey[200],
                        size: 18,
                      ),
                      SizedBox(width: 4),
                      Text(
                        "${task!.ngay}",
                        style: GoogleFonts.lato(
                          textStyle:
                          TextStyle(fontSize: 13, color: Colors.grey[100]),
                        ),
                      ),
                    ],
                             ),
                     SizedBox(height: 12),
                  Text(
                    task?.noiDung??"",
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(fontSize: 15, color: Colors.grey[100]),
                    ),
                  ),
                    ]))
                  ),
               );
               
               
            });
   
         }return Center(
                child: CircularProgressIndicator(),
              );
              }
            ) 
            
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