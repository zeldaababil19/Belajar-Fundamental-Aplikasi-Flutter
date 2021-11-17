import 'package:flutter/material.dart';
import 'package:subs_pertama/data/restaurant.dart';
import 'package:subs_pertama/detail_page.dart';
import 'package:subs_pertama/splashScreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        ListPage.routeName: (context) => ListPage(),
        Detail.routeName: (context) => Detail(
              restaurant: ModalRoute.of(context)?.settings.arguments as RestaurantElement,
            ),
      },
    ),
  );
}

class ListPage extends StatefulWidget {
  static const routeName = '/list_page';

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        title: Text('Restaurant'),
        backgroundColor: Color(0xFF98bd8f),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context).loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // loading widget
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              final List<RestaurantElement> restaurants = restaurantFromJson(snapshot.data!).restaurants;
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: restaurants.length,
                  itemBuilder: (context, index) {
                    return _buildRestaurantItem(context, restaurants[index]);
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, RestaurantElement restaurant) {
    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: ClipRect(
            child: Image.network(
              restaurant.pictureId,
              width: 100,
              fit: BoxFit.fill,
            ),
          ),
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: Text(
                    restaurant.name,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text('📍 ${restaurant.city}'),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text('⭐ ${restaurant.rating.toString()}'),
                ),
              ],
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(context, Detail.routeName, arguments: restaurant);
        },
      ),
    );
  }
}
