part of 'ui.dart';

class MainScreen extends StatefulWidget {
  static String routeName = '/main_screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    DBProvider databaseProvider = DBProvider(dbHelper: DBHelper());
    NavigationProvider navigation = Provider.of<NavigationProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: accentColor,
          ),
          SafeArea(
            child: Stack(
              children: [
                Container(
                  color: baseColor,
                ),
                PageView(
                  controller: navigation.page,
                  onPageChanged: (index) {
                    navigation.changeIndex(index);
                  },
                  children: [
                    HomePage(),
                    FavoritePage(
                      key: Key('Favorite_navBar'),
                      dbProvider: databaseProvider,
                    ),
                    SettingPage(),
                  ],
                ),
                Navbar(context),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
