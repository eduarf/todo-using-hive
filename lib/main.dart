import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:github_todo/localstorage/hive_storage.dart';
import 'package:github_todo/model/task_model.dart';
import 'package:github_todo/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';


final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<LocalStorage>(HiveLocalStorage());
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  var box = await Hive.openBox<Task>('tasks');
  setup();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TodoApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        
      ),
      themeMode: ThemeMode.dark,
      home: HomePage(),
    );
  }
}