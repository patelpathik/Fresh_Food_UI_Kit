import 'package:flutter/material.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/utils/app_template.dart';
import 'package:fresh_food/utils/globals.dart';
import 'package:fresh_food/views/checkout/add_card/add_card.dart';
import 'package:fresh_food/views/edit_quantity/edit_quantity_view.dart';
import 'package:fresh_food/views/home/home_view.dart';
import 'package:fresh_food/views/live_chat/live_chat_view.dart';
import 'package:fresh_food/views/on_boarding/on_boarding_view.dart';
import 'package:fresh_food/views/product/product_view.dart';
import 'package:fresh_food/views/recipes/recipes_view.dart';
import 'package:fresh_food/views/search/search_view.dart';
import 'package:fresh_food/views/sign_in/sign_in.dart';
import 'package:fresh_food/views/splash_screen/splash_screen.dart';
import 'package:fresh_food/views/store/store_view.dart';
import 'package:fresh_food/views/user_account/user_account.dart';
import 'package:fresh_food/views/user_orders/user_orders.dart';
import 'package:fresh_food/views/voice_search/voice_search_view.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

import 'views/checkout/checkout_view.dart';
import 'views/home/home_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.system;
  bool isSet = false;

  void listenToThemeChange() {
    Globals.isCustomThemeSet.listen((value) {
      ThemeMode themeMode = ThemeMode.system;
      if ((Globals.customDarkModePref != null &&
          Globals.isCustomThemeSet != null)) {
        if (Globals.isCustomThemeSet.getValue()) {
          themeMode = (Globals.customDarkModePref.getValue()
              ? ThemeMode.dark
              : ThemeMode.light);
        } else {
          themeMode = ThemeMode.system;
        }
      }
      if (mounted) setState(() => this.themeMode = themeMode);
      print("ThemeMode :: ${this.themeMode}");
    });
    Globals.customDarkModePref.listen((value) {
      ThemeMode themeMode = ThemeMode.system;
      if ((Globals.customDarkModePref != null &&
          Globals.isCustomThemeSet != null)) {
        if (Globals.isCustomThemeSet.getValue()) {
          themeMode = (Globals.customDarkModePref.getValue()
              ? ThemeMode.dark
              : ThemeMode.light);
        } else {
          themeMode = ThemeMode.system;
        }
      }
      if (mounted) setState(() => this.themeMode = themeMode);
      print("ThemeMode :: ${this.themeMode}");
    });
  }

  @override
  Widget build(BuildContext context) {
    if (Globals.customDarkModePref != null &&
        Globals.isCustomThemeSet != null &&
        !isSet) {
      listenToThemeChange();
      if (mounted) setState(() => isSet = true);
    }
    return MaterialApp(
      title: 'Fresh Food',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getAppTheme(),
      darkTheme: AppTheme().getDarkTheme(),
      themeMode: themeMode,
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
          case Store.TAG:
            page = Store();
            break;
          case Search.TAG:
            page = Search();
            break;
          case VoiceSearch.TAG:
            page = VoiceSearch();
            break;
          case Product.TAG:
            page = Product();
            break;
          case HomeView.TAG:
            page = HomeView();
            break;
          case Recipes.TAG:
            page = Recipes();
            break;
          case EditQuantity.TAG:
            page = EditQuantity();
            break;
          case Checkout.TAG:
            page = Checkout();
            break;
          case AddCard.TAG:
            page = AddCard();
            break;
          case UserAccount.TAG:
            page = UserAccount();
            break;
          case UserOrders.TAG:
            page = UserOrders();
            break;
          case LiveChat.TAG:
            page = LiveChat();
            break;
        }
        return SwipeablePageRoute(
          builder: (context) => AppTemplate(child: page),
          settings: settings,
        );
      },
    );
  }
}
