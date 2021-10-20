import 'package:admision_factor/src/form/tab_form_view.dart';
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
        "Benigno",
        style: Theme.of(context).textTheme.headline4!.copyWith(
          color: Colors.green,
        ),
      ),
      const SizedBox(height: 20),
      Text(
        "Nuestro modelo clasificó este tumor como benigno, recuerda visitar a tu doctor constantemente",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline5,
      ),
    ];

    List<Widget> declinedChildren = [
      Text(
        "Maligno",
        style: Theme.of(context).textTheme.headline4!.copyWith(
          color: Colors.red,
        ),
      ),
      const SizedBox(height: 20),
      Text(
        "Nuestro modelo clasificó este tumor como maligno, te recomendamos acudir a un médico lo antes posible",
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
      body: Padding(
          padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (mlClass == "B") ? const Icon(Icons.check,size: 190,color: Colors.green,):
                const Icon(Icons.error_outline,size: 190,color: Colors.red,),
                const SizedBox(height: 20),
                Column(
                  children:
                  (mlClass == "B") ? aprovedChildren : declinedChildren,
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    Navigator.restorablePopAndPushNamed(context, TabFormView.routeName);
                  },
                  child: const Text("Realizar otra predicción"),
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
          )
    );
  }
}
