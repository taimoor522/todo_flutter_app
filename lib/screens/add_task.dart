import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants.dart';
import 'package:todo/models/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String taskTitle;

    return SingleChildScrollView(
      child: Container(
        color: Color(0xff757575),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: 20,
              right: 40,
              left: 40,
              bottom: 10,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Add Title",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kBlueColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    primaryColor: kBlueColor,
                  ),
                  child: TextField(
                    onChanged: (text) {
                      taskTitle = text;
                    },
                    decoration: InputDecoration(
                      hintText: "Enter Task Title",
                    ),
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(kBlueColor),
                  ),
                  onPressed: () {
                    if (taskTitle != null) {
                      Provider.of<TaskData>(context, listen: false)
                          .addTask(taskTitle);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
