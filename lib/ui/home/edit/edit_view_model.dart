import 'package:bmi_calculator/ui/home/result_page/result_screen.dart';
import 'package:bmi_calculator/ui/model/result_model.dart';
import 'package:bmi_calculator/utils/app_strings.dart';
import 'package:bmi_calculator/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditViewModel extends ChangeNotifier {
  TextEditingController newWeightController = TextEditingController();
  TextEditingController newHeightController = TextEditingController();
  TextEditingController newAgeController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime date = DateTime.now();

  void updateForm(BuildContext context, ResultModel model, DateTime timestamp) {
    if (formKey.currentState!.validate()) {
      double height = double.parse(newHeightController.text);
      double weight = double.parse(newWeightController.text);
      int age = int.parse(newAgeController.text);

      double newBmiResult = weight / (height * height);
      double newRoundedResult = double.parse(newBmiResult.toStringAsFixed(1));

      final collectionReference =
          FirebaseFirestore.instance.collection('${Constants.collectionName}');

      // Check if the document exists before updating it
      collectionReference
          .where('${AppStrings.timestamp}', isEqualTo: timestamp)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          // Document exists, proceed with updating
          String documentId = querySnapshot.docs.first.id;

          Map<String, dynamic> data = {
            'height': height,
            'weight': weight,
            'age': age,
            'result': newRoundedResult,
            'timestamp': date, // Store timestamp in UTC format
          };

          // Update the document with the specified field value as document ID
          collectionReference.doc(documentId).update(data).then((_) {
            print('${AppStrings.documentUpdatedSuccessfully}');
            Navigator.pushNamed(context, ResultScreen.routeName,
                arguments: newRoundedResult);
          }).catchError((error) {
            print('${AppStrings.failedToUpdateDocument}: $error');
          });
        } else {
          print('${AppStrings.documentNotFound}');
          // Handle document not found
        }
      }).catchError((error) {
        print('${AppStrings.errorCheckingDocumentExistence}: $error');
      });
    }
  }
}
