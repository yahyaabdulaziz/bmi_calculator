import 'package:bmi_calculator/provider/result_provider.dart';
import 'package:bmi_calculator/ui/home/edit/edit_screen.dart';
import 'package:bmi_calculator/ui/model/result_model.dart';
import 'package:bmi_calculator/utils/app_color.dart';
import 'package:bmi_calculator/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListItemWidget extends StatelessWidget {
  final ResultModel resultModel;

  ListItemWidget({required this.resultModel});

  late ResultProvider provider;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    provider = Provider.of(context);
    return Container(
      height: width * .35,
      margin: EdgeInsets.all(width * .02),
      padding: EdgeInsets.all(width * .01),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 2), // changes position of shadow
        ),
      ], borderRadius: BorderRadius.circular(width * .04), color: Colors.white),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.all(width * .013),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * .03),
                        border: Border.all(color: Colors.deepPurple, width: 1),
                        color: Colors.white),
                    child: Text('${AppStrings.height}: ${resultModel.height}')),
                SizedBox(width: width * .03),
                Container(
                    padding: EdgeInsets.all(width * .013),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * .03),
                        border: Border.all(color: Colors.deepPurple, width: 1),
                        color: Colors.white),
                    child: Text('${AppStrings.weight}: ${resultModel.weight}')),
                SizedBox(width: width * .03),
                Container(
                    padding: EdgeInsets.all(width * .013),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * .03),
                        border: Border.all(color: Colors.deepPurple, width: 1),
                        color: Colors.white),
                    child: Text('${AppStrings.age}: ${resultModel.age}')),
                Spacer(),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, EditScreen.routeName,
                          arguments: resultModel);
                    },
                    child: Icon(Icons.edit))
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            child: Row(
              children: [
                Container(
                    padding: EdgeInsets.all(width * .03),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width * .1),
                        border: Border.all(color: Colors.deepPurple, width: 1),
                        color: Colors.white),
                    child: Text(
                      '${AppStrings.bmiResult}: ${resultModel.bmiResult}',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.italic,
                          color: AppColors.primaryColor),
                    )),
                Spacer(),
                InkWell(
                    onTap: () {
                      provider.delete(resultModel.date);
                    },
                    child: Icon(Icons.delete))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
