import 'package:flutter/material.dart';

class EditViewModel extends ChangeNotifier {
  TextEditingController newWeightController = TextEditingController();
  TextEditingController newHeightController = TextEditingController();
  TextEditingController newAgeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  DateTime date = DateTime.now();

  /// updating is not completed
  void updateForm() {
    if (formKey.currentState!.validate()) {
      double height = double.parse(newHeightController.text);
      double weight = double.parse(newWeightController.text);
      int age = int.parse(newAgeController.text);

      double newBmiResult = weight / (height * height);
      double newRoundedResult = double.parse(newBmiResult.toStringAsFixed(1));
    }
  }
}
