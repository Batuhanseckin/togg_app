import 'package:togg_app/core/constants/api_constants.dart';
import 'package:togg_app/core/managers/api_network_manager.dart';

class AuthService {
  static AuthService _instance;
  AuthService._();
  static AuthService get instance => _instance ??= AuthService._();

  var apiNetwork = ApiNetworkManager.instance.dio;
  Future<bool> login(String userName, String password) async {
    try {
      var data = {
        "UserName": userName,
        "Password": password,
      };
      var response = await apiNetwork.post(
        ApiConstants.loginEndPoint,
        data: data,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } catch (e) {}
  }
}
