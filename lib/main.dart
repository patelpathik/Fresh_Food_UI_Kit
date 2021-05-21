import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fresh_food/theme/app_theme.dart';
import 'package:fresh_food/utils/app_template.dart';
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
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: AppTheme().getAppTheme(),
      dark: AppTheme().getDarkTheme(),
      initial: AdaptiveThemeMode.system,
      builder: (light, dark) => MaterialApp(
        title: 'Fresh Food',
        debugShowCheckedModeBanner: false,
        // theme: AppTheme().getAppTheme(),
        // darkTheme: AppTheme().getDarkTheme(),
        theme: light,
        darkTheme: dark,
        // themeMode: themeMode,
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
      ),
    );
  }
}
