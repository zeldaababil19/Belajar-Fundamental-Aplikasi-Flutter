part of 'shared.dart';

List<SingleChildWidget> appProvider = [
  ChangeNotifierProvider(create: (_) => NavigationProvider()),
  ChangeNotifierProvider(
    create: (_) => RestaurantProvider(apiService: ApiService(), id: ''),
  ),
  ChangeNotifierProvider(create: (_) => SchedulingProvider()),
  ChangeNotifierProvider(
    create: (_) => DBProvider(dbHelper: DBHelper()),
  ),
  ChangeNotifierProvider(
    create: (_) => PreferencesProvider(
      preferencesHelper: PreferencesHelper(
        sharedPreferences: SharedPreferences.getInstance(),
      ),
    ),
  ),
];
