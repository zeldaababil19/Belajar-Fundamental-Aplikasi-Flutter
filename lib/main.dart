import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:final_submission/data/api/api_service.dart';
import 'package:final_submission/data/db/db_helper.dart';
import 'package:final_submission/data/models/restaurant_model.dart';
import 'package:final_submission/preferences/preference_helper.dart';
import 'package:final_submission/providers/db_provider.dart';
import 'package:final_submission/providers/preferences_provider.dart';
import 'package:final_submission/providers/restaurant_provider.dart';
import 'package:final_submission/providers/schedulling_provider.dart';
import 'package:final_submission/screens/detail_screen.dart';
import 'package:final_submission/screens/home_screen.dart';
import 'package:final_submission/screens/splashsreen.dart';
import 'package:final_submission/styles/style.dart';
import 'package:final_submission/utils/background_service.dart';
import 'package:final_submission/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService(), id: ''),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RestaurantApp',
        theme: ThemeData(textTheme: myTextTheme, primarySwatch: Colors.green, visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: SplashScreen.routeName,
        routes: {
          SplashScreen.routeName: (context) => const SplashScreen(),
          HomePage.routeName: (context) => HomePage(),
          DetailPage.routeName: (context) => DetailPage(
                restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
              ),
        },
      ),
    );
  }
}
