import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTaskTextField extends StatelessWidget {
  final String header;
  final String hint;
  final bool expands;
  final ValueChanged<String>? onChanged;

  const NewTaskTextField({
    Key? key,
    required this.header,
    required this.hint,
    this.expands = false,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Material(
          child: TextField(
            onChanged: onChanged,
            maxLines: expands ? null : 1,
            expands: expands,
            decoration: InputDecoration(
              hintText: hint,
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}