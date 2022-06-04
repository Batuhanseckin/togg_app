import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:togg_app/api/auth_service.dart';
import 'package:togg_app/core/logger.dart';
import 'package:togg_app/core/managers/api_network_manager.dart';
import 'package:togg_app/core/managers/locale_manager.dart';
import 'package:togg_app/core/router_constants.dart';

class LoginViewModel extends BaseViewModel {
  Logger log;

  LoginViewModel() {
    log = getLogger(runtimeType.toString());
  }

  TextEditingController nameController = TextEditingController(
    text: "Test",
  );
  TextEditingController passController = TextEditingController(
    text: "Togg",
  );
  final formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  bool obscureText = true;
  changeObscureText() {
    obscureText = !obscureText;
    notifyListeners();
  }

  bool loginFakeIsProcess = false;

  loginFake() async {
    // validators
    if (!formKey.currentState.validate()) {
      autovalidateMode = AutovalidateMode.always;
      notifyListeners();
      return;
    }

    loginFakeIsProcess = true;
    notifyListeners();

    // api request
    await Future.delayed(const Duration(seconds: 2));

    String token = "asklşdmaslkdmaskldmasklsdmaslkfma";

    // token set to cache
    LocaleManager.instance.setStringValue(
      PreferencesKeys.token,
      token,
    );

    // token set to api context
    ApiNetworkManager.instance.dio.options.headers["Authorization"] =
        "Bearer " + token;

    // Route
    nextMapPage();

    loginFakeIsProcess = false;
    notifyListeners();
  }

  bool loginIsProcess = false;
  login() async {
    if (!formKey.currentState.validate()) {
      autovalidateMode = AutovalidateMode.always;
      notifyListeners();
      return;
    }
    try {
      loginIsProcess = true;
      notifyListeners();
      var token = AuthService.instance.login(
        nameController.text,
        passController.text,
      );
      if (token == null) {
        // show Error Message
      } else {
        // Set Token
      }
      loginIsProcess = true;
      notifyListeners();
    } catch (e) {
      loginIsProcess = false;
      notifyListeners();
      rethrow;
    }
  }

  void nextMapPage() {
    NavigationService().pushNamedAndRemoveUntil(mapViewRoute);
  }
}
