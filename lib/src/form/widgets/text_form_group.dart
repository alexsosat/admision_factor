import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFormGroup extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController controller;
  final TextInputAction action;
  const TextFormGroup({
    Key? key,
    required this.title,
    required this.hint,
    required this.controller,
    this.action = TextInputAction.done,
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
            FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,5}')),
            LengthLimitingTextInputFormatter(10),
          ],
          decoration:  InputDecoration(
              hintText: hint,
          ),
          textInputAction: action,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Favor de llenar el campo";
            }
            if(double.tryParse(value) == null){
              return "Favor de introducir números";
            }
          },
        )
      ],
    );
  }
}
