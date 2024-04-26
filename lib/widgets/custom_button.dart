import 'package:bmi_calculator/utils/app_color.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  String title;
  Function()? onPressed;

  CustomButtonWidget({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      onPressed: onPressed,
      child: Text(title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: AppColors.whiteColor)),
    );
  }
}
