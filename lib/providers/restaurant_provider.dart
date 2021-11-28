import 'dart:async';

import 'package:final_submission/data/api/api_service.dart';
import 'package:final_submission/utils/enum.dart';
import 'package:flutter/material.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantProvider({required this.apiService, required this.id}) {
    getAllRestaurants();
  }

  late dynamic _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  dynamic get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> getAllRestaurants() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.getRestaurantList();
      notifyListeners();
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantResult = result;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }

  Future<dynamic> getRestaurantSearch(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final result = await apiService.getRestaurantSearch(query);
      if (result.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Tidak ditemukan';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = result;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}
