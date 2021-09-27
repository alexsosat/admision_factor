import 'package:admision_factor/src/form/form_view.dart';
import 'package:admision_factor/src/settings/settings_view.dart';
import 'package:flutter/material.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({Key? key}) : super(key: key);

  static const routeName = '/results';

  @override
  Widget build(BuildContext context) {
    final String mlClass = ModalRoute.of(context)!.settings.arguments as String;

    List<Widget> aprovedChildren = [
      Text(
        mlClass,
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.green,
            ),
      ),
      const SizedBox(height: 20),
      Text(
        "¡Felicidades! estas viendo los frutos de tu esfuerzo",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
    ];

    List<Widget> declinedChildren = [
      Text(
        mlClass,
        style: Theme.of(context).textTheme.headline4!.copyWith(
              color: Colors.red,
            ),
      ),
      const SizedBox(height: 20),
      Text(
        "No te desanimes, esfuerzate y verás que las cosas saldrán bien",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
    ];

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
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.asset(
            "assets/images/app_logo.png",
            height: 190,
          ),
          const SizedBox(height: 20),
          Column(
            children:
                (mlClass == "Aprobado") ? aprovedChildren : declinedChildren,
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.restorablePopAndPushNamed(context, FormView.routeName);
            },
            child: const Text("Volver a intentar con diferentes valores"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.grey,
            ),
            child: const Text("Regresar al inicio"),
          ),
        ],
      ),
    );
  }
}
