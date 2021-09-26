import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormGroup extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  const TextFormGroup({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            LengthLimitingTextInputFormatter(3),
          ],
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Introducir un número";
            }
          },
        )
      ],
    );
  }
}
