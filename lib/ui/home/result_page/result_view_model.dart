import 'package:bmi_calculator/ui/auth/login_anonymously/login_anonymously.dart';
import 'package:bmi_calculator/ui/model/result_model.dart';
import 'package:bmi_calculator/utils/app_strings.dart';
import 'package:bmi_calculator/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResultViewModel extends ChangeNotifier {
  String? bmiStatus;

  String? bmiInterpretation;

  Color? bmiStatusColor;

  List<ResultModel> entries = []; // Move _entries outside of the build method


  void delete(DateTime timestamp) async {
    final collection =
        FirebaseFirestore.instance.collection(Constants.collectionName);
    final querySnapshot = await collection
        .where('${AppStrings.timestamp}', isEqualTo: timestamp)
        .get();

    querySnapshot.docs.forEach((doc) async {
      await doc.reference.delete();
    });

    notifyListeners();
    print('${AppStrings.deleted}');
  }

  Stream<List<ResultModel>> fetchEntriesOrderedByDate(int limit) {
    return FirebaseFirestore.instance
        .collection('bmiResults')
        .orderBy('timestamp', descending: true)
        .limit(limit)
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

  void signOutAnonymously(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      print('User signed out successfully');
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    } catch (e) {
      print('Failed to sign out: $e');
    }
  }
}
