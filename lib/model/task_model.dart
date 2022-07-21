import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';


part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject{
  @HiveField(0)
  final String uuid;
  @HiveField(1)
  String task;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  bool isComplated;

  Task({required this.uuid, required this.task, required this.date, required this.isComplated});

  factory Task.create({required String task, required DateTime date}){
    // By default, every created task is not done in the first as true.
    return Task(uuid: const Uuid().v1() , task: task, date: date, isComplated: false);
  }
}