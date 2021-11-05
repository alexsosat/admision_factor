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
                "Es recomendable que el radio del tamaño tumoral sea medido en milímetros en tres planos",
            onNext: (mean, se, worst) {
              model.radius.assignValues(mean, se, worst);
              _goToView(++currentIndex);
            },
          ),

          //Texture
          FormViewTemplate(
            section: "Textura",
            infoText:
                "La textura de la imagen es la propiedad que representa la desviación estándar entre las tonalidades de grises presentes en la imagen del tumor.",
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
                "El perímetro de un tumor es lo que define los bordes del tumor en cuestión",
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
                "El área de un tumor debe de ser medido con relación a la dimensión más larga del tumor invasivo",
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
                "La suavidad de un tumor es la variación local entre la distancia del radio y la media de los dos radios circundantes.",
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
                "La compacidad de un tumor puede ser calculado por la fórmula de perímetro al cuadrado multiplicado por el doble de su área.",
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
                "La concavidad del tumor representa la severidad de puntos cóncavos presentes en su contorno.",
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
                "Los puntos cóncavos de un tumor hacen referencia a la cantidad de proporciones cóncavas presentes en el contorno del tumor.",
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
                "La simetría de un tumor es calculada primero encontrando la distancia más larga desde el centro del núcleo hasta un punto en el perímetro. Después, se realiza una medición de las líneas perpendiculares a la línea medida.",
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
                "la dimensión fractal de un tumor es medido al dividir el logaritmo del perímetro observado por el logaritmo de la distancia de la vara utilizada.",
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
