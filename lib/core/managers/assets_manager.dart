import 'package:togg_app/core/constants/app_constants.dart';

class AssetManager {
  static AssetManager _instance;

  AssetManager._();

  static AssetManager get instance => _instance ??= AssetManager._();

  String getSvgImage(String svgImagePath) {
    return AppConstants.svgAssetPath + svgImagePath + ".svg";
  }
}
