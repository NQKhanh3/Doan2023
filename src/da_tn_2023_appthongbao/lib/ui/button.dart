import 'package:flutter/material.dart';
import 'package:da_tn_2023_appthongbao/theme.dart';
class Mybutton extends StatelessWidget {
  final String label;
  final Function()? ontap; 
  const Mybutton({super.key,required this.label, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: 
        
        Container(
        
        width: 100,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: CustomTheme.primaryClr
        ),
        child:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ Text(
           label,
        style: TextStyle(
          color: CustomTheme.white,
        
        ),),]
        )
      ),
      
      
    );
  }
}