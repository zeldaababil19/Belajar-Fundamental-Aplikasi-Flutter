part of 'helper.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _instance;
  late int _randomNumber;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          print('notification payload: ' + payload);
        }
        selectNotificationSubject.add(payload ?? 'empty payload');
      },
    );
  }

  int random(int n) {
    var random = new Random();
    return random.nextInt(n);
  }

  // Future<void> showBigPictureNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, RestaurantList restaurants) async {
  //   var _channelId = "1";
  //   var _channelName = "channel_01";
  //   var _channelDesc = "dicoding resto";

  //   _randomNumber = random(restaurants.restaurants.length - 1);

  //   var bigPictureStyleInformation = BigPictureStyleInformation(
  //     FilePathAndroidBitmap(restaurants.restaurants[_randomNumber].pictureId),
  //     largeIcon: FilePathAndroidBitmap(restaurants.restaurants[_randomNumber].pictureId),
  //     contentTitle: "Rekomedasi restoran: " + "${restaurants.restaurants[_randomNumber].name}",
  //     htmlFormatContentTitle: true,
  //     summaryText: 'Makan & Minum Enjoy',
  //     htmlFormatSummaryText: true,
  //   );

  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     _channelId,
  //     _channelName,
  //     styleInformation: bigPictureStyleInformation,
  //   );

  //   var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     _channelName,
  //     _channelDesc,
  //     platformChannelSpecifics,
  //     payload: json.encode(
  //       {"randumNumber": _randomNumber, "data": restaurants.toJson()},
  //     ),
  //   );
  // }
  Future<void> showNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin, RestaurantList restaurants) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "Restaurant Channel";

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(_channelId, _channelName, importance: Importance.max, priority: Priority.high, ticker: 'ticker', styleInformation: DefaultStyleInformation(true, true));

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    Random random = Random();
    int randomNum = random.nextInt(restaurants.restaurants.length - 1);
    var restaurant = restaurants.restaurants[randomNum];

    var titleNotification = "<b>Siang ini makan dimana ya?</b>";
    var titleName = "Rekomedasi restoran: " + "${restaurant.name}";

    await flutterLocalNotificationsPlugin.show(0, titleNotification, titleName, platformChannelSpecifics, payload: json.encode(restaurant.toJson()));
  }

  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        print('Inside selectnotif, Payload: ' + payload + 'Route: ' + route);
        var data = RestaurantList.fromJson(json.decode(payload)["data"]);
        // var _randomNumber = Random(data.restaurants.length - 1);
        var restaurant = data.restaurants[json.decode(payload)["randomNumber"]];
        print(restaurant.name);
        print('Route is null');
        Navigation.intentWithData('/detail_page', restaurant);
      },
    );
  }
}
