import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:togg_app/core/locator.dart';
import 'package:togg_app/core/managers/analytics_manager.dart';
import 'package:togg_app/providers/favorites_provider.dart';
import 'package:togg_app/widgets/card/marker_widget.dart';
import 'map_view_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapView extends StatefulWidget {
  const MapView({Key key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  MapViewModel mapViewModel;
  GoogleMapController googleMapController;
  FavoritesProvider favoritesProvider;

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  CameraPosition get initialCameraPosition => const CameraPosition(
        target: LatLng(
          39.925152712704524,
          32.836997541820224,
        ),
        zoom: 16,
      );

  @override
  Widget build(BuildContext context) {
    favoritesProvider = Provider.of<FavoritesProvider>(context);
    return ViewModelBuilder<MapViewModel>.reactive(
      builder: (BuildContext context, MapViewModel viewModel, Widget _) {
        mapViewModel = viewModel;
        return Scaffold(
          body: _buildBody,
        );
      },
      viewModelBuilder: () => MapViewModel(),
      onModelReady: (model) async {
        await model.getMarkers();
        favoritesProvider.init();
        model.setMarkers();
      },
    );
  }

  Widget get _buildBody =>
      mapViewModel.gettingMarkers ? loadingPage : googleMapAndMarkerInfo;

  Widget get loadingPage => const Center(child: CircularProgressIndicator());
  Widget get googleMapAndMarkerInfo => mapViewModel.selectedMarkerId == null &&
          favoritesProvider.favoriteMarkers.isEmpty
      ? googleMap
      : Stack(
          alignment: Alignment.center,
          children: [
            googleMap,
            if (mapViewModel.selectedMarkerId != null) _buildMarkerInfo,
            if (favoritesProvider.favoriteMarkers.isNotEmpty)
              _buildFavoritesButton,
          ],
        );

  Widget get googleMap => GoogleMap(
        markers: mapViewModel.markers.values.toSet(),
        initialCameraPosition: initialCameraPosition,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        onMapCreated: (controller) => googleMapController = controller,
      );

  Widget get _buildFavoritesButton => Positioned(
        top: 50.h,
        right: 20.w,
        child: GestureDetector(
          onTap: () async {
            mapViewModel.nextFavorite();
            await locator<AnalyticsManager>().logOnTapFavouritiesButton();
          },
          child: Container(
            width: 120.w,
            height: 40.h,
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
            alignment: Alignment.center,
            child: Text(
              "Favourities",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );

  Widget get _buildMarkerInfo {
    return Positioned(
      bottom: 40.h,
      child: MarkerWidget(
        markerModel: mapViewModel.getMarkerById(mapViewModel.selectedMarkerId),
      ),
    );
  }
}
