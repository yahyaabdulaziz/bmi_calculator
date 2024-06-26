import 'package:bmi_calculator/ui/home/result_page/result_screen.dart';
import 'package:bmi_calculator/utils/app_strings.dart';
import 'package:bmi_calculator/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      double height = double.parse(heightController.text);
      double weight = double.parse(weightController.text);

      double bmiResult = weight / (height * height);
      double roundedResult = double.parse(bmiResult.toStringAsFixed(1));

      // Save result and current time to Fire store
      FirebaseFirestore.instance.collection("${Constants.collectionName}").add({
        'height': height,
        'weight': weight,
        'age': int.parse(ageController.text),
        'result': roundedResult,
        'timestamp': DateTime.now(),
      });

      print('${AppStrings.bmiResultSavedToFirestore}');
      Navigator.pushNamed(context, ResultScreen.routeName,
          arguments: roundedResult);
      // Reset the form
      formKey.currentState!.reset();
    }
  }
}
