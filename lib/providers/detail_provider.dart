import 'dart:async';

import 'package:final_submission/data/api/api_service.dart';
import 'package:final_submission/data/models/restaurant_model.dart';
import 'package:final_submission/data/models/review_model.dart';
import 'package:final_submission/utils/enum.dart';
import 'package:flutter/material.dart';

class DetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  DetailProvider({required this.apiService, required this.id}) {
    getRestaurantDetail();
  }

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
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getRestaurantDetail(id);
      if (restaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
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
      notifyListeners();
    }
  }
}
