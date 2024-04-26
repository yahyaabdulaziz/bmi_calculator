import 'package:bmi_calculator/ui/home/home_page/home_view_model.dart';
import 'package:bmi_calculator/utils/app_assets.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: viewModel.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset(AppAssets.splash,
                    height: MediaQuery.of(context).size.height * .12),
                const SizedBox(
                  height: 75,
                ),
                Text(
                  'Welcome Back To BMI Application',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 40,
                ),
                FormLabelWidget(
                  label: '  Weight',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                    controller: viewModel.weightController,
                    hintText: 'enter your weight Weight (in Kg)',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a number';
                      }

                      final number = int.tryParse(value!);

                      if (number == null) {
                        return 'Please enter a valid number';
                      }

                      if (number < 0 || number > 200) {
                        return 'Number must be between 0 and 200';
                      }

                      return null;
                    },
                    type: TextInputType.number),
                const SizedBox(
                  height: 32,
                ),
                FormLabelWidget(
                  label: '  Height',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: 'enter your Height (in M)',
                  controller: viewModel.heightController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a your height (in M)';
                    }

                    final number = double.tryParse(value!);

                    if (number == null) {
                      return 'Please enter a valid number';
                    }

                    if (number < 0 || number > 2) {
                      return 'Number must be between 0 and 2';
                    }

                    return null;
                  },
                  type: TextInputType.number,
                ),
                const SizedBox(
                  height: 32,
                ),
                FormLabelWidget(
                  label: '  Age',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: 'enter your Age',
                  controller: viewModel.ageController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a number';
                    }

                    final number = int.tryParse(value!);

                    if (number == null) {
                      return 'Please enter a valid number';
                    }

                    if (number < 0 || number > 200) {
                      return 'Number must be between 0 and 150';
                    }

                    return null;
                  },
                  type: TextInputType.number,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomButtonWidget(
                    title: 'Submit',
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
