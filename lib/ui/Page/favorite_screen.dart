part of 'page.dart';

class FavoritePage extends StatelessWidget {
  static const String favoritesTitle = 'Favorites';

  final DBProvider dbProvider;

  const FavoritePage({required this.dbProvider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Favorite',
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
          )),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DBProvider>(
      builder: (context, dbProvider, child) {
        if (dbProvider.state == ResultState.withData) {
          return ListView.builder(
            itemCount: dbProvider.favorites.length,
            itemBuilder: (context, index) {
              return CardRestauranWidget(restaurant: dbProvider.favorites[index]);
            },
          );
        } else {
          return Center(
            child: Text(dbProvider.message),
          );
        }
      },
    );
  }
}
