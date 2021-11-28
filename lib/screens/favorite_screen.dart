import 'package:final_submission/providers/db_provider.dart';
import 'package:final_submission/utils/enum.dart';
import 'package:final_submission/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  static const String favoritesTitle = 'Favorites';

  final DatabaseProvider dbProvider;

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
    return Consumer<DatabaseProvider>(
      builder: (context, dbProvider, child) {
        if (dbProvider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: dbProvider.favorites.length,
            itemBuilder: (context, index) {
              return CardRestaurant(restaurant: dbProvider.favorites[index]);
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
