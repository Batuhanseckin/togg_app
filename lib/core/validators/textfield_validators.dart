import 'package:togg_app/generated/easy_localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class TextFieldValidators {
  static TextFieldValidators _instance;
  TextFieldValidators._();
  static TextFieldValidators get instance =>
      _instance ??= TextFieldValidators._();

  String isEmpty(String value) {
    return (value == null || value.isEmpty)
        ? LocaleKeys.thisFieldCannotBeLeftBlank.tr()
        : null;
  }
}
