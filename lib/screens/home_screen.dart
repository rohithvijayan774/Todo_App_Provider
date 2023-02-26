import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/data_model.dart';
import 'package:todo_app/providers/add_todo_provider.dart';
import 'package:todo_app/providers/update_todo_provider.dart';
import 'package:todo_app/screens/add_todo_screen.dart';
import 'package:todo_app/screens/checkbox.dart';
import 'package:todo_app/screens/update_todo_screen.dart';

class HomeScreen extends StatelessWidget {
  // final List<TodoModel> showTodoList;
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AddTodoProvider>(context, listen: false).getAllTodos();
    log('building');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Todo App'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddTodoScreen()));
        },
      ),
      body: Consumer<AddTodoProvider>(builder: (context, value, child) {
        return Provider.of<AddTodoProvider>(context).todoListNotifier.isEmpty
            ? const Center(
                child: Text('No datas found'),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  TodoModel data = Provider.of<AddTodoProvider>(context)
                      .todoListNotifier[index];
                  final pro = Provider.of<AddTodoProvider>(context);
                  final proLF =
                      Provider.of<AddTodoProvider>(context, listen: false);
                  return CustomCheckBoxListTile(
                    text: proLF.todoListNotifier[index].title,
                    subtitle: proLF.todoListNotifier[index].description,
                    index: index,
                    onchanged: (value) {
                      proLF.addIndexOp(index: index, value: value);
                    },
                    delete: () {
                      proLF.deleteDialogue(index, context);
                    },
                    longPress: () async {
                      await Provider.of<UpdateTodoProvider>(context,
                              listen: false)
                          .updateTodo(data: data);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UpdateTodoScreen(index: index),
                      ));
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: Provider.of<AddTodoProvider>(context)
                    .todoListNotifier
                    .length,
              );
      }),
    );
  }
}
