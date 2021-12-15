import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:submission_ketiga/models/models.dart';
import 'package:submission_ketiga/services/service.dart';

import 'json_pasrsing_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  group('Fetch restaurant api', () {
    final resto = {
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
        {"id": "rqdv5juczeskfw1e867", "name": "Melting Pot", "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...", "pictureId": "14", "city": "Medan", "rating": 4.2},
        {"id": "s1knt6za9kkfw1e867", "name": "Kafe Kita", "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...", "pictureId": "25", "city": "Gorontalo", "rating": 4}
      ]
    };

    test('output adalah List restauran', () async {
      final api = ApiService();
      final client = MockClient();

      when(
        client.get(Uri.parse("https://restaurant-api.dicoding.dev/list")),
      ).thenAnswer((_) async => http.Response(jsonEncode(resto), 200));

      expect(await api.getRestaurantsList(client), isA<RestaurantList>());
    });
  });
}
