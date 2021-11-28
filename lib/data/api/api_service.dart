import 'dart:convert';

import 'package:final_submission/data/models/restaurant_model.dart';
import 'package:final_submission/data/models/review_model.dart';
import 'package:final_submission/data/models/search_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String baseUrlImg = '${_baseUrl}images/';

  Future<RestaurantList> getRestaurantList() async {
    final response = await http.get(Uri.parse(_baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<RestaurantSearch> getRestaurantSearch(String query) async {
    final response = await http.get(Uri.parse(_baseUrl + "search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }

  Future<ReviewResponse> postReview(CustomerReview review) async {
    var _review = jsonEncode(review.toJson());
    final response = await http.post(
      Uri.parse(_baseUrl + "review"),
      body: _review,
      headers: <String, String>{
        "Content-Type": "application/json",
        "X-Auth-Token": "12345",
      },
    );
    if (response.statusCode == 200) {
      return ReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post');
    }
  }
}
