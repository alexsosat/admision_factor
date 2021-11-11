import 'package:admision_factor/src/form/widgets/text_form_group.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormViewTemplate extends StatelessWidget {
  FormViewTemplate({
    Key? key,
    required this.section,
    this.infoText,
    this.onNext,
    this.onBack,
    this.lastSection = false,
  }) : super(key: key);

  final String section;
  final String? infoText;
  final bool lastSection;
  final Function(double mean, double se, double wrst)? onNext;
  final Function()? onBack;

  final _formKey = GlobalKey<FormState>(debugLabel: '_MLFormState');
  final _meanController = TextEditingController();
  final _seController = TextEditingController();
  final _worstController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final row = Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: TextFormGroup(
              controller: _meanController,
              title: "Media de ${section.toLowerCase()}",
              hint: "Escribe la media",
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: TextFormGroup(
              controller: _seController,
              title: "SE de ${section.toLowerCase()}",
              hint: "Escribe el SE",
            ),
          ),
        ),
      ],
    );

    final form = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          row,
          Container(
            padding: const EdgeInsets.all(10),
            child: TextFormGroup(
              controller: _worstController,
              title: "Peor registro de ${section.toLowerCase()}",
              hint: "Escribe el peor registro",
            ),
          ),
        ],
      ),
    );

    final navigationButtons = Container(
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: 210,
              child: Text(
                section,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 36,
                ),
              ),
            ),
          ),
          if (onBack != null)
            Align(
              alignment: Alignment.topLeft,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  primary: Colors.white,
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.chevron_left),
                onPressed: onBack!,
              ),
            ),
          if (onNext != null)
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                  primary: Colors.white,
                  shape: const CircleBorder(),
                ),
                child: Icon((lastSection) ? Icons.done : Icons.chevron_right),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    double mean = double.parse(_meanController.text);
                    double se = double.parse(_seController.text);
                    double worst = double.parse(_worstController.text);
                    onNext!(mean, se, worst);
                  }
                },
              ),
            ),
        ],
      ),
    );

    final curiousTip = Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.only(top: 30),
      child: DottedBorder(
        borderType: BorderType.RRect,
        dashPattern: const [7],
        strokeWidth: 3,
        radius: const Radius.circular(12),
        padding: const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 20,
        ),
        child: SizedBox(
          height: 200,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Dato importante:",
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  infoText!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return Form(
      key: _formKey,
      child: ListView(
        children: [
          navigationButtons,
          form,
          if (infoText != null) curiousTip,
        ],
      ),
    );
  }
}
