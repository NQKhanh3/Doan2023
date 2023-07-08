import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'package:da_tn_2023_appthongbao/controllers/db_controller.dart';
import 'package:da_tn_2023_appthongbao/model/Users.dart';
import 'package:da_tn_2023_appthongbao/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class userProfile extends StatefulWidget {
  userModel user;
  userProfile({super.key,required this.user});

  @override
  State<userProfile> createState() => _userProfileState(user:this.user );
}

class _userProfileState extends State<userProfile> {
  userModel user;
  _userProfileState({required this.user});
  var usernamecontroller =TextEditingController();
  @override
  void initState(){
    super.initState();
    
  }
  var check=true;
  @override
  Widget build(BuildContext context) {
    return Material(
      child:  SingleChildScrollView(
          //color: Colors.white,
      
            child: Column(
              
              children: <Widget>[
                Stack(
                 
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    
                    GestureDetector(
                      onTap: (){
                        _showBottomBackground(context);
                      },
                      child: Image(
                        height: MediaQuery.of(context).size.height/3,
                        fit: BoxFit.cover,
                        image: NetworkImage('https://xwatch.vn/images/news/2023/04/30/original/top-30-hoa-hau-hinh-nen-dep-sac-net-cho-dien-thoai-va-may-tinh-cover_1682873095.jpg')),
                    ),
                   
                    Positioned(
                      bottom: -50,
                      child:Container(
                       decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(80),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 5),
                            color: Colors.deepOrange.withOpacity(.2),
                            spreadRadius: 5,
                            blurRadius: 10
                          )
                        ]
                      ),
                      child:image==null? CircleAvatar(
                        child: user.hinhDaiDien!=null?Image(image: AssetImage('assets/img/pngwing.png'))
                        :Image(image:  AssetImage('assets/img/pngwing.png')),
                      radius: 80
                    ,backgroundColor: Colors.white,
                    //backgroundImage: AssetImage('assets/img/gundam.png'),
                    )
                     : CircleAvatar(
                      radius: 80
                    ,backgroundColor: Colors.white,
                    child: ClipOval(child: Image.file( 
                      File(image!.path).absolute,fit: BoxFit.cover,
                      width: 200,
                      height: 200,
                      )),
                    ))
                  ,
                      
                      ),
                      
                       ],
                       
                ),
               
                      Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                 
                  children: [
                    SizedBox(width: 100,),

                    Container(
                       decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(80),
                        
                        
                      ),

                      child:  IconButton(
                        onPressed: () {
                         _showBottomAvatar(context); 
                }, 
                icon: Icon(Icons.border_color) ,),
                    )
                       
                  ],
                ),
             
                SizedBox(height: 50,),
                
                Padding(
                  padding: EdgeInsets.all(20),
                child:Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 5),
                            color: Colors.deepOrange.withOpacity(.2),
                            spreadRadius: 5,
                            blurRadius: 10
                          )
                        ]
                      ),
                      
                      child: ListTile(
                        leading: Icon(Icons.mail),
                  title: Text('Email:',style: headingProfileText,),
                  subtitle: Text(user.email!,style: subProfileText,),
                  trailing: Icon(Icons.arrow_forward,color: Colors.grey,),
                ),
             
                    ),
                     SizedBox(height:20),
                
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 5),
                            color: Colors.deepOrange.withOpacity(.2),
                            spreadRadius: 5,
                            blurRadius: 10
                          )
                        ]
                      ),
                      child:  ListTile(
                      leading: Icon(Icons.person_outline),
                    title: Text('User name:',style: headingProfileText,),
                    subtitle: check!=true? TextField(
                      controller: usernamecontroller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText:user.username!, 
                      ),
                    ):
                    
                    Text(user.username!,style: subProfileText,),
                    trailing: GestureDetector(
                      child: Icon(Icons.arrow_forward,color: Colors.grey),
                      onTap: (){
                        setState(() {
                          check=!check;
                        });
                      },
                      ),
                ),
             
                    ),
                    
                  
                SizedBox(height:50),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      _showdaialog(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
                    ),
                    child: Text('Edit Profile')),
                )
                  ],
                ) ,)
                
              ],
            ),

    )
   ,
    );
    
  }
  File? image;
    Future<void> _showdaialog(BuildContext context,){
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
       
        return AlertDialog(
          title: const Text('Update Profile',style: TextStyle(),),
          content: Text('Bạn có chắc chắn.'
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
             TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                NetworkHelper.fetchPost_create(user.id, image!.path,usernamecontroller.text);
               //_checkoutGroup();
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> _showdaialoguser(BuildContext context){
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('update Group'),
          content:  TextField(
           // controller: namecontroller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
                ),
                hintText: 'group name',
              
            ),
            

          ),
          actions: <Widget>[
            TextButton(
              onPressed: (){ 
                Navigator.pop(context, 'Cancel');
                },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () { 
                
               // NetworkHelper.fecthGroupCreate(id.toString(),namecontroller.text);
                
                Get.back();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
  }
 
  Future pickImageGallery() async{
    try {
      final image= await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image==null) return;
      final imageTemp =File(image.path);
      
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('object $e');
      // TODO
    }

    
  }
    Future pickImageCamera() async{
    try {
      final image= await ImagePicker().pickImage(source: ImageSource.camera);
      if(image==null) return;
      final imageTemp =File(image.path);
      
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('object $e');
      // TODO
    }

    
  }
    _showBottomAvatar(BuildContext context,){
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
              label: "Gallery",
               ontap: ()async {
                await pickImageGallery();
                 
                 Get.back();
               }, 
               clr: Colors.blue,
               context:context,
               ),
                _bottomSheetButton(
              label: "camera",
               ontap: ()async{
                await pickImageCamera();
                 
                 Get.back();
               }, 
               clr: Colors.blue.shade300,
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
 
  _showBottomBackground(BuildContext context,){
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
              label: "Gallery",
               ontap: (){
                 
                 
                 Get.back();
               }, 
               clr: Colors.blue,
               context:context,
               ),
                _bottomSheetButton(
              label: "camera",
               ontap: (){
                 
                 
                 Get.back();
               }, 
               clr: Colors.blue.shade300,
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