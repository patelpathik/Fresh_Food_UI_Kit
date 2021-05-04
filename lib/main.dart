import 'package:flutter/material.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/utils/app_template.dart';
import 'package:fresh_food/views/home/home_view.dart';
import 'package:fresh_food/views/on_boarding/on_boarding_view.dart';
import 'package:fresh_food/views/sign_in/sign_in.dart';
import 'package:fresh_food/views/splash_screen/splash_screen.dart';

import 'views/home/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fresh Food',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getAppTheme(),
      darkTheme: AppTheme().getDarkTheme(),
      builder: (context, child) => AppTemplate(child: child),
      onGenerateRoute: (settings) {
        Widget page;
        switch (settings.name) {
          case "/":
          case SplashScreen.TAG:
            page = SplashScreen();
            break;
          case SignIn.TAG:
            page = SignIn();
            break;
          case OnBoarding.TAG:
            page = OnBoarding();
            break;
          case HomeView.TAG:
            page = HomeView();
            break;
        }
        return MaterialPageRoute(
          builder: (context) => SafeArea(child: page),
          settings: settings,
        );
      },
    );
  }
}
