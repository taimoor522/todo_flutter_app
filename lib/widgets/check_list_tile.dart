import 'package:flutter/material.dart';
import 'package:todo/constants.dart';

class CheckListTile extends StatelessWidget {
  final String title;
  final isDone;
  final onChange;
  CheckListTile({this.title, this.isDone, this.onChange});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Checkbox(
        fillColor: MaterialStateProperty.all(kBlueColor),
        onChanged: onChange,
        value: isDone,
      ),
      title: Text(
        title,
        style: TextStyle(
          decoration: isDone ? TextDecoration.lineThrough : null,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: kBlueColor,
        ),
      ),
    );
  }
}
