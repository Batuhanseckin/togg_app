import 'package:flutter_test/flutter_test.dart';
import 'package:togg_app/core/managers/assets_manager.dart';

void main() async {
  test("asset manager test", () {
    String svgImagePath = AssetManager.instance.getSvgImage("svgImagePath");

    expect(svgImagePath, "assets/images/svg/svgImagePath.svg");
  });
}
