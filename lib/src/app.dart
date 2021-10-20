import 'package:admision_factor/src/results/results_view.dart';
import 'package:admision_factor/src/welcome/welcome_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'form/tab_form_view.dart';
import 'settings/settings_controller.dart';
import 'settings/settings_view.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          // Providing a restorationScopeId allows the Navigator built by the
          // MaterialApp to restore the navigation stack when a user leaves and
          // returns to the app after it has been killed while running in the
          // background.
          restorationScopeId: 'app',

          debugShowCheckedModeBanner: false,

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('es', ''),
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: Color.fromRGBO(215, 105, 150, 1.0),
              secondary: Color.fromRGBO(234, 155, 195, 1.0),
            ),
              buttonTheme: const ButtonThemeData(
                buttonColor: Color.fromRGBO(191, 20, 106, 1.0),
                textTheme: ButtonTextTheme.primary,
              ),
            elevatedButtonTheme:  ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(191, 20, 106, 1.0),), //button color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white,), //text (and icon)
              ),
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: const ColorScheme.dark(
              primary: Color.fromRGBO(215, 105, 150, 1.0),
              secondary: Color.fromRGBO(234, 155, 195, 1.0),
            ),
            buttonTheme: const ButtonThemeData(
              buttonColor: Color.fromRGBO(191, 20, 106, 1.0),
              textTheme: ButtonTextTheme.primary,
            ),
            elevatedButtonTheme:  ElevatedButtonThemeData(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(191, 20, 106, 1.0),), //button color
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white,), //text (and icon)
              ),
            ),
          ),
          themeMode: settingsController.themeMode,

          // Define a function to handle named routes in order to support
          // Flutter web url navigation and deep linking.
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case WelcomeView.routeName:
                    return const WelcomeView();
                  case ResultsView.routeName:
                    return const ResultsView();
                  case TabFormView.routeName:
                    return const TabFormView();
                  default:
                    return const WelcomeView();
                }
              },
            );
          },
        );
      },
    );
  }
}
