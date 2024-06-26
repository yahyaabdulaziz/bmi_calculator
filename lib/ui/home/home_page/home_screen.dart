import 'package:bmi_calculator/ui/home/home_page/home_view_model.dart';
import 'package:bmi_calculator/utils/app_assets.dart';
import 'package:bmi_calculator/utils/app_strings.dart';
import 'package:bmi_calculator/widgets/custom_button.dart';
import 'package:bmi_calculator/widgets/custom_text_form_field.dart';
import 'package:bmi_calculator/widgets/form_label.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel viewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
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
                  '${AppStrings.welcomeMessage}',
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
                    controller: viewModel.weightController,
                    hintText: '${AppStrings.enterWeightMessage}',
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
                  hintText: '${AppStrings.enterHeightMessage}',
                  controller: viewModel.heightController,
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
                  hintText: '${AppStrings.enterAge}',
                  controller: viewModel.ageController,
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
                  height: height * .07,
                ),
                CustomButtonWidget(
                    title: '${AppStrings.submit}',
                    onPressed: () {
                      viewModel.submitForm(context);
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
