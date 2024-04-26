import 'package:bmi_calculator/ui/model/result_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultViewModel {
  String? bmiStatus;

  String? bmiInterpretation;

  Color? bmiStatusColor;

  Stream<List<ResultModel>> fetchEntriesOrderedByDate() {
    return FirebaseFirestore.instance
        .collection('bmiResults')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) {
              final data = doc.data();
              return ResultModel(
                height: data['height'],
                weight: data['weight'],
                date: (data['timestamp'] as Timestamp).toDate(),
                age: data['age'],
                bmiResult: data['result'],
              );
            }).toList());
  }

  // this instructions imported from ChatGPT
  void setBmiInterpretation(BuildContext context) {
    var bmiScore = ModalRoute.of(context)?.settings.arguments as double;

    if (bmiScore > 30) {
      bmiStatus = "Obese";
      bmiInterpretation = "Please work to reduce obesity";
      bmiStatusColor = Colors.pink;
    } else if (bmiScore >= 25) {
      bmiStatus = "Overweight";
      bmiInterpretation = "Do regular exercise & reduce the weight";
      bmiStatusColor = Colors.orange;
    } else if (bmiScore >= 18.5) {
      bmiStatus = "Normal";
      bmiInterpretation = "Enjoy, You are fit";
      bmiStatusColor = Colors.green;
    } else if (bmiScore < 18.5) {
      bmiStatus = "Underweight";
      bmiInterpretation = "Try to increase the weight";
      bmiStatusColor = Colors.red;
    }
  }
}
