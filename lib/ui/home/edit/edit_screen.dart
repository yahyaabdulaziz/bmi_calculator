import 'package:bmi_calculator/ui/home/edit/edit_view_model.dart';
import 'package:bmi_calculator/ui/model/result_model.dart';
import 'package:bmi_calculator/utils/app_assets.dart';
import 'package:bmi_calculator/utils/app_strings.dart';
import 'package:bmi_calculator/widgets/custom_button.dart';
import 'package:bmi_calculator/widgets/custom_text_form_field.dart';
import 'package:bmi_calculator/widgets/form_label.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  static const String routeName = "${AppStrings.editScreenRouteName}";

  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  EditViewModel viewModel = EditViewModel();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var arg = ModalRoute.of(context)?.settings.arguments as ResultModel;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(height * .03),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: height * .08,
                ),
                Image.asset(AppAssets.splash, height: height * .12),
                SizedBox(
                  height: height * .09,
                ),
                Text(
                  '${AppStrings.editScreenMessage}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: height * .06,
                ),
                FormLabelWidget(
                  label: '  ${AppStrings.weight}',
                ),
                SizedBox(
                  height: height * .01,
                ),
                CustomTextFormField(
                    controller: viewModel.newHeightController,
                    hintText: "${arg.weight}",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return '${AppStrings.enterNumber}';
                      }

                      final number = int.tryParse(value);

                      if (number == null) {
                        return '${AppStrings.enterValidNumber}';
                      }

                      if (number < 0 || number > 200) {
                        return '${AppStrings.weightValidationMessage}';
                      }

                      return null;
                    },
                    type: TextInputType.number),
                SizedBox(
                  height: height * .04,
                ),
                FormLabelWidget(
                  label: '  ${AppStrings.height}',
                ),
                SizedBox(
                  height: height * .01,
                ),
                CustomTextFormField(
                  hintText: "${arg.height}",
                  controller: viewModel.newHeightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '${AppStrings.enterHeightMessage}';
                    }

                    final number = double.tryParse(value);

                    if (number == null) {
                      return '${AppStrings.enterValidNumber}';
                    }

                    if (number < 0 || number > 2) {
                      return '${AppStrings.heightValidationMessage}';
                    }

                    return null;
                  },
                  type: TextInputType.number,
                ),
                SizedBox(
                  height: height * .04,
                ),
                FormLabelWidget(
                  label: '  ${AppStrings.age}',
                ),
                SizedBox(
                  height: height * .01,
                ),
                CustomTextFormField(
                  hintText: "${arg.age}",
                  controller: viewModel.newAgeController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '${AppStrings.enterNumber}';
                    }

                    final number = int.tryParse(value);

                    if (number == null) {
                      return '${AppStrings.enterValidNumber}';
                    }

                    if (number < 0 || number > 200) {
                      return '${AppStrings.ageValidationMessage}';
                    }

                    return null;
                  },
                  type: TextInputType.number,
                ),
                SizedBox(
                  height: height * .06,
                ),
                CustomButtonWidget(
                    title: '${AppStrings.update}',
                    onPressed: () {
                      viewModel.updateForm(context, arg, arg.date);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
