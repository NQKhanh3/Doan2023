

import 'package:da_tn_2023_appthongbao/db/dbhelper.dart';
import 'package:get/get.dart';

import '../model/task.dart';

class TaskController extends GetxController{
  @override
  void onReady(){
      getTasks();
    super.onReady();
  
    
  }
    var tasksList=<Task>[].obs;
  Future<int>addtask({Task? task})async{
    return await DBhelper.insert(task);
  }

  void getTasks()async{
    List<Map<String,dynamic>>tasks=await DBhelper.query();
     tasksList.assignAll(tasks.map((e) =>new  Task.fromJson(e)).toList());
    
  }
  void delete(Task task){
   var val= DBhelper.delete(task);
   getTasks();

  }
  void markTaskCompleted(int id)async{
    await DBhelper.update(id);
    getTasks();
  }
}