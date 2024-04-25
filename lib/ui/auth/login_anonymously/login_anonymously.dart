import 'package:bmi_calculator/ui/auth/login_anonymously/login_view_model.dart';
import 'package:bmi_calculator/utils/app_assets.dart';
import 'package:bmi_calculator/utils/app_color.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "LoginScreen";
  final LoginViewModel viewModel;

  const LoginScreen({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: AppColors.primaryColor,
        child: Stack(
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    mq.width * (1 - _animation.value),
                    // Slide from right to left
                    0,
                  ),
                  child: child,
                );
              },
              child: Container(
                color: AppColors.primaryColor,
                child: Center(
                  child: Image.asset(
                    AppAssets.splash,
                    width: MediaQuery.of(context).size.width * .25,
                    height: MediaQuery.of(context).size.width * .50,
                  ),
                ),
              ),
            ),
            Positioned(
              top: mq.width * .5,
              width: mq.width,
              child: Container(
                margin: const EdgeInsets.all(12),
                child: const Text(
                  "Welcome To BMI Calculator Application",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              top: mq.width * 1.4,
              width: mq.width,
              child: Container(
                  margin: const EdgeInsets.all(12),
                  child: ElevatedButton(
                      onPressed: () {
                        widget.viewModel.login(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.login_rounded,
                            color: AppColors.primaryColor,
                          ),
                          SizedBox(width: 8),
                          const Text(
                            "Login Anonymously",
                            style: TextStyle(
                                fontSize: 20, color: AppColors.primaryColor),
                          ),
                        ],
                      ))),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
