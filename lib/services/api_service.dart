part of 'service.dart';

class ApiService {
  static const String _url = 'https://restaurant-api.dicoding.dev/';
  static const String _list = '${_url}list';
  static const String _detail = '${_url}detail/';
  static const String _search = '${_url}search?q=';
  static const String _addReview = '${_url}review';

  // final http.Client client;
  // ApiService(this.client);

  Future<RestaurantList> getRestaurantsList(http.Client client) async {
    final response = await client.get(Uri.parse(_list));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse(_detail + id));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearch> getRestaurantSearch(String query) async {
    final response = await http.get(Uri.parse(_search + query));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  // Future<RestaurantList> getRestaurantSearch(String query) async {
  //   final response = await client.get(Uri.parse(_search + query));
  //   if (response.statusCode == 200) {
  //     return RestaurantList.fromJson(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load restaurant list');
  //   }
  // }

  Future<ReviewResponse> postReview(CustomerReview review) async {
    var _reviewBody = jsonEncode(review.toJson());
    final response = await http.post(
      Uri.parse(_addReview),
      body: _reviewBody,
      headers: <String, String>{
        "Content-Type": "application/json",
        "X-Auth-Token": "12345",
      },
    );
    if (response.statusCode == 200) {
      return ReviewResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to make review');
    }
  }
}
