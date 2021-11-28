import 'package:final_submission/providers/restaurant_provider.dart';
import 'package:final_submission/utils/enum.dart';
import 'package:final_submission/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late RestaurantProvider provider;
  final TextEditingController _filter = TextEditingController();
  Icon _searchIcon = const Icon(Icons.search);
  Widget _appBar = Text(
    'RestaurantApp',
    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _appBar,
        leading: IconButton(
          icon: _searchIcon,
          iconSize: 30,
          onPressed: _search,
        ),
      ),
      body: _buildItem(context),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        provider = state;
        if (state.state == ResultState.loading) {
          return const Center(
            child: SpinKitHourGlass(color: Color(0xFF98bd8f)),
          );
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.error) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/no-wifi.png", width: 100),
              const SizedBox(
                height: 10,
              ),
              const Text("Koneksi terputus!"),
              ElevatedButton(
                child: const Text("refresh"),
                onPressed: () {
                  provider.getAllRestaurants();
                },
              ),
            ],
          ));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }

  void _search() {
    setState(
      () {
        if (_searchIcon.icon == Icons.search) {
          _searchIcon = Icon(Icons.close);
          _appBar = TextField(
            controller: _filter,
            cursorColor: Colors.white,
            decoration: InputDecoration(hintText: 'Cari nama restoran'),
            onChanged: (query) => {
              if (query != '')
                {
                  provider.getRestaurantSearch(query),
                }
            },
          );
        } else {
          this._searchIcon = Icon(Icons.search);
          this._appBar = Text('RestaurantApp', style: Theme.of(context).textTheme.headline5);
          provider.getAllRestaurants();
          _filter.clear();
        }
      },
    );
  }
}
