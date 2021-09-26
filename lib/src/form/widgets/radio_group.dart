import 'package:flutter/material.dart';

class RadioGroup extends StatefulWidget {
  final String title;
  final Function(int? value) onSelect;
  final bool error;
  const RadioGroup({
    Key? key,
    required this.title,
    required this.onSelect,
    required this.error,
  }) : super(key: key);

  @override
  _RadioGroupState createState() => _RadioGroupState();
}

class _RadioGroupState extends State<RadioGroup> {
  int? groupValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [Text("Bajo"), Text("Alto")],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Radio<int>(
              value: 1,
              groupValue: groupValue,
              onChanged: (int? value) {
                widget.onSelect(value);
                setState(() {
                  groupValue = value;
                });
              },
            ),
            Radio<int>(
              value: 2,
              groupValue: groupValue,
              onChanged: (int? value) {
                widget.onSelect(value);
                setState(() {
                  groupValue = value;
                });
              },
            ),
            Radio<int>(
              value: 3,
              groupValue: groupValue,
              onChanged: (int? value) {
                widget.onSelect(value);
                setState(() {
                  groupValue = value;
                });
              },
            ),
            Radio<int>(
              value: 4,
              groupValue: groupValue,
              onChanged: (int? value) {
                widget.onSelect(value);
                setState(() {
                  groupValue = value;
                });
              },
            ),
          ],
        ),
        if (widget.error)
          Text(
            "Favor de escoger una opción",
            style: TextStyle(color: Theme.of(context).errorColor, fontSize: 12),
          ),
      ],
    );
  }
}
