import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/data_model.dart';

class AddTodoProvider with ChangeNotifier {
  // Cotrollers
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final addMessage = 'Todo added Successfully';
  final deleteMessage = 'Todo deleted';

  List<TodoModel> todoListNotifier = [];

  bool isChecked = false;

  List<String> optionsIndex = [];
  List<bool> optionsValue = [];
  void onchanges({required value}) {
    isChecked = value;
    notifyListeners();
  }

  addIndexOp({required int index, required bool? value}) {
    log(index.toString());

    optionsIndex.add(index.toString());

    optionsValue.add(value!);
    notifyListeners();
  }

  Future<void> addTodo(TodoModel value) async {
    todoListNotifier.clear();
    final box = await Hive.openBox<TodoModel>('todo_DB');
    await box.add(value);
    todoListNotifier.add(value);
    for (var element in todoListNotifier) {
      log("hive : ${element.title}");
    }

    notifyListeners();
    log('data added');
  }

  Future<void> getAllTodos() async {
    final box = await Hive.openBox<TodoModel>('todo_DB');
    todoListNotifier.clear();
    todoListNotifier.addAll(box.values);
    notifyListeners();
  }

  Future<void> deleteTodo(int id) async {
    final box = await Hive.openBox<TodoModel>('todo_DB');
    await box.deleteAt(id);
    notifyListeners();
    log('Deleted');
  }

  Future<void> saveButtonClick() async {
    final todoTitle = titleController.text;
    final todoDescription = descriptionController.text;
    log("title : $todoTitle\n description : $todoDescription");

    if (todoTitle.isEmpty || todoDescription.isEmpty) {
      return;
    }

    final todoData = TodoModel(
      title: todoTitle,
      description: todoDescription,
      id: DateTime.now().microsecondsSinceEpoch,
    );
    await addTodo(todoData);
    // getAllTodos();

    notifyListeners();
  }

  void clearField() {
    titleController.clear();
    descriptionController.clear();
    notifyListeners();
  }

  deleteDialogue(int id, context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          title: const Text(
            'Do you want to delete?',
            style: TextStyle(color: Colors.red),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () {
                Provider.of<AddTodoProvider>(context, listen: false)
                    .deleteTodo(id);
                Navigator.of(context).pop();
                Provider.of<AddTodoProvider>(context, listen: false)
                    .getAllTodos();
                Provider.of<AddTodoProvider>(context, listen: false)
                    .todoDeleteMessage(context: context);
              },
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  void todoAddedMessage({required context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.green,
        margin: const EdgeInsets.all(10),
        content: Text(addMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void todoDeleteMessage({required context}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.all(10),
        content: Text(deleteMessage),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
