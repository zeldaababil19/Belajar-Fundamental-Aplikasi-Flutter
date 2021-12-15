part of 'provider.dart';

class DBProvider extends ChangeNotifier {
  final DBHelper dbHelper;

  DBProvider({required this.dbHelper}) {
    _getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await dbHelper.getFavorites();
    if (_favorites.length > 0) {
      _state = ResultState.withData;
    } else {
      _state = ResultState.noData;
      _message = 'Tap ikon hati untuk simpan restoran favorite!';
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await dbHelper.insertIntoFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await dbHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await dbHelper.deleteFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
