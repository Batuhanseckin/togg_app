import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;
void main() {
  test("is recording user events in development mode", () {
    dotenv.testLoad(fileInput: """BASE_URL=https://api.jsonbin.io/b/
USER_EVENTS=false""");
    bool userEvent = dotenv.env['USER_EVENTS'] == "true";
    expect(userEvent, false);
  });

  test("is recording user events in stage mode", () {
    dotenv.testLoad(fileInput: """BASE_URL=https://api.jsonbin.io/b/
USER_EVENTS=true""");
    bool userEvent = dotenv.env['USER_EVENTS'] == "true";
    expect(userEvent, true);
  });

  test("is recording user events in production mode", () {
    dotenv.testLoad(fileInput: """BASE_URL=https://api.jsonbin.io/b/
USER_EVENTS=true""");
    bool userEvent = dotenv.env['USER_EVENTS'] == "true";
    expect(userEvent, true);
  });
}
