import 'package:bmi_calculator/ui/model/result_model.dart';
import 'package:flutter/material.dart';

class ListItemWidget extends StatelessWidget {
  final ResultModel resultModel;

  const ListItemWidget({required this.resultModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ], borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.deepPurple, width: 1),
                        color: Colors.white),
                    child: Text('Height: ${resultModel.height}')),
                SizedBox(width: 6),
                Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.deepPurple, width: 1),
                        color: Colors.white),
                    child: Text('Weight: ${resultModel.weight}')),
                SizedBox(width: 6),
                Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.deepPurple, width: 1),
                        color: Colors.white),
                    child: Text('Age: ${resultModel.age}')),
                Spacer(),
                InkWell(onTap: () {}, child: Icon(Icons.edit))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              children: [
                Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.deepPurple, width: 1),
                        color: Colors.white),
                    child: Text(
                      'BMI Result: ${resultModel.bmiResult}',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    )),
                Spacer(),
                InkWell(onTap: () {}, child: Icon(Icons.delete))
              ],
            ),
          ),
        ],
      ),
    );
  }
}