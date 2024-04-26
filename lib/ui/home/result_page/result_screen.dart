import 'package:bmi_calculator/ui/home/result_page/result_view_model.dart';
import 'package:bmi_calculator/ui/model/result_model.dart';
import 'package:bmi_calculator/utils/app_color.dart';
import 'package:bmi_calculator/widgets/list_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pretty_gauge/pretty_gauge.dart';
import 'package:share_plus/share_plus.dart';

class ResultScreen extends StatefulWidget {
  static const String routeName = "ResultScreen";

  ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  ResultViewModel viewModel = ResultViewModel();
  int _limit = 5; // Number of items to fetch per page
  List<ResultModel> _entries = [];
  bool _isRequesting = false;
  bool _isFinish = false;

  @override
  void initState() {
    super.initState();
    fetchNextPage();
  }

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments as double;
    int _limit = 5; // Number of items to fetch per page
    List<ResultModel> _entries = [];
    bool _isRequesting = false;
    bool _isFinish = false;
    viewModel.setBmiInterpretation(context);
    return Scaffold(
        body: ListView(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 8),
            height: MediaQuery.of(context).size.height * .55,
            padding: const EdgeInsets.all(12),
            child: Card(
                elevation: 8,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 12),
                            child: const Text(
                              "Your Score",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.blue),
                            ),
                          ),
                          Spacer(),
                          IconButton(
                              onPressed: () {
                                viewModel.signOutAnonymously(context);
                              },
                              icon: Icon(
                                Icons.logout,
                                color: AppColors.primaryColor,
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PrettyGauge(
                        gaugeSize: 200,
                        minValue: 0,
                        maxValue: 40,
                        segments: [
                          GaugeSegment('UnderWeight', 18.5, Colors.red),
                          GaugeSegment('Normal', 6.4, Colors.green),
                          GaugeSegment('OverWeight', 5, Colors.orange),
                          GaugeSegment('Obese', 10.1, Colors.pink),
                        ],
                        valueWidget: Text(
                          "BMI=${arg.toStringAsFixed(1)}",
                          style: const TextStyle(fontSize: 24),
                        ),
                        currentValue: arg.toDouble(),
                        needleColor: Colors.blue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        viewModel.bmiStatus!,
                        style: TextStyle(
                            fontSize: 20, color: viewModel.bmiStatusColor!),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        viewModel.bmiInterpretation!,
                        style: const TextStyle(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Re-calculate")),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Share.share(
                                    "Your BMI is ${arg.toStringAsFixed(1)} ");
                              },
                              child: const Text("Share")),
                        ],
                      ),
                    ]))),
        Container(
          height: MediaQuery.of(context).size.height * .04,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: const Text(
            "All Entries",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          height: MediaQuery.of(context).size.height * .38,
          child: StreamBuilder<List<ResultModel>>(
            stream: viewModel.fetchEntriesOrderedByDate(_limit),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No entries found.'));
              } else {
                final entries = snapshot.data!;
                _entries
                    .addAll(entries); // Append new entries to the existing list
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (!_isRequesting &&
                        !_isFinish &&
                        scrollInfo.metrics.maxScrollExtent ==
                            scrollInfo.metrics.pixels) {
                      fetchNextPage();
                    }
                    return true;
                  },
                  child: ListView.builder(
                    itemCount: _entries.length,
                    itemBuilder: (context, index) {
                      final list = _entries[index];
                      return ListItemWidget(resultModel: list);
                    },
                  ),
                );
              }
            },
          ),
        )
      ],
    ));
  }

  QueryDocumentSnapshot? _lastDocument;

  void fetchNextPage() async {
    if (!_isRequesting && !_isFinish) {
      _isRequesting = true;
      QuerySnapshot querySnapshot;
      if (_lastDocument == null) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('bmiResults')
            .orderBy('timestamp', descending: true)
            .limit(_limit)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('bmiResults')
            .orderBy('timestamp', descending: true)
            .startAfterDocument(_lastDocument!)
            .limit(_limit)
            .get();
      }

      if (querySnapshot.docs.isNotEmpty) {
        _lastDocument = querySnapshot.docs.last;
        final entries = querySnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          final height = data['height'] as double?;
          final weight = data['weight'] as double?;
          final age = data['age'] as int?;
          final timestamp = data['timestamp'] as Timestamp?;
          final bmiResult = data['result'] as double?;

          if (height != null &&
              weight != null &&
              age != null &&
              timestamp != null &&
              bmiResult != null) {
            return ResultModel(
              height: height,
              weight: weight,
              age: age,
              date: timestamp.toDate(),
              bmiResult: bmiResult,
            );
          } else {
            // Handle the case where the data is missing or invalid
            throw Exception('Invalid data');
          }
        }).toList();

        setState(() {
          _entries.addAll(entries);
        });
      } else {
        _isFinish = true;
      }

      _isRequesting = false;
    }
  }
}
