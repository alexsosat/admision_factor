import 'package:admision_factor/src/form/form_view.dart';
import 'package:admision_factor/src/settings/settings_view.dart';
import 'package:flutter/material.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({Key? key}) : super(key: key);

  static const routeName = '/results';

  Future<String> tempFuture() async {
    await Future.delayed(const Duration(seconds: 2));

    return "No Aprobado";
  }

  @override
  Widget build(BuildContext context) {
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
          FutureBuilder<String>(
            future: tempFuture(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data == "Aprobado") {
                  return Column(
                    children: [
                      Text(
                        snapshot.data!,
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
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Text(
                        snapshot.data!,
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
                    ],
                  );
                }
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
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
