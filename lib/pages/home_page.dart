import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:github_todo/localstorage/hive_storage.dart';
import 'package:github_todo/main.dart';
import 'package:github_todo/model/task_model.dart';
import 'package:github_todo/utils/color_and_styles.dart';
import 'package:github_todo/widgets/task_item.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  late List<Task> _allList;
  late LocalStorage _localStorage;

  void getAllTask() async{
    _allList = await _localStorage.returnAllTask();
    setState(() {
      
    });
  }

  void dateControl() {
    for (var element in _allList) { 
      if(element.date.day != DateTime.now().day){
        _allList.remove(element);
        _localStorage.deleteTask(task: element);
      }
    }}
  @override
  void initState() {
    _allList = <Task>[];
    _localStorage = getIt<LocalStorage>();
    getAllTask();
    dateControl();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorGold,
        onPressed: () {
          _showModalBottomSheet();
        },
        child: const Icon(
          Icons.add,
          size: 40,
          color: colorBlack,
        ),
      ),
      appBar: AppBar(
        title: const Text(
          "What do you do today?",
          style: styleBold,
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showModalBottomSheet();
            },
            icon: const Icon(
              Icons.add,
              size: 40,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
        ],
        
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: _allList.length,
          itemBuilder: (context, index){
            var currentTask = _allList[index];
            return Dismissible(
              background: Row(
                children: [
                  Text("Task is deleted", style: styleTask.copyWith(color: colorRed),),
                ],
              ),
              key: Key(currentTask.uuid),
              onDismissed: (d){
                _localStorage.deleteTask(task: currentTask);
                _allList.remove(currentTask);
                setState(() {
                  
                });
              },
              child: GestureDetector(
                onTap: (){
                  currentTask.isComplated = !currentTask.isComplated;
                  setState(() {
                    
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: currentTask.isComplated ? colorGreen : colorRed,
                  ),
                  child: TaskWidget(task: currentTask),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: TextField(
                style: styleBold.copyWith(color: colorWhite),
                autofocus: true,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Add a task',
                ),
                onSubmitted: (value) {
                  DatePicker.showTimePicker(context,
                      showSecondsColumn: false, onConfirm: (date) {
                        var selectedTask = Task.create(task: value, date: date);
                        _allList.add(selectedTask);
                        _localStorage.addTask(task: selectedTask);
                        setState(() {
                          Navigator.pop(context);
                        });
                      });
                },
              ),
            ),
          );
        });
  }
  

}
