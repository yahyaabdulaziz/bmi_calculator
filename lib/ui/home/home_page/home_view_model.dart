import 'package:bmi_calculator/ui/home/result_page/result_screen.dart';
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
      FirebaseFirestore.instance.collection('bmiResults').add({
        'height': height,
        'weight': weight,
        'age': ageController.text,
        'result': roundedResult,
        'timestamp': DateTime.now(),
      });

      print('BMI result saved to Fire store');
      Navigator.pushNamed(context, ResultScreen.routeName);
      // Reset the form
      formKey.currentState!.reset();
    }
  }
}
