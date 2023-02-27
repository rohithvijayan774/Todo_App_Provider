import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/data_model.dart';
import 'package:todo_app/providers/add_todo_provider.dart';

class CustomCheckBoxListTile extends StatefulWidget {
  final String text;
  final String subtitle;
  final int index;
  final Function(bool?) onchanged;
  final Function delete;
  final Function longPress;

  const CustomCheckBoxListTile({
    Key? key,
    required this.text,
    required this.subtitle,
    required this.index,
    required this.onchanged,
    required this.delete,
    required this.longPress,
  }) : super(key: key);

  @override
  CustomCheckBoxListTileState createState() => CustomCheckBoxListTileState();
}

class CustomCheckBoxListTileState extends State<CustomCheckBoxListTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {
        widget.longPress();
      },
      leading: Checkbox(
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
            widget.onchanged(value);
          });
        },
      ),
      title: isChecked == false
          ? Text(
              widget.text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            )
          : Text(
              widget.text,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.black,
                decorationThickness: 2.0,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
      subtitle: isChecked == false
          ? Text(
              widget.subtitle,
              style: const TextStyle(
                fontSize: 15,
              ),
            )
          : Text(
              widget.subtitle,
              style: const TextStyle(
                fontSize: 15,
                decoration: TextDecoration.lineThrough,
                decorationColor: Colors.black,
                decorationThickness: 2.0,
                decorationStyle: TextDecorationStyle.solid,
              ),
            ),
      trailing: IconButton(
        onPressed: () {
          widget.delete();
        },
        icon: const Icon(Icons.close),
      ),
    );
  }
}
