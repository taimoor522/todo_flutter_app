import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todo/models/task.dart';
import '../db_helper.dart';

class TaskData with ChangeNotifier {
  List<Task> _tasks = [];
  int task_count;
  DbHelper dbHelper = DbHelper();
  TaskData() {
    task_count = 0;
    _init();
  }

  void _init() async {
    await refreshList();
    notifyListeners();
  }

  Future<void> refreshList() async {
    List<Task> newTaskList = [];
    var allTasks = await dbHelper.queryAll();
    allTasks.forEach((task) {
      newTaskList.add(Task(
          title: task["title"],
          isDone: task["isDone"] == 1 ? true : false,
          id: task["id"]));
    });
    _tasks = newTaskList;
    task_count = _tasks.length;
  }

  List<Task> get tasks {
    return _tasks;
  }

  void addTask(String taskTitle) async {
    var newTask = {
      "title": taskTitle,
      "isDone": 0,
    };
    await dbHelper.add(newTask);
    await refreshList();
    notifyListeners();
  }

  void updateTask(Task task) async {
    await dbHelper.update({
      "id": task.id,
      "title": task.title,
      "isDone": task.isDone,
    });
    await refreshList();
    notifyListeners();
  }

  void deleteTask(int id) async {
    print("deleting task with id : $id");
    await dbHelper.delete(id);
    await refreshList();
    notifyListeners();
  }
}
