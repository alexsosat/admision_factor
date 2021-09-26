import 'package:admision_factor/src/form/form_view.dart';
import 'package:admision_factor/src/settings/settings_view.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Image.asset(
            "assets/images/app_logo.png",
            height: 86,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const Text(
                "Esta es una aplicación que utiliza inteligencia artificial para deducir si serás aceptado o no en una escuela estadounidense"),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const Text(
                "Recuerda que esto es solo la inferencia de una máquina y que el resultado real dependerá de tu esfuerzo. ¡Ánimo!"),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const Text(
                "A continuación se te pedirá contestar un set de preguntas necesarias para que la computadora pueda ser capaz de realizarlas operaciones para obtener tu resultado."),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: const Text("Favor de contestarlas con honestidad"),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () => Navigator.restorablePushNamed(
              context,
              FormView.routeName,
            ),
            child: const Text("Comenzar"),
          ),
        ],
      ),
    );
  }
}
