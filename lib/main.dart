import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission_ketiga/data/api/api_service.dart';
import 'package:submission_ketiga/data/models/restaurant_model.dart';
import 'package:submission_ketiga/providers/restaurant_provider.dart';
import 'package:submission_ketiga/screens/detail_screen.dart';
import 'package:submission_ketiga/screens/list_screen.dart';
import 'package:submission_ketiga/screens/splashsreen.dart';
import 'package:submission_ketiga/styles/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService(), id: ''),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RestaurantApp',
        theme: ThemeData(textTheme: myTextTheme, primarySwatch: Colors.green, visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => SplashScreen(),
          ListPage.routeName: (context) => ListPage(),
          DetailPage.routeName: (context) => DetailPage(
                restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
        },
      ),
    );
  }
}
