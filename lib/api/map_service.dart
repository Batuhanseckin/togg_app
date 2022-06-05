import 'package:togg_app/core/constants/api_constants.dart';
import 'package:togg_app/core/managers/api_network_manager.dart';

class MapService {
  static MapService _instance;
  MapService._();
  static MapService get instance => _instance ??= MapService._();

  var apiNetwork = ApiNetworkManager.instance.dio;

  Future<List> getAllMarkers() async {
    try {
      var response = await apiNetwork.get(
        ApiConstants.getAllMapPointers,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }
}
