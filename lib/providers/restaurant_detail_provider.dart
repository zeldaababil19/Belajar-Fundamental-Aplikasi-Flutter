part of 'provider.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    getRestaurantDetail();
  }

  late RestaurantDetail _restaurantDetail;
  String _message = "";
  late ResultState _state;

  RestaurantDetail get result => _restaurantDetail;
  String get message => _message;
  ResultState get state => _state;

  Future<dynamic> getRestaurantDetail() async {
    try {
      _state = ResultState.loading;
      final restaurant = await apiService.getRestaurantDetail(id);
      notifyListeners();
      if (restaurant.error) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.withData;
        notifyListeners();
        return _restaurantDetail = restaurant;
      }
    } catch (error) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $error';
    }
  }

  Future<dynamic> postReview(CustomerReview review) async {
    try {
      final response = await apiService.postReview(review);

      if (response.error) getRestaurantDetail();
    } catch (error) {
      refresh();
      notifyListeners();
    }
  }

  void refresh() {
    getRestaurantDetail();
    notifyListeners();
  }
}
