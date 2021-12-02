import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission_ketiga/helper/helper.dart';
import 'package:submission_ketiga/models/models.dart';
import 'package:submission_ketiga/providers/provider.dart';
import 'package:submission_ketiga/services/service.dart';
import 'package:submission_ketiga/shared/shared.dart';
import 'package:submission_ketiga/ui/Page/page.dart';
import 'package:submission_ketiga/ui/ui.dart';

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: appProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RestaurantApp',
        theme: ThemeData(textTheme: myTextTheme, primarySwatch: Colors.green, visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: SplashScreenPage.routeName,
        routes: appRoute,
      ),
    );
  }
}
