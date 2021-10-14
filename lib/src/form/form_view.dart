import 'package:admision_factor/src/form/api/api_call.dart';
import 'package:admision_factor/src/form/widgets/radio_group.dart';
import 'package:admision_factor/src/form/widgets/text_form_group.dart';
import 'package:admision_factor/src/results/results_view.dart';
import 'package:admision_factor/src/settings/settings_view.dart';
import 'package:flutter/material.dart';

import 'models/form_model.dart';
import 'widgets/dropdown.dart';

class FormView extends StatefulWidget {
  const FormView({Key? key}) : super(key: key);

  static const routeName = '/form';

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  MLModel model = MLModel();
  final _formKey = GlobalKey<FormState>(debugLabel: '_MLFormState');
  final _greController = TextEditingController();
  final _gpaController = TextEditingController();
  bool showRankError = false;

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
            child: DropDown(
              title: "Género",
              hint: "Escoge tu género",
              options: const ["Mujer", "Hombre"],
              onSelect: (value) {
                model.gender = value;
              },
            ),
          ),
        ),
        Flexible(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            child: DropDown(
              title: "Etnia",
              hint: "Escoge tu raza",
              options: const ["Hispano", "Asiático", "Africano"],
              onSelect: (value) {
                model.race = value + 1;
              },
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () =>
                Navigator.restorablePushNamed(context, SettingsView.routeName),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            row,
            const SizedBox(height: 20),
            RadioGroup(
              title: "Prestigio de la escuela",
              error: showRankError,
              onSelect: (value) {
                model.rank = value;
              },
            ),
            const SizedBox(height: 20),
            DropDown(
              title: "Estado socioeconómico",
              hint: "Escoge tu estado socioeconómico",
              options: const ["Bajo", "Medio", "Alto"],
              onSelect: (value) {
                model.income = value + 1;
              },
            ),
            const SizedBox(height: 20),
            TextFormGroup(
              controller: _greController,
              title: "Graduate Record Exam Scores (GRE)",
              hint: "Escribe tu GRE",
            ),
            const SizedBox(height: 20),
            TextFormGroup(
              controller: _gpaController,
              title: "Grade Point Average (GPA)",
              hint: "Escribe tu GPA",
            ),
            const SizedBox(height: 60),
            ElevatedButton(
              onPressed: () async {
                if (model.rank == null) {
                  setState(() {
                    showRankError = true;
                  });
                } else {
                  setState(() {
                    showRankError = false;
                  });
                }
                if (_formKey.currentState!.validate() && model.rank != null) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return AlertDialog(
                        content: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                            SizedBox(width: 30),
                            Text("Enviando datos"),
                          ],
                        ),
                      );
                    },
                  );
                  model.gre = double.parse(_greController.text);
                  model.gpa = double.parse(_gpaController.text);

                  int? result = await postForm(model);
                  Navigator.of(context).pop();
                  if (result != null) {
                    Navigator.restorablePopAndPushNamed(
                      context,
                      ResultsView.routeName,
                      arguments: result,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Error al enviar los datos"),
                      ),
                    );
                  }
                }
              },
              child: const Text("Enviar"),
            )
          ],
        ),
      ),
    );
  }
}
