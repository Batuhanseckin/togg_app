import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:togg_app/api/map_service.dart';
import 'package:togg_app/core/logger.dart';
import 'package:togg_app/models/marker_model.dart';
import 'package:togg_app/providers/favorites_provider.dart';

class FavoritesViewModel extends BaseViewModel {
  Logger log;
  FavoritesProvider favoritesProvider;

  FavoritesViewModel() {
    log = getLogger(runtimeType.toString());
  }

  MarkerModel getFavoriteMarkerFromId(int id) {
    return markersOrigin.where((element) => element.id == id).first;
  }

  bool gettingMarkers = false;
  List<MarkerModel> markersOrigin = [];
  Future<void> getMarkers() async {
    try {
      gettingMarkers = true;
      notifyListeners();
      List markers = await MapService.instance.getAllMarkers();
      if (markers == null) {
        // show Error Message
      } else {
        markersOrigin = markers.map((e) => MarkerModel.fromJson(e)).toList();
      }
      gettingMarkers = false;
      notifyListeners();
    } catch (e) {
      gettingMarkers = false;
      notifyListeners();
      rethrow;
    }
  }
}
