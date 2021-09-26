import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final String title;
  final List<String> options;
  final Function(int value) onSelect;
  final String hint;
  const DropDown({
    Key? key,
    required this.title,
    required this.options,
    required this.onSelect,
    this.hint = "",
  }) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  int? currentValue;
  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<int>> items() {
      List<DropdownMenuItem<int>> returnable = List.empty(growable: true);

      for (int i = 0; i < widget.options.length; i++) {
        returnable.add(
          DropdownMenuItem(
            value: i,
            child: Text(widget.options[i]),
          ),
        );
      }

      return returnable;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        DropdownButtonFormField<int>(
          hint: Text(widget.hint),
          value: currentValue,
          isExpanded: true,
          validator: (value) {
            if (value == null) return "Favor de escoger un valor";
          },
          onChanged: (value) {
            if (value != null) {
              widget.onSelect(value);
              setState(() {
                currentValue = value;
              });
            }
          },
          items: items(),
        ),
      ],
    );
  }
}
