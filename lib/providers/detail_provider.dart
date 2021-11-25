import 'dart:async';
import 'package:flutter/material.dart';
import 'package:submission_ketiga/data/api/api_service.dart';
import 'package:submission_ketiga/data/models/restaurant_model.dart';
import 'package:submission_ketiga/data/models/review_model.dart';
import 'package:submission_ketiga/utils/enum.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailProvider({required this.apiService, required this.id}) {
    getRestaurantDetail();
  }

  // late dynamic _restaurantResult;
  late RestaurantDetail _restaurantDetail;
  String _message = '';
  late ResultState _state;

  String get message => _message;
  RestaurantDetail get result => _restaurantDetail;
  ResultState get state => _state;

  void refresh() {
    getRestaurantDetail();
    notifyListeners();
  }

  Future<dynamic> getRestaurantDetail() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurantDetail(id);
      if (restaurant.error) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantDetail = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  Future<dynamic> postReview(CustomerReview review) async {
    try {
      final response = await apiService.postReview(review);

      if (response.error) getRestaurantDetail();
    } catch (e) {
      refresh();
      // _state = ResultState.Error;
      notifyListeners();
      // return _message = 'Error: $e';
    }
  }
}


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:submission_ketiga/data/api/api_service.dart';
// import 'package:submission_ketiga/data/models/review_model.dart';
// import 'package:submission_ketiga/utils/enum.dart';

// class DetailProvider extends ChangeNotifier {
//   final ApiService apiService;
//   final String id;

//   DetailProvider({required this.apiService, required this.id}) {
//     getRestaurantDetail(id);
//   }

//   late dynamic _restaurantResult;
//   late ResultState _state;

//   String _message = '';

//   String get message => _message;

//   dynamic get result => _restaurantResult;

//   ResultState get state => _state;

//   Future<dynamic> getRestaurantDetail(String id) async {
//     try {
//       _state = ResultState.Loading;
//       notifyListeners();
//       final restaurantDetail = await apiService.getRestaurantDetail(id);
//       _state = ResultState.HasData;
//       notifyListeners();
//       return _restaurantResult = restaurantDetail;
//     } catch (e) {
//       _state = ResultState.Error;
//       notifyListeners();
//       return _message = 'Error: $e';
//     }
//   }

//   Future<dynamic> postReview(CustomerReview review) async {
//     try {
//       final response = await apiService.postReview(review);

//       if (!response.error) getRestaurantDetail(review.id!);
//     } catch (e) {
//       _state = ResultState.Error;
//       notifyListeners();
//       return _message = 'Error: $e';
//     }
//   }
// }
