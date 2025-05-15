import 'package:flutter/foundation.dart';
import '../models/cat.dart';
import '../services/api_service.dart';

class CatProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  Cat? _currentCat;
  int _likes = 0;

  Cat? get currentCat => _currentCat;
  int get likes => _likes;

  Future<void> fetchNewCat() async {
    try {
      _currentCat = await _apiService.fetchRandomCat();
      notifyListeners();
    } catch (e) {
      throw Exception("Error fetching new cat: $e");
    }
  }

  void likeCat() {
    _likes++;
    fetchNewCat();
  }

  void dislikeCat() {
    fetchNewCat();
  }
}
