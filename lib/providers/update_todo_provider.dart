
import 'package:flutter/material.dart';
import 'package:todo_app/model/data_model.dart';

class UpdateTodoProvider with ChangeNotifier {
  int? id;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final updateMessage = 'Todo updated';

  Future<void> updateTodo({required TodoModel data}) async {
    titleController.text = data.title;
    descriptionController.text = data.description;
    notifyListeners();
  }

  void todoUpdateMessage({required context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        margin: const EdgeInsets.all(10),
        content: Text(updateMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
