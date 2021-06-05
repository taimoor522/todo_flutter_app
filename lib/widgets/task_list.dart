import 'package:provider/provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/widgets/check_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/task_data.dart';
import 'package:todo/constants.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, taskData, child) {
      if (taskData.task_count < 1)
        return Center(
          child: Text(
            "No task to show. \nPress + to add a task",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: kBlueColor,
            ),
          ),
        );
      return Container(
        padding: EdgeInsets.only(left: 25, right: 25, top: 10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            final Task task = (taskData.tasks)[index];
            return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) => taskData.deleteTask(task.id),
                child: CheckListTile(
                  title: task.title,
                  isDone: task.isDone,
                  onChange: (state) => taskData.updateTask(task),
                ));
          },
          itemCount: taskData.task_count,
        ),
      );
    });
  }
}
