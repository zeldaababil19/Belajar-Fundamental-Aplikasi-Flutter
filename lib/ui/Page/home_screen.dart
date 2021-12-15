part of 'page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RestaurantProvider provider;
  final TextEditingController _filter = TextEditingController();

  Widget _appBar = Text(
    'RestaurantApp',
    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
  );
  Icon _searchIcon = const Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: _appBar,
        actions: <Widget>[
          IconButton(
            icon: _searchIcon,
            iconSize: 30,
            onPressed: _search,
          ),
        ],
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
        } else if (state.state == ResultState.withData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestauranWidget(restaurant: restaurant);
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
