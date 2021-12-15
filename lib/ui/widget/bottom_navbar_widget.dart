part of 'widget.dart';

class Navbar extends StatefulWidget {
  final BuildContext context;
  const Navbar(this.context);

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    NavigationProvider navigation = Provider.of<NavigationProvider>(context, listen: false);

    return MultiProvider(
      providers: appProvider,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: baseColor,
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.12),
                blurRadius: 16,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            currentIndex: navigation.index,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              navigation.changeIndex(index);
            },
            selectedLabelStyle: mediumBaseFont.copyWith(
              color: accentColor,
              fontSize: 10,
            ),
            unselectedLabelStyle: mediumBaseFont.copyWith(
              color: navInactiveColor,
              fontSize: 10,
            ),
            items: [
              _buildBottomNavBarItem(
                context,
                label: "Home",
                icon: "assets/home.png",
                activeIcon: "assets/home_active.png",
                // icon: "{$Icons.home}",
                // activeIcon: '{$homeActive}',
              ),
              _buildBottomNavBarItem(
                context,
                label: "Favorite",
                icon: "assets/favorite.png",
                activeIcon: "assets/favorite_active.png",
                // icon: "{$Icons.home}",
                // activeIcon: '{$homeActive}',
              ),
              _buildBottomNavBarItem(
                context,
                label: "Setting",
                icon: "assets/setting.png",
                activeIcon: "assets/setting_active.png",
                // icon: "{$Icons.home}",
                // activeIcon: '{$homeActive}',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

BottomNavigationBarItem _buildBottomNavBarItem(BuildContext context, {required String label, required dynamic icon, required dynamic activeIcon}) {
  return BottomNavigationBarItem(
    label: label,
    icon: (label == "Profile")
        ? Consumer<NavigationProvider>(
            builder: (context, navigationProvider, _) {
              return Stack(
                children: [
                  Container(
                    height: 24,
                    margin: EdgeInsets.only(bottom: 6),
                    child: Image.asset(
                      icon,
                    ),
                  ),
                ],
              );
            },
          )
        : Container(
            height: 24,
            margin: EdgeInsets.only(bottom: 6),
            child: Image.asset(
              icon,
            ),
          ),
    activeIcon: (label == "Profile")
        ? Consumer<NavigationProvider>(
            builder: (context, navigationProvider, _) {
              return Stack(
                children: [
                  Container(
                    height: 24,
                    margin: EdgeInsets.only(bottom: 6),
                    child: Image.asset(
                      activeIcon,
                    ),
                  ),
                ],
              );
            },
          )
        : Container(
            height: 24,
            margin: EdgeInsets.only(bottom: 6),
            child: Image.asset(
              activeIcon,
            ),
          ),
  );
}
