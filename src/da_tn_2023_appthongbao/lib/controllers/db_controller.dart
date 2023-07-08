import 'dart:convert';

import 'package:da_tn_2023_appthongbao/model/Users.dart';
import 'package:da_tn_2023_appthongbao/model/group_user.dart';
import 'package:da_tn_2023_appthongbao/model/groups.dart';
import 'package:da_tn_2023_appthongbao/model/noctifi.dart';
import 'package:da_tn_2023_appthongbao/pages/login_page.dart';
import 'package:da_tn_2023_appthongbao/ui/noctification_page.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';


  final String Url='http://10.0.2.2:8000/api/';
class NetworkHelper {


//Group-----------------
  static List<group> parseGroup(String r) {
    final Map<String, dynamic> parsed = jsonDecode(r);
    return List<group>.from(parsed['data'].map((x) => group.fromJson(x))).toList()?? [];
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
  
  static Future<void> fecthGroupCreate(String id_leader,String name) async {
     
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
       Get.toNamed('/home');
    }else
      print('Failed DeleteGroup');
  }
  
  static Future<void> outGroup(int id_user,int id_group)async{
    final response =
    await http.post(Uri.parse('$Url'+'group'),body: {'id_user':id_user,'id_group':id_group});
    if(response.statusCode==200){
      
      fecthGroup();
       Get.toNamed('/home');
    }else
      print('Failed outGroup');
  }
  
  static Future<void> updateGroup(int id,String name)async{
    final response =
    await http.put(Uri.parse('$Url'+'group/$id'),body: {'name':name});
    if(response.statusCode==200){
      final json = jsonDecode(response.body);
      fecthGroup();
       
    }
    
  }
  
  static Future<group> fecthGroupsById(int? id) async {
    final response =
        await http.get(Uri.parse('$Url'+'group/$id'));
        final jsons = jsonDecode(response.body);
      
        if(response.statusCode==200){
          
            print(json.decode(response.body)['data']);
            return group.fromJson(json.decode(response.body)['data']);
        }
        else 
        throw Exception([jsons['message']]);
       
       
  }
  
  static Future<List<group>> fecthGroupsforuser(int? id) async {
          final headers= {
      "Content-Type": "application/json",
      'authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
     };
    final response =
        await http.get(Uri.parse('$Url'+'UserForGroup/$id'));
       
      
        if(response.statusCode==200){
                return parseGroup(response.body);
        }
        else 
        throw Exception('message');
        
  }
  
  static Future<List<group>> showid_leader(int? id) async {
          final headers= {
      "Content-Type": "application/json",
      'authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
     };
    final response =
        await http.get(Uri.parse('$Url'+'showid_leader/$id'));
        if(response.statusCode==200){
                return parseGroup(response.body);
        }
        else 
        throw Exception('message');
        
  }


//User----------------
  static Future<void> fetchPost_create( int? id,
      String img,String username) async {
    // lay ten image

    var request = new http.MultipartRequest(
        "POST", Uri.parse(Url+'update/$id'))
      ..fields['username'] = username
      //..fields['iduser'] = id.toString()
      //..fields['idDiadanh'] = idDiadanh.toString()
      ..files.add(await http.MultipartFile.fromPath('image', img,
          contentType: MediaType('image', 'jpg')));
    request.send().then((response) {
      Get.back();
      if (response.statusCode == 200) print("Uploaded!");
      else return print("Fail!");
    });
   
    
  }

  static List<userModel> parseUser(String r) {
    final Map<String, dynamic> parsed = jsonDecode(r);
    return List<userModel>.from(parsed['data'].map((x) => userModel.fromJson(x)));
    //parse.map<group>((e) => group.fromJson(e)).toList();
  } 
  
  static Future<bool> ChangePassword(String password,String id,String newPass) async {
     
    final response =
              await http.post(Uri.parse('$Url'+'changepassword'),
                  //headers: {"Content-Type": "application/json"},
                  body: {'id': id, 'old_password': password,'New_password':newPass});
          if (response.statusCode == 200) {
            return true;
            //var token= json["token"];
            } 
             return false;
            
  }
  
  static Future<List<userModel>> fecthUser() async {
     
    final response =
        await http.get(Uri.parse('$Url'+'user'));
        if(response.statusCode==200){
           return parseUser(response.body);
        }
        throw Exception(['error']);
  }

  static Future<userModel> fecthusersById(String id) async {
   
   try{
      final response =
        await http.get(Uri.parse('$Url'+'user/$id'));
        final jsons = jsonDecode(response.body);
      
        if(response.statusCode==200){
          
          
        
         return userModel.fromJson(json.decode(response.body)['data']); 
        }
        else if(response.statusCode == 404){
        throw Exception([jsons['message']]);
        }
   }catch(e){
      throw Exception(e);
   }
    throw Exception([['message']]);
         
  }
  
  
  static Future<void> fetchuser_login(String email, String password) async {
  
      final response =
              await http.post(Uri.parse('$Url'+'login'),
                  //headers: {"Content-Type": "application/json"},
                  body: {'email': email, 'password': password});
          if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.setString("login",json);
            print("successfull");
            //var token= json["token"];
            } else if(response.statusCode == 401){
               print("sai mat khau");
            }
            //
            //throw jsonDecode(response.body)["message"];
  }

  Future<bool> tryAutoLogin()async{
    var pref =await SharedPreferences.getInstance();
    if(!pref.containsKey('login')){
      return false;

    }else
    return true;
  }

  static logOut()async{
    final prefs =await SharedPreferences.getInstance();
    prefs.clear();
    Get.off(()=>LoginPage());
  }

  static Future<bool> fetchuser_register(String email, String password,String username) async {
  
      final response =
              await http.post(Uri.parse('$Url'+'register'),
                  
                  body: ({'username':username,'email': email, 'password': password}));
          if (response.statusCode == 200) {
           print('successfull');
           return true;
          } else
            print('failed') ;
            return false;
  }


//notification   
  static List<noctifiModel> parsenoctifi(String r) {
    final parsed = jsonDecode(r)['data'];
    //print(parsed["data"]);
    return List<noctifiModel>.from(parsed.map((x) => noctifiModel.fromJson(x)));
    
  } 
  
  static Future<List<noctifiModel>> fecthnoctifi() async {
     
    final response =
        await http.get(Uri.parse('$Url'+'notice'));
        if(response.statusCode==200){
          //print(response.body);
           return parsenoctifi(response.body);
           
        }
        throw Exception(['error']);
  }
   
  static Future<List<noctifiModel>> showforGroup(int? id) async {
     
    final response =
        await http.get(Uri.parse('$Url'+'showforGroup/$id'));
        if(response.statusCode==200){
          //print(response.body);
           return parsenoctifi(response.body);
           
        }
        throw Exception(['error']);
  }
  
  static Future<noctifiModel> shownoctifiById(int? id) async {
     
    final response =
        await http.get(Uri.parse('$Url'+'notice/$id'));
        if(response.statusCode==200){
          //print(response.body);
           return noctifiModel.fromJson(json.decode(response.body)['data']); 
           
        }
        throw Exception(['error']);
  }

  static Future<bool> noctificatonCreate(
      String idgroup,
      String tieude,
      String noidung,
      String mausac,
      String ngay,
      String time,
      String laplai,

    ) async {
     
     final body=({
      'id_group':idgroup,
      'tieu_de':tieude,
      'noi_dung':noidung,
      'mau_sac':mausac,
      'ngay':ngay,
      'time':time,
      'lap_lai':laplai
     });
     final headers= {
      "Content-Type": "application/json",
      'authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
     };
    final response =
        await http.post(Uri.parse('$Url'+'notice'),body: body );
         if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            print(response.body);
            return true;
            //var token= json["token"];
            } else if(response.statusCode == 401){
                print(response.body);
               return false;
             
            }
            return false;           
  }

  static Future<bool> DeleteNotify(int id)async{
    final response =
    await http.delete(Uri.parse('$Url'+'notice/$id'));
    if(response.statusCode==200){
      return true;
      
    }else
      print('Failed DeleteGroup');
        return false;
  }
 

// group for user------------------
  static List<group_user> parsegroup_user(String r) {
    final parsed = jsonDecode(r)['data'];
    //print(parsed["data"]);
    return List<group_user>.from(parsed.map((x) => group_user.fromJson(x)));
    
  } 

  static Future<List<group_user>> fecthGroup_user() async {
     
    final response =
        await http.get(Uri.parse('$Url'+'groupuser'));
        if(response.statusCode==200){
          //print(response.body);
           return parsegroup_user(response.body);
           
        }
        throw Exception(['error']);
  }

  static Future<bool> fecthCreateG_U(String id_user,String id_group) async {
     
       final response =
        await http.post(Uri.parse('$Url'+'groupuser'),  body: {'id_user': id_user, 'id_group': id_group});
         if (response.statusCode == 200) {
            final json = jsonDecode(response.body);
            return true;
            } else {
                return false;
            }           
  }

  static Future<List<userModel>> fecthuserforGroup(int? id) async {
          final headers= {
      "Content-Type": "application/json",
      'authorization':'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
     };
    final response =
        await http.get(Uri.parse('$Url'+'groupforuser/$id'));
       
      
        if(response.statusCode==200){
                return parseUser(response.body);
        }
        else 
        throw Exception('message');
        
  }
  
  static Future<bool> show_request(int? id_user,int? id_group) async {
     final body={'id_user':id_user.toString(),'id_group':id_group.toString()} ;
    final response =
        await http.put(Uri.parse('$Url'+'groupuserstatus'),body: body);
        if(response.statusCode==200){
          print('thanh cong');
              return 
              true;
        }
        else 
        return false;
        
  }
 
  static Future<List<group_user>> fecthGroup_userbyIduser(int? id) async {
     
    final response =
        await http.get(Uri.parse('$Url'+'showid_user/$id'));
        if(response.statusCode==200){
          //print(response.body);
           return parsegroup_user(response.body);
           
        }
        throw Exception(['error']);
  }
 
  static Future<void> DeleteGroup_user(int id)async{
    final response =
    await http.delete(Uri.parse('$Url'+'groupuser/$id'));
    if(response.statusCode==200){
      
      fecthGroup();
       Get.toNamed('/home');
    }else
      print('Failed DeleteGroup');
  }
  
}





  