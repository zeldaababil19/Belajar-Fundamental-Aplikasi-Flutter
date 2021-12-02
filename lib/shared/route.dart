part of 'shared.dart';

Map<String, WidgetBuilder> appRoute = {
  SplashScreenPage.routeName: (context) => SplashScreenPage(),
  MainScreen.routeName: (context) => MainScreen(),
  DetailPage.routeName: (context) => DetailPage(
        restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
      ),
  SettingPage.routeName: (context) => SettingPage(),
};
