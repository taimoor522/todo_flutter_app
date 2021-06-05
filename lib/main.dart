import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants.dart';
import 'package:todo/screens/tasks_Screen.dart';
import 'package:todo/models/task_data.dart';
import 'screens/tasks_Screen.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  changeStatusColor(Color color) async {
    await FlutterStatusbarcolor.setStatusBarColor(color);
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(kBlueColor);
    return ChangeNotifierProvider<TaskData>(
      create: (context) => TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
      ),
    );
  }
}
