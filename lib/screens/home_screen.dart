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
                  final pro = Provider.of<AddTodoProvider>(context);
                  return CustomCheckBoxListTile(
                    index: index,
                    text: Provider.of<AddTodoProvider>(context, listen: false)
                        .todoListNotifier[index]
                        .title,
                    onchanged: (value) {
                      log(value.toString());
                      Provider.of<AddTodoProvider>(context, listen: false)
                          .addIndexOp(index: index, value: value);
                    },
                  );
                  //
                  // ListTile(
                  //   leading: Checkbox(
                  //     value: pro.optionsValue.length < 0
                  //         ? true
                  //         : Provider.of<AddTodoProvider>(context)
                  //             .optionsValue[index],
                  //     onChanged: (bool? value) {
                  //       log(index.toString());
                  //       Provider.of<AddTodoProvider>(context, listen: false)
                  //           .addIndexOp(index: index, value: value);
                  //       log(value.toString());

                  //       // Provider.of<AddTodoProvider>(context, listen: false)
                  //       //     .onchanges(value: value);
                  //       Provider.of<AddTodoProvider>(context, listen: false)
                  //           .getAllTodos();
                  //     },
                  //   ),
                  //   title: Text(Provider.of<AddTodoProvider>(context)
                  //       .todoListNotifier[index]
                  //       .title
                  //       .toString()),
                  //   subtitle: Text(Provider.of<AddTodoProvider>(context)
                  //       .todoListNotifier[index]
                  //       .description
                  //       .toString()),
                  //   trailing: IconButton(
                  //     onPressed: () {
                  //       Provider.of<AddTodoProvider>(context, listen: false)
                  //           .deleteDialogue(index, context);
                  //     },
                  //     icon: const Icon(Icons.close),
                  //   ),
                  //   onTap: () {},
                  // );
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

//----------------------------------Check Box-----------------------------------

// class CustomCheckBoxListTile extends StatefulWidget {
//   final String text;
//   final int index;
//   final Function(bool?) onchanged;

//   const CustomCheckBoxListTile({
//     Key? key,
//     required this.text,
//     required this.index,
//     required this.onchanged,
//   }) : super(key: key);

//   @override
//   CustomCheckBoxListTileState createState() => CustomCheckBoxListTileState();
// }

// class CustomCheckBoxListTileState extends State<CustomCheckBoxListTile> {
//   bool isChecked = false;

//   @override
//   Widget build(BuildContext context) {
//     return CheckboxListTile(
//       value: isChecked,
//       title: Text(widget.text),
//       controlAffinity: ListTileControlAffinity.leading,
//       onChanged: (value) {
//         setState(() {
//           isChecked = value!;
//           widget.onchanged(value);
//         });
//       },
//     );
//   }
// }
