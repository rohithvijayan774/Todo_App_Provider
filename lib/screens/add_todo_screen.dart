import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:todo_app/providers/add_todo_provider.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add Todo'),
      ),
      body: Form(
        key: _formKey,
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
                    Provider.of<AddTodoProvider>(context).titleController,
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
                controller:
                    Provider.of<AddTodoProvider>(context).descriptionController,
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
                  if (_formKey.currentState!.validate()) {
                    onButtonPress(context)
                        .whenComplete(() => Navigator.pop(context));
                  }
                },
                child: const Text(
                  'SAVE',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///-----------------------------[ Functions ]-----------------------------------
  Future<void> onButtonPress(context) async {
    await Provider.of<AddTodoProvider>(context, listen: false)
        .saveButtonClick();
    Provider.of<AddTodoProvider>(context, listen: false)
        .todoAddedMessage(context: context);
    Provider.of<AddTodoProvider>(context, listen: false).clearField();
    await Provider.of<AddTodoProvider>(context, listen: false).getAllTodos();
  }
}
