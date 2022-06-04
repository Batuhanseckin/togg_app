import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:togg_app/models/marker_model.dart';

class AnalyticsManager {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: analytics);

  Future setUser(String token) async {
    await analytics.setUserId(id: token);
  }

  Future logLogin() async {
    await analytics.logLogin(
      loginMethod: "username",
    );
  }

  Future logOnTapMarker(MarkerModel markerModel) async {
    await analytics.logEvent(
      name: "logOnTapMarker",
      parameters: markerModel.toJson(),
    );
  }

  Future logAddFavoriteMarker(MarkerModel markerModel) async {
    await analytics.logEvent(
      name: "logAddFavoriteMarker",
      parameters: markerModel.toJson(),
    );
  }

  Future logRemoveFavoriteMarker(MarkerModel markerModel) async {
    await analytics.logEvent(
      name: "logRemoveFavoriteMarker",
      parameters: markerModel.toJson(),
    );
  }

  Future logOnTapFavouritiesButton() async {
    await analytics.logEvent(
      name: "logOnTapFacouritiesButton",
    );
  }

  Future logFavouritiesPage() async {
    await analytics.logEvent(
      name: "logFavouritiesPage",
    );
  }

  Future logOnTapBackToMapButton() async {
    await analytics.logEvent(
      name: "logOnTapBackToMapButton",
    );
  }
}
