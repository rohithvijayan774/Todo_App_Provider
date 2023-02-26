import 'package:flutter/material.dart';

class CustomCheckBoxListTile extends StatefulWidget {
  final String text;
  final String subtitle;
  final int index;
  final Function(bool?) onchanged;
  final Function delete;

  const CustomCheckBoxListTile({
    Key? key,
    required this.text,
    required this.subtitle,
    required this.index,
    required this.onchanged,
    required this.delete,
  }) : super(key: key);

  @override
  CustomCheckBoxListTileState createState() => CustomCheckBoxListTileState();
}

class CustomCheckBoxListTileState extends State<CustomCheckBoxListTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {},
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
