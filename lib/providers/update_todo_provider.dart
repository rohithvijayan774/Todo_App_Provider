import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_app/model/data_model.dart';

class UpdateTodoProvider with ChangeNotifier {
  int? id;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Future<void> updateTodo({required TodoModel data}) async {
    titleController.text = data.title;
    descriptionController.text = data.description;
    notifyListeners();
  }
}
