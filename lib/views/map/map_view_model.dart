import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:togg_app/api/map_service.dart';
import 'package:togg_app/core/locator.dart';
import 'package:togg_app/core/logger.dart';
import 'package:togg_app/core/managers/analytics_manager.dart';
import 'package:togg_app/core/router_constants.dart';
import 'package:togg_app/models/marker_model.dart';

class MapViewModel extends BaseViewModel {
  Logger log;

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  AnalyticsManager analyticsManager = locator<AnalyticsManager>();

  MapViewModel() {
    log = getLogger(runtimeType.toString());
  }

  int selectedMarkerId;

  setMarkers() {
    for (var element in markersOrigin) {
      markers[MarkerId(element.id.toString())] = Marker(
        markerId: MarkerId(element.id.toString()),
        position: LatLng(double.parse(element.lat), double.parse(element.lon)),
        onTap: () async {
          selectedMarkerId = element.id;
          notifyListeners();
          await analyticsManager.logOnTapMarker(getMarkerById(element.id));
        },
      );
      notifyListeners();
    }
  }

  MarkerModel getMarkerById(int id) {
    MarkerModel tempMarker;
    for (var element in markersOrigin) {
      if (element.id == id) {
        tempMarker = element;
      }
    }
    return tempMarker;
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

  nextFavorite() {
    NavigationService().navigateTo(favoritesViewRoute);
  }
}
