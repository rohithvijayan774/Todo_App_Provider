import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/data_model.dart';
import 'package:todo_app/providers/add_todo_provider.dart';
import 'package:todo_app/providers/update_todo_provider.dart';

class UpdateTodoScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  UpdateTodoScreen({super.key, required this.index});

  final int index;

  updateTodo({required context}) async {
    if (formKey.currentState!.validate()) {
      final box = await Hive.openBox<TodoModel>('todo_DB');
      box.putAt(
          Provider.of<UpdateTodoProvider>(context, listen: false).id ?? index,
          TodoModel(
            title: Provider.of<UpdateTodoProvider>(context, listen: false)
                .titleController
                .text,
            description: Provider.of<UpdateTodoProvider>(context, listen: false)
                .descriptionController
                .text,
          ));
      Provider.of<AddTodoProvider>(context, listen: false).getAllTodos();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero);
    log('UpdateScreen');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update Todo'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              TextFormField(
                style: const TextStyle(fontSize: 20),
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                textCapitalization: TextCapitalization.words,
                controller:
                    Provider.of<UpdateTodoProvider>(context).titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                textCapitalization: TextCapitalization.sentences,
                controller: Provider.of<UpdateTodoProvider>(context)
                    .descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'please enter description';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    updateTodo(context: context);
                  }
                },
                child: const Text(
                  'UPDATE',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> onUpdateButtonPress(context) async {
  //   await Provider.of<AddTodoProvider>(context, listen: false)
  //       .saveButtonClick();
  //   // Provider.of<AddTodoProvider>(context, listen: false).clearField();
  //   await Provider.of<AddTodoProvider>(context, listen: false).getAllTodos();
  // }
}
