import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:togg_app/models/marker_model.dart';

class AnalyticsManager {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: analytics);

  bool userEvent = dotenv.env['USER_EVENTS'] == "true";

  Future setUser(String token) async {
    if (userEvent) {
      await analytics.setUserId(id: token);
    }
  }

  Future<bool> logLogin() async {
    if (userEvent) {
      await analytics.logLogin(
        loginMethod: "username",
      );
      return true;
    } else {
      return false;
    }
  }

  Future logOnTapMarker(MarkerModel markerModel) async {
    if (userEvent) {
      await analytics.logEvent(
        name: "logOnTapMarker",
        parameters: markerModel.toJson(),
      );
    }
  }

  Future logAddFavoriteMarker(MarkerModel markerModel) async {
    if (userEvent) {
      await analytics.logEvent(
        name: "logAddFavoriteMarker",
        parameters: markerModel.toJson(),
      );
    }
  }

  Future logRemoveFavoriteMarker(MarkerModel markerModel) async {
    if (userEvent) {
      await analytics.logEvent(
        name: "logRemoveFavoriteMarker",
        parameters: markerModel.toJson(),
      );
    }
  }

  Future logOnTapFavouritiesButton() async {
    if (userEvent) {
      await analytics.logEvent(
        name: "logOnTapFacouritiesButton",
      );
    }
  }

  Future logFavouritiesPage() async {
    if (userEvent) {
      await analytics.logEvent(
        name: "logFavouritiesPage",
      );
    }
  }

  Future logOnTapBackToMapButton() async {
    if (userEvent) {
      await analytics.logEvent(
        name: "logOnTapBackToMapButton",
      );
    }
  }
}
