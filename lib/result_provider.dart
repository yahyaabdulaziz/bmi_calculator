import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultProvider extends ChangeNotifier {
  void delete(DateTime timestamp) {
    final collection = FirebaseFirestore.instance.collection('bmiResults');
    collection
        .where('timestamp', isEqualTo: timestamp)
        .get() // Query for the documents with the specified timestamp
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete(); // Delete each document
      });
      notifyListeners();
      print('Deleted');
    }).catchError((error) => print('Delete failed: $error'));
  }
}
