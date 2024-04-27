import 'package:bmi_calculator/provider/result_provider.dart';
import 'package:bmi_calculator/ui/auth/login_anonymously/login_anonymously.dart';
import 'package:bmi_calculator/ui/auth/login_anonymously/login_view_model.dart';
import 'package:bmi_calculator/ui/home/edit/edit_screen.dart';
import 'package:bmi_calculator/ui/home/edit/edit_view_model.dart';
import 'package:bmi_calculator/ui/home/home_page/home_screen.dart';
import 'package:bmi_calculator/ui/home/result_page/result_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // initializing Firebase with my app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // using Provider State Management
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ResultProvider>(
      create: (_) => ResultProvider(),
    ),
    ChangeNotifierProvider<EditViewModel>(
      create: (_) => EditViewModel(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        // all the routes of my app
        LoginScreen.routeName: (_) => LoginScreen(
              viewModel: LoginViewModel(),
            ),
        HomeScreen.routeName: (_) => HomeScreen(),
        ResultScreen.routeName: (_) => ResultScreen(),
        EditScreen.routeName: (_) => EditScreen()
      },
      // first route the app will start with
      initialRoute: LoginScreen.routeName,
    );
  }
}
