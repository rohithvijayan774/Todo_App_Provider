import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/add_todo_provider.dart';
import 'package:todo_app/screens/add_todo_screen.dart';

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
                  // TodoModel data = showTodoList[index];
                  return ListTile(
                    leading: Checkbox(
                      value: Provider.of<AddTodoProvider>(context).isChecked,
                      onChanged: (bool? value) {
                        Provider.of<AddTodoProvider>(context, listen: false)
                            .isChecked = value!;
                      },
                    ),
                    title: Text(Provider.of<AddTodoProvider>(context)
                        .todoListNotifier[index]
                        .title
                        .toString()),
                    subtitle: Text(Provider.of<AddTodoProvider>(context)
                        .todoListNotifier[index]
                        .description
                        .toString()),
                    trailing: IconButton(
                      onPressed: () {
                        Provider.of<AddTodoProvider>(context, listen: false)
                            .deleteDialogue(index, context);
                        // deleteTodo(id:index ,context: context );
                        // Provider.of<AddTodoProvider>(context, listen: false)
                        //     .deleteTodo(index);
                        // Provider.of<AddTodoProvider>(context, listen: false)
                        //     .getAllTodos();
                      },
                      icon: const Icon(Icons.close),
                    ),
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

  // deleteDialogue(int id, context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadiusDirectional.circular(10),
  //         ),
  //         title: const Text(
  //           'Do you want to delete?',
  //           style: TextStyle(color: Colors.red),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text(
  //               'Cancel',
  //               style: TextStyle(color: Colors.black),
  //             ),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               Provider.of<AddTodoProvider>(context, listen: false)
  //                   .deleteTodo(id);
  //               Navigator.of(context).pop();
  //               Provider.of<AddTodoProvider>(context, listen: false)
  //                   .getAllTodos();
  //             },
  //             child: const Text(
  //               'Delete',
  //               style: TextStyle(color: Colors.black),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
