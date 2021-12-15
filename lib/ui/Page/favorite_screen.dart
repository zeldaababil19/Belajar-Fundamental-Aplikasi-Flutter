part of 'page.dart';

class FavoritePage extends StatelessWidget {
  static const String favoritesTitle = 'Favorites';

  final DBProvider dbProvider;

  const FavoritePage({Key? key, required this.dbProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            favoritesTitle,
            style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
          )),
      body: Consumer<DBProvider>(
        builder: (context, dbProvider, child) {
          if (dbProvider.state == ResultState.withData) {
            return ListView.builder(
              itemCount: dbProvider.favorites.length,
              itemBuilder: (context, index) {
                return CardRestauranWidget(
                  restaurant: dbProvider.favorites[index],
                );
              },
            );
          } else {
            return Center(
              child: Text(dbProvider.message),
            );
          }
        },
      ),
    );
  }
}
