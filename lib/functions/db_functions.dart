// import 'dart:developer';

// import 'package:flutter/cupertino.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:provider/provider.dart';
// import 'package:todo_app/model/data_model.dart';
// import 'package:todo_app/providers/add_todo_provider.dart';

// ValueNotifier<List<TodoModel>> todoListNotifier = ValueNotifier([]);

// Future<void> addTodo(TodoModel value) async {
//   final box = await Hive.openBox<TodoModel>('todo_DB');
//   await box.add(value);
//   todoListNotifier.value.add(value);
//   for (var element in todoListNotifier.value) {
//     log("hive : ${element.title}");
//   }
//    await getAllTodos();
//   todoListNotifier.notifyListeners();
//  await getAllTodos();
//   log('data added');
// }

// Future<void> getAllTodos() async {
// // await  Provider.of<AddTodoProvider>(context).loading(true);
//   final box = await Hive.openBox<TodoModel>('todo_DB');
//   todoListNotifier.value.clear();
//   todoListNotifier.value.addAll(box.values);
//    for (var element in todoListNotifier.value) {
//     log("hive : ${element.title}");
//   }

//   todoListNotifier.notifyListeners();

// //  await Provider.of<AddTodoProvider>(context).loading(false);
// }

// Future<void> deleteTodo({required int id, required context}) async {
//   final box = await Hive.openBox<TodoModel>('todo_DB');
//   await box.deleteAt(id);
//   todoListNotifier.notifyListeners();
//   log('deleted');
//   // getAllTodos(context: context);
// }

// Future<void> refreshUI() async {
//   todoListNotifier.value.clear();

//   final 
// }
