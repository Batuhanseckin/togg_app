import 'package:flutter_test/flutter_test.dart';
import 'package:togg_app/models/marker_model.dart';

void main() {
  var markerModelJson = {
    "id": 1,
    "lat": "39.925152712704524",
    "lon": "32.836997541820224",
    "name": "Anıtkabir",
    "website": "https://www.anitkabir.tsk.tr/",
    "open_now": true
  };
  MarkerModel markerModel = MarkerModel.fromJson(markerModelJson);
  test("marker model id test", () => expect(markerModel.id, 1));

  test("marker model lat test",
      () => expect(markerModel.lat, "39.925152712704524"));

  test("marker model lon test",
      () => expect(markerModel.lon, "32.836997541820224"));

  test("marker model name test",
      () => expect(markerModel.name.isNotEmpty, true));

  test("marker model website test",
      () => expect(markerModel.website, "https://www.anitkabir.tsk.tr/"));
  test("marker model openNow test", () => expect(markerModel.openNow, true));
}
