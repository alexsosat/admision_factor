import 'package:admision_factor/src/form/widgets/text_form_group.dart';
import 'package:flutter/material.dart';

class FormViewTemplate extends StatelessWidget {

   FormViewTemplate({
     Key? key,
     required this.section,
     required this.imagePath,
     this.onNext,
     this.onBack,
   }) : super(key: key);

  final String section;
  final String imagePath;
  final Function(double mean, double se, double wrst)? onNext;
  final Function()? onBack;

  final _formKey = GlobalKey<FormState>(debugLabel: '_MLFormState');
  final _meanController = TextEditingController();
  final _seController = TextEditingController();
  final _worstController = TextEditingController();



  @override
  Widget build(BuildContext context) {

    final image = Container(
      height: 250,
      width: 250,
      margin: const EdgeInsets.only(top: 40,bottom: 20,),
      child: Image.asset(imagePath),
    );

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
              title: "Media de $section",
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
              title: "SE de $section",
              hint: "Escribe el SE",
            ),
          ),
        ),
      ],
    );

    final form =
    Column(
      children: [
        row,
        Container(
          padding: const EdgeInsets.all(10),
          child: TextFormGroup(
            controller: _worstController,
            title: "Peor registro de $section",
            hint: "Escribe el peor registro",
          ),
        ),
      ],
    );

    final navigationButtons = Align(
    alignment: Alignment.topCenter,
    child: Container(
      // color: Theme.of(context).scaffoldBackgroundColor,
      padding: const EdgeInsets.all(20),
      child: Stack(
        children: [
          if(onBack!=null)
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
          if(onNext != null)
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                primary: Colors.white,
                shape: const CircleBorder(),
              ),
              child: const Icon(Icons.chevron_right),
              onPressed: (){
                if(_formKey.currentState!.validate()){
                  double mean = double.parse(_meanController.text);
                  double se = double.parse(_seController.text);
                  double worst = double.parse(_worstController.text);
                  onNext!(mean,se,worst);
                }
              },
          ),
            ),
        ],
      ),
    ),
    );

    return Stack(
      children: [
        Form(
          key: _formKey,
          child:ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                image,
                form,
                const SizedBox(height: 50),
              ],
            ),
          ),
        navigationButtons,
      ],
    );
  }
}