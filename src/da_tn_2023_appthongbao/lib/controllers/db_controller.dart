import 'dart:convert';

import 'package:da_tn_2023_appthongbao/model/Users.dart';
import 'package:da_tn_2023_appthongbao/model/groups.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


  final String Url='http://10.0.2.2:8000/api/';
class NetworkHelper {


//Group-----------------
   static List<group> parseGroup(String r) {
    final Map<String, dynamic> parsed = jsonDecode(r);
    return List<group>.from(parsed['data'].map((x) => group.fromJson(x)));
    //parse.map<group>((e) => group.fromJson(e)).toList();
  } 
  static Future<List<group>> fecthGroup() async {
     
    final response =
        await http.get(Uri.parse('$Url'+'group'));
        if(response.statusCode==200){
           return parseGroup(response.body);
        }
        throw Exception(['error']);
  }
   static Future<void> fecthGroupCreate(int id_leader,String name) async {
     
    final response =
        await http.post(Uri.parse('$Url'+'group'),  body: {'id_leader': id_leader, 'name': name});
         if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            print("$json");
            //var token= json["token"];
            } else if(response.statusCode == 401){
               print("sai mat khau");
            }           
  }
  static Future<void> DeleteGroup(int id)async{
    final response =
    await http.delete(Uri.parse('$Url'+'group/$id'));
    if(response.statusCode==200){
      
      fecthGroup();
        print('successfull');
    }else
      print('Failed');
  }
    static Future<void> updateGroup(int id,String name)async{
    final response =
    await http.put(Uri.parse('$Url'+'group/$id'),body: {'name':name});
    if(response.statusCode==200){
      final json = jsonDecode(response.body);
      fecthGroup();
        print('successfull');
    }else
      print('Failed');
  }
//User----------------
   static List<users> parseUser(String r) {
    final Map<String, dynamic> parsed = jsonDecode(r);
    return List<users>.from(parsed['data'].map((x) => users.fromJson(x)));
    //parse.map<group>((e) => group.fromJson(e)).toList();
  } 
  static Future<List<users>> fecthUser() async {
     
    final response =
        await http.get(Uri.parse('$Url'+'user'));
        if(response.statusCode==200){
           return parseUser(response.body);
        }
        throw Exception(['error']);
  }
  static Future<void> fetchuser_login(String email, String password) async {
  
      final response =
              await http.post(Uri.parse('$Url'+'login'),
                  //headers: {"Content-Type": "application/json"},
                  body: {'email': email, 'password': password});
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            
            print("successfull");
            //var token= json["token"];
            } else if(response.statusCode == 401){
               print("sai mat khau");
            } 
            
            else{
              
            }
            //
            //throw jsonDecode(response.body)["message"];
  }
  static Future<void> fetchuser_register(String email, String password,String username) async {
  
      final response =
              await http.post(Uri.parse('$Url'+'register'),
                  
                  body: ({'username':username,'email': email, 'password': password}));
          if (response.statusCode == 200) {
           print('successfull');
          } else
            print('failed') ;
  }
}

  