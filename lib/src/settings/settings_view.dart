import 'package:flutter/material.dart';

import 'settings_controller.dart';

/// Displays the various settings that can be customized by the user.
///
/// When a user changes a setting, the SettingsController is updated and
/// Widgets that listen to the SettingsController are rebuilt.
class SettingsView extends StatelessWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Elige el tema de la aplicación"),
            // Glue the SettingsController to the theme selection DropdownButton.
            //
            // When a user selects a theme from the dropdown list, the
            // SettingsController is updated, which rebuilds the MaterialApp.
            DropdownButton<ThemeMode>(
              // Read the selected themeMode from the controller
              value: controller.themeMode,
              // Call the updateThemeMode method any time the user selects a theme.
              onChanged: controller.updateThemeMode,
              items: const [
                DropdownMenuItem(
                  value: ThemeMode.system,
                  child: Text('System Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.light,
                  child: Text('Light Theme'),
                ),
                DropdownMenuItem(
                  value: ThemeMode.dark,
                  child: Text('Dark Theme'),
                )
              ],
            ),
            const Expanded(child: SizedBox()),
            const Text("Aplicación realizada por:"),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text("\u2022 Alejandro Rafael Sosa Trejo"),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text("\u2022 Miguel Angel Varela Delgado"),
            ),
            const SizedBox(height: 10),
            const Text(
                "En cumplimiento con la clase de Fundamentos de Ciencia de datos impartida por la universidad de Montemorelos"),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
