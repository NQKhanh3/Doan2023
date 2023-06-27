import 'package:da_tn_2023_appthongbao/theme.dart';
import 'package:flutter/material.dart';

class listUser extends StatefulWidget {
  const listUser({super.key});

  @override
  State<listUser> createState() => _listUserState();
}

class _listUserState extends State<listUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: _appBar(),
    body: Column(
      children: [
        ListView(
          children: [
            
           Row(
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

             ],
           
           ),
          ],
        )
      ],
    ),
    );
  }
  _appBar(){
    return AppBar(
      elevation: 0,
       backgroundColor: Colors.white,
      
        
        actions: [ Icon(Icons.person_outlined, size: 20,color: Colors.grey,),
        SizedBox(width: 20,),
       
          ],
          
    );
  }
}