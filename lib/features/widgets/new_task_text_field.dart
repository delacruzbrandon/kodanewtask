import 'package:flutter/material.dart';


class NewTaskTextField extends StatefulWidget {
  final String header;
  final String hint;
  bool? expands;
  NewTaskTextField({
    super.key,
    required this.header,
    required this.hint,
    this.expands = false
  });

  @override
  State<StatefulWidget> createState() => _NewTaskTextFieldState();
}

class _NewTaskTextFieldState extends State<NewTaskTextField> {

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Text(widget.header),
          Material(
            elevation: 20.0,
            shadowColor: Colors.black12,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: widget.hint,
              ),
            ),
          ),
        ],
      );
  }
}