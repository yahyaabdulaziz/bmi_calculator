import 'package:bmi_calculator/utils/app_strings.dart';
import 'package:bmi_calculator/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultProvider extends ChangeNotifier {
  void delete(DateTime timestamp) {
    final collection =
        FirebaseFirestore.instance.collection(Constants.collectionName);
    collection
        .where('${AppStrings.timestamp}', isEqualTo: timestamp)
        .get() // Query for the documents with the specified timestamp
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete(); // Delete each document
      });
      notifyListeners();
      print('${AppStrings.deleted}');
    }).catchError((error) => print('${AppStrings.deletedFailed}: $error'));
  }
}
