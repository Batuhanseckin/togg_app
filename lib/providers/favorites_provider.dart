import 'package:flutter/material.dart';
import 'package:togg_app/core/managers/locale_manager.dart';
import 'package:togg_app/models/marker_model.dart';

class FavoritesProvider extends ChangeNotifier {
  FavoritesProvider();

  List<int> favoriteMarkers = [];

  init() {
    getFavoriteMarkes();
  }

  getFavoriteMarkes() {
    List<String> tempMarkers = LocaleManager.instance
        .getStringListValue(PreferencesKeys.favoriteMarkes);

    if (tempMarkers == null || tempMarkers.isEmpty) {
      return;
    }

    for (var element in tempMarkers) {
      favoriteMarkers.add(int.parse(element));
    }
  }

  void addFavorite(MarkerModel markerModel) {
    favoriteMarkers.add(markerModel.id);

    updateCacheFromFavoriteMarkers();

    notifyListeners();
  }

  updateCacheFromFavoriteMarkers() {
    LocaleManager.instance.remove(PreferencesKeys.favoriteMarkes);

    LocaleManager.instance.setStringListValue(
      PreferencesKeys.favoriteMarkes,
      favoriteMarkers.map((e) => e.toString()).toList(),
    );
  }

  void removeFavorite(MarkerModel markerModel) {
    favoriteMarkers.remove(markerModel.id);
    updateCacheFromFavoriteMarkers();
    notifyListeners();
  }
}
