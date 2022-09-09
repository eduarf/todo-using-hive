import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:github_todo/localstorage/hive_storage.dart';
import 'package:github_todo/main.dart';
import 'package:github_todo/model/task_model.dart';
import 'package:github_todo/utils/color_and_styles.dart';

class TaskWidget extends StatefulWidget {
  Task task;
  TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late LocalStorage _localStorage;
  final String editHintText = 'Edit a task';
  @override
  void initState() {
    _localStorage = getIt<LocalStorage>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.task.task,
        style: styleTask,
      ),
      leading: Text(
        formatDate(widget.task.date, [hh, ':', nn, '[', am, ']']),
        style: const TextStyle(
            color: colorBlack, fontWeight: FontWeight.w800, letterSpacing: 1),
      ),
      trailing: GestureDetector(
        onTap: (){
          _showEdit();
        },
          child: const Icon(
        Icons.edit_outlined,
        size: 30,
      )),
    );
  }
  
  void _showEdit() {
    showModalBottomSheet(
      context: context,
      builder: (context){
        return Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: Paddings.paddingLeft,
              child: TextField(
                style: styleBold.copyWith(color: colorWhite),
                autofocus: true,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: editHintText,
                ),
                onSubmitted: (newValue) {
                  DatePicker.showTimePicker(context,
                      showSecondsColumn: false, onConfirm: (date) {
                        setState(() {
                          Navigator.pop(context);
                          widget.task.task = newValue;
                          widget.task.date = date;
                          _localStorage.editTask(task: widget.task);
                        });
                      });
                },
              ),
            ),
          );
      }
    );
  }
}
