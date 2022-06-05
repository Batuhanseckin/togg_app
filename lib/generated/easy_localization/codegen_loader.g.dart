// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> tr_TR = {
  "login": "GİRİŞ YAP",
  "userName": "Kullanıcı Adı",
  "password": "Şifre",
  "thisFieldCannotBeLeftBlank": "Bu alan boş bırakılamaz",
  "logingIn": "GİRİŞ YAPILIYOR..",
  "open": "Açık",
  "close": "Kapalı",
  "favourities": "Favoriler",
  "webSite": "Web Sitesi",
  "backToMap": "Haritalara Dön"
};
static const Map<String,dynamic> en_US = {
  "login": "LOGIN",
  "userName": "User Name",
  "password": "Password",
  "thisFieldCannotBeLeftBlank": "This field cannot be left blank",
  "logingIn": "LOGGING IN..",
  "open": "Open",
  "close": "Close",
  "favourities": "Favourities",
  "webSite": "Web Site",
  "backToMap": "Back To Map"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"tr_TR": tr_TR, "en_US": en_US};
}
