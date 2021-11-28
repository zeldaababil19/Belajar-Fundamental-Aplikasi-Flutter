import 'package:final_submission/data/api/api_service.dart';
import 'package:final_submission/data/models/restaurant_model.dart';
import 'package:final_submission/providers/detail_provider.dart';
import 'package:final_submission/utils/enum.dart';
import 'package:final_submission/widgets/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';

  final Restaurant restaurant;

  const DetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    DetailProvider _provider;
    return ChangeNotifierProvider<DetailProvider>(
      create: (_) => DetailProvider(apiService: ApiService(), id: restaurant.id),
      child: SafeArea(
        child: Scaffold(
          body: Consumer<DetailProvider>(
            builder: (context, state, _) {
              _provider = state;
              if (state.state == ResultState.loading) {
                return Center(
                  child: SpinKitHourGlass(
                    color: Color(0xFF98bd8f),
                    size: 50,
                  ),
                );
              } else if (state.state == ResultState.hasData) {
                var restaurantDetailed = state.result.restaurant;
                return DetailRestaurant(
                  restaurant: restaurant,
                  restaurantDetailed: restaurantDetailed,
                  detailProvider: _provider,
                );
              } else if (state.state == ResultState.noData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.error) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/no-wifi.png", width: 100),
                    SizedBox(height: 10),
                    Text("Koneksi terputus!"),
                    ElevatedButton(
                      child: Text("refresh"),
                      onPressed: () {
                        _provider.refresh();
                      },
                    ),
                  ],
                ));
              } else {
                return Center(child: Text(''));
              }
            },
          ),
        ),
      ),
    );
  }
}
