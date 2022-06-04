import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:togg_app/core/locator.dart';
import 'package:togg_app/core/managers/analytics_manager.dart';
import 'package:togg_app/models/marker_model.dart';
import 'package:togg_app/providers/favorites_provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MarkerWidget extends StatelessWidget {
  MarkerWidget({Key key, this.markerModel}) : super(key: key);
  final MarkerModel markerModel;
  FavoritesProvider favoritesProvider;

  @override
  Widget build(BuildContext context) {
    favoritesProvider = Provider.of<FavoritesProvider>(context);
    return Container(
      width: 1.sw - 40.w,
      height: 120.h,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 2),
            color: Colors.black26,
            blurRadius: 6,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMarkerInfoLeftSide(),
          _buildMarkerInfoFavoriteIcon(),
        ],
      ),
    );
  }

  Widget _buildMarkerInfoFavoriteIcon() {
    bool isFavoriteMarker =
        favoritesProvider.favoriteMarkers.contains(markerModel.id);
    return GestureDetector(
      onTap: () async {
        if (isFavoriteMarker) {
          favoritesProvider.removeFavorite(markerModel);
          await locator<AnalyticsManager>()
              .logRemoveFavoriteMarker(markerModel);
        } else {
          favoritesProvider.addFavorite(markerModel);
          await locator<AnalyticsManager>().logAddFavoriteMarker(markerModel);
        }
      },
      child: Icon(
        isFavoriteMarker ? Icons.star : Icons.star_border,
        size: 35.sp,
        color: Colors.orange,
      ),
    );
  }

  Widget _buildMarkerInfoLeftSide() {
    return SizedBox(
      width: 1.sw - 120.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildMarkerInfoName(),
          SizedBox(height: 8.h),
          _buildMarkerInfoWebSiteAndOpen(),
        ],
      ),
    );
  }

  Widget _buildMarkerInfoWebSiteAndOpen() {
    return Row(
      children: [
        if (markerModel.website != null) _buildMarkerInfoWeb(markerModel),
        if (markerModel.website != null) SizedBox(width: 15.w),
        _buildMarkerInfoIsOpen(markerModel),
      ],
    );
  }

  Widget _buildMarkerInfoIsOpen(MarkerModel markerModel) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: markerModel.openNow
            ? Colors.lightGreen.withOpacity(.8)
            : Colors.red,
      ),
      child: Text(
        markerModel.openNow ? "Open" : "Close",
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMarkerInfoWeb(MarkerModel markerModel) {
    return GestureDetector(
      onTap: () async {
        try {
          await launchUrlString(markerModel.website);
        } catch (e) {
          rethrow;
        }
      },
      child: Text(
        "website",
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildMarkerInfoName() {
    return Text(
      markerModel.name,
      maxLines: 2,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        fontSize: 16.sp,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
