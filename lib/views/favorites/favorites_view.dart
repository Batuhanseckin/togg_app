import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:togg_app/core/locator.dart';
import 'package:togg_app/core/managers/analytics_manager.dart';
import 'package:togg_app/generated/easy_localization/locale_keys.g.dart';
import 'package:togg_app/providers/favorites_provider.dart';
import 'package:togg_app/widgets/card/marker_widget.dart';
import 'favorites_view_model.dart';

class FavoritesView extends StatefulWidget {
  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  FavoritesViewModel favoritesViewModel;

  Widget get _buildBackButton => SizedBox(
        width: 1.sw,
        height: 60.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFF18C1E8),
          ),
          onPressed: () async {
            Navigator.pop(context);
            await locator<AnalyticsManager>().logOnTapBackToMapButton();
          },
          child: Text(
            LocaleKeys.backToMap.tr(),
            style: TextStyle(
              fontSize: 16.sp,
            ),
          ),
        ),
      );

  Widget get _buildMarkers => Expanded(
        child: ListView.separated(
          padding: EdgeInsets.all(10),
          itemBuilder: (context, index) => _buildMarker(context, index),
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemCount:
              favoritesViewModel.favoritesProvider.favoriteMarkers.length,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FavoritesViewModel>.reactive(
      builder: (BuildContext context, FavoritesViewModel viewModel, Widget _) {
        favoritesViewModel = viewModel;
        return Scaffold(
          appBar: AppBar(
            leading: Container(),
            backgroundColor: const Color(0xFF18C1E8),
            title: Text(LocaleKeys.favourities.tr()),
            centerTitle: true,
          ),
          body: _buildBody,
        );
      },
      viewModelBuilder: () => FavoritesViewModel(),
      onModelReady: (model) async {
        model.favoritesProvider = Provider.of<FavoritesProvider>(context);
        await model.getMarkers();
        locator<AnalyticsManager>().logFavouritiesPage();
      },
    );
  }

  Widget get _buildLoading => const Expanded(
        child: Center(child: CircularProgressIndicator()),
      );

  Widget get _buildBody => Column(
        children: [
          favoritesViewModel.gettingMarkers ? _buildLoading : _buildMarkers,
          _buildBackButton,
        ],
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
