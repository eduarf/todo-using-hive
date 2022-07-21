import 'package:github_todo/model/task_model.dart';
import 'package:hive/hive.dart';

abstract class LocalStorage {
  Future<void> addTask({required Task task});
  Future<void> deleteTask({required Task task});
  Future<List<Task>> returnAllTask();
  Future<Task> editTask({required Task task}); 
}

class HiveLocalStorage extends LocalStorage {

  late Box<Task> hiveBox;
  HiveLocalStorage(){
    hiveBox = Hive.box<Task>('tasks'); 
    }
  @override
  Future<void> addTask({required Task task}) async{
    await hiveBox.put(task.uuid, task);
  }

  @override
  Future<void> deleteTask({required Task task}) async{
    await hiveBox.delete(task.uuid);
  }

  @override
  Future<Task> editTask({required Task task}) async{
    await task.save();
    return task;
  }

  @override
  Future<List<Task>> returnAllTask() async{
    List<Task> list;
    list = hiveBox.values.toList();
    return list;
  }

}