import 'package:flutter/material.dart';

class Task {
  int id;
  String title;
  bool isDone;
  Task({@required this.title, @required this.isDone, this.id});
  void toggleDone() => isDone = !isDone;
}
