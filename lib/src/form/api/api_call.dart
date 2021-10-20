import 'dart:convert';

import 'package:admision_factor/src/form/models/breast_model.dart';
import 'package:admision_factor/src/form/models/form_model.dart';
import 'package:http/http.dart' as http;

Future<int?> postForm(MLModel model) async {
  var url = Uri.parse('https://admission-factor-api.herokuapp.com/model_prediction');

  var response = await http.post(url,
      headers: {
    'Content-Type': 'application/json'
      },
      body: jsonEncode(model.toMap()),
  );
  //print('Response status: ${response.statusCode}');
  //print('Response body: ${response.body}');

  return int.parse(response.body);
}


Future<int?> postBreastForm(BreastModel model) async {
  var url = Uri.parse('https://admission-factor-api.herokuapp.com/breast_cancer_prediction');

  var response = await http.post(url,
    headers: {
      'Content-Type': 'application/json'
    },
    body: jsonEncode(model.toMap()),
  );
  //print('Response status: ${response.statusCode}');
  //print('Response body: ${response.body}');

  return int.parse(response.body);
}
