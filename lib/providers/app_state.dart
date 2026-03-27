import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  String _language = 'en';
  int _currentTabIndex = 0;
  bool _onboardingComplete = false;
  Set<String> _favoriteBusinesses = {};
  Set<String> _favoriteEvents = {};
  Set<String> _favoriteRecipes = {};
  Set<String> _favoriteStations = {};

  String get language => _language;
  int get currentTabIndex => _currentTabIndex;
  bool get onboardingComplete => _onboardingComplete;
  Set<String> get favoriteBusinesses => _favoriteBusinesses;
  Set<String> get favoriteEvents => _favoriteEvents;
  Set<String> get favoriteRecipes => _favoriteRecipes;
  Set<String> get favoriteStations => _favoriteStations;

  void setLanguage(String lang) {
    _language = lang;
    notifyListeners();
  }

  void setTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  void completeOnboarding() {
    _onboardingComplete = true;
    notifyListeners();
  }

  void toggleFavoriteBusiness(String id) {
    if (_favoriteBusinesses.contains(id)) {
      _favoriteBusinesses.remove(id);
    } else {
      _favoriteBusinesses.add(id);
    }
    notifyListeners();
  }

  void toggleFavoriteEvent(String id) {
    if (_favoriteEvents.contains(id)) {
      _favoriteEvents.remove(id);
    } else {
      _favoriteEvents.add(id);
    }
    notifyListeners();
  }

  void toggleFavoriteRecipe(String id) {
    if (_favoriteRecipes.contains(id)) {
      _favoriteRecipes.remove(id);
    } else {
      _favoriteRecipes.add(id);
    }
    notifyListeners();
  }

  void toggleFavoriteStation(String id) {
    if (_favoriteStations.contains(id)) {
      _favoriteStations.remove(id);
    } else {
      _favoriteStations.add(id);
    }
    notifyListeners();
  }

  // Localization helper
  String tr(String en, String mk) => _language == 'mk' ? mk : en;
}
