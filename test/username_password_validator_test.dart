import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:togg_app/core/validators/textfield_validators.dart';
import 'package:togg_app/generated/easy_localization/locale_keys.g.dart';

void main() {
  //////////////////////////// NULL //////////////////////
  test("null username returns error string", () {
    var result = TextFieldValidators.instance.isEmpty(null);
    expect(result, LocaleKeys.thisFieldCannotBeLeftBlank.tr());
  });

  test("null password returns error string", () {
    var result = TextFieldValidators.instance.isEmpty(null);
    expect(result, LocaleKeys.thisFieldCannotBeLeftBlank.tr());
  });

  //////////////////////////// EMPTY //////////////////////
  test("empty username returns error string", () {
    var result = TextFieldValidators.instance.isEmpty("");
    expect(result, LocaleKeys.thisFieldCannotBeLeftBlank.tr());
  });

  test("empty password returns error string", () {
    var result = TextFieldValidators.instance.isEmpty("");
    expect(result, LocaleKeys.thisFieldCannotBeLeftBlank.tr());
  });

  //////////////////////////// NON-EMPTY //////////////////////
  test("non-empty username returns error string", () {
    var result = TextFieldValidators.instance.isEmpty("Test");
    expect(result, null);
  });

  test("empty password returns error string", () {
    var result = TextFieldValidators.instance.isEmpty("Togg");
    expect(result, null);
  });
}
