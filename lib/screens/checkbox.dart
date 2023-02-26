import 'package:flutter/material.dart';

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
      title: Text(widget.text),
      subtitle: Text(widget.subtitle),
      trailing: IconButton(
        onPressed: () {
          widget.delete();
        },
        icon: const Icon(Icons.close),
      ),
    );
  }
}
