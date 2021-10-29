import 'package:admision_factor/src/form/api/api_call.dart';
import 'package:admision_factor/src/form/models/breast_model.dart';
import 'package:admision_factor/src/form/views/form_view_template.dart';
import 'package:admision_factor/src/results/results_view.dart';
import 'package:admision_factor/src/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TabFormView extends StatefulWidget {
  static const routeName = '/formTab';
  const TabFormView({Key? key}) : super(key: key);

  @override
  State<TabFormView> createState() => _TabFormViewState();
}

class _TabFormViewState extends State<TabFormView> {
  final _controller = PageController();

  final pageTransitionDuration = const Duration(milliseconds: 300);
  final pageTransitionCurve = Curves.ease;

  int currentIndex = 0;
  BreastModel model = BreastModel();

  _goToView(int index) {
    _controller.animateToPage(
      index,
      duration: pageTransitionDuration,
      curve: pageTransitionCurve,
    );
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0), // here the desired height
          child: Container(
            padding: const EdgeInsets.all(10),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 10,
              effect: WormEffect(
                activeDotColor: Theme.of(context).colorScheme.secondary,
                dotHeight: 12,
                dotWidth: 12,
              ),
              //onDotClicked: (index)=>_goToView(index),
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          //Radio
          FormViewTemplate(
            section: "Radio",
            infoText:
                "El cáncer de mama es el cáncer más frecuente en las mujeres en México y en el mundo",
            onNext: (mean, se, worst) {
              model.radius.assignValues(mean, se, worst);
              _goToView(++currentIndex);
            },
          ),

          //Texture
          FormViewTemplate(
            section: "Textura",
            infoText:
                " El cáncer de mama es también el cáncer que más decesos produce en México y en el mundo",
            onBack: () => _goToView(--currentIndex),
            onNext: (mean, se, worst) {
              model.texture.assignValues(mean, se, worst);
              _goToView(++currentIndex);
            },
          ),

          //Perimeter
          FormViewTemplate(
            section: "Perímetro",
            infoText:
                "Más de 1 millón de mujeres se detectan en el mundo anualmente con este padecimiento",
            onBack: () => _goToView(--currentIndex),
            onNext: (mean, se, worst) {
              model.perimeter.assignValues(mean, se, worst);
              _goToView(++currentIndex);
            },
          ),

          //Area
          FormViewTemplate(
            section: "Área",
            infoText:
                "En México, el promedio de edad de diagnóstico de cáncer de mama es de 50 años",
            onBack: () => _goToView(--currentIndex),
            onNext: (mean, se, worst) {
              model.area.assignValues(mean, se, worst);
              _goToView(++currentIndex);
            },
          ),

          //Smoothness
          FormViewTemplate(
            section: "Suavidad",
            infoText:
                "El tabaquismo, el consumo de alcohol, la obesidad y el consumo crónico de esteroides son, entre otros, factores de riesgo para el cáncer de mama",
            onBack: () => _goToView(--currentIndex),
            onNext: (mean, se, worst) {
              model.smoothness.assignValues(mean, se, worst);
              _goToView(++currentIndex);
            },
          ),

          //Compactness
          FormViewTemplate(
            section: "Compacidad",
            infoText:
                "En México, el 70% de pacientes jóvenes que se presentan con cáncer de mama son detectadas en etapa avanzada.",
            onBack: () => _goToView(--currentIndex),
            onNext: (mean, se, worst) {
              model.compactness.assignValues(mean, se, worst);
              _goToView(++currentIndex);
            },
          ),

          //Concavity
          FormViewTemplate(
            section: "Concavidad",
            infoText:
                "Entre el 11 y 15% de los casos son de mujeres de 40 o menos años",
            onBack: () => _goToView(--currentIndex),
            onNext: (mean, se, worst) {
              model.concavity.assignValues(mean, se, worst);
              _goToView(++currentIndex);
            },
          ),

          //Concave points
          FormViewTemplate(
            section: "Puntos cóncavos",
            infoText:
                "Realizar actividades físicas con frecuencia reduce el riesgo de padecer cáncer de mama",
            onBack: () => _goToView(--currentIndex),
            onNext: (mean, se, worst) {
              model.points.assignValues(mean, se, worst);
              _goToView(++currentIndex);
            },
          ),

          //Symmetry
          FormViewTemplate(
            section: "Simetría",
            infoText:
                "A partir de los 25 años, es recomendable hacerse una revisión anual",
            onBack: () => _goToView(--currentIndex),
            onNext: (mean, se, worst) {
              model.symmetry.assignValues(mean, se, worst);
              _goToView(++currentIndex);
            },
          ),

          //Fractal Dimension
          FormViewTemplate(
            section: "Dimensión fractal",
            infoText:
                "Después de los 40 años, es recomendable hacerse una mamografía anual",
            lastSection: true,
            onBack: () => _goToView(--currentIndex),
            onNext: (mean, se, worst) async {
              model.fractalDimensions.assignValues(mean, se, worst);

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

              // Sending model to Api
              String? result = await postBreastForm(model);
              Navigator.of(context).pop();

              //Page routing
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
            },
          ),
        ],
      ),
    );
  }
}
