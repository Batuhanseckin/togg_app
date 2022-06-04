import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:togg_app/models/marker_model.dart';
import 'package:togg_app/providers/favorites_provider.dart';
import 'package:togg_app/widgets/card/marker_widget.dart';
import 'favorites_view_model.dart';

class FavoritesView extends StatefulWidget {
  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  FavoritesViewModel favoritesViewModel;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoritesViewModel>.reactive(
      builder: (BuildContext context, FavoritesViewModel viewModel, Widget _) {
        favoritesViewModel = viewModel;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF18C1E8),
            title: const Text("Favourities"),
            centerTitle: true,
          ),
          body: _buildBody,
        );
      },
      viewModelBuilder: () => FavoritesViewModel(),
      onModelReady: (model) async {
        model.favoritesProvider = Provider.of<FavoritesProvider>(context);
        await model.getMarkers();
      },
    );
  }

  Widget get _buildBody =>
      favoritesViewModel.gettingMarkers ? _buildLoading : _buildMarkers;

  Widget get _buildLoading => const Center(child: CircularProgressIndicator());

  Widget get _buildMarkers => Container(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          itemBuilder: (context, index) => _buildMarker(context, index),
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemCount:
              favoritesViewModel.favoritesProvider.favoriteMarkers.length,
        ),
      );

  Widget _buildMarker(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MarkerWidget(
        markerModel: favoritesViewModel.getFavoriteMarkerFromId(
          favoritesViewModel.favoritesProvider.favoriteMarkers[index],
        ),
      ),
    );
  }
}
