// To parse this JSON data, do
//
//     final markerModel = markerModelFromJson(jsonString);

import 'dart:convert';

MarkerModel markerModelFromJson(String str) => MarkerModel.fromJson(json.decode(str));

String markerModelToJson(MarkerModel data) => json.encode(data.toJson());

class MarkerModel {
    MarkerModel({
        this.id,
        this.lat,
        this.lon,
        this.name,
        this.openNow,
        this.website,
    });

    int id;
    String lat;
    String lon;
    String name;
    bool openNow;
    String website;

    MarkerModel copyWith({
        int id,
        String lat,
        String lon,
        String name,
        bool openNow,
        String website,
    }) => 
        MarkerModel(
            id: id ?? this.id,
            lat: lat ?? this.lat,
            lon: lon ?? this.lon,
            name: name ?? this.name,
            openNow: openNow ?? this.openNow,
            website: website ?? this.website,
        );

    factory MarkerModel.fromJson(Map<String, dynamic> json) => MarkerModel(
        id: json["id"] == null ? null : json["id"],
        lat: json["lat"] == null ? null : json["lat"],
        lon: json["lon"] == null ? null : json["lon"],
        name: json["name"] == null ? null : json["name"],
        openNow: json["open_now"] == null ? null : json["open_now"],
        website: json["website"] == null ? null : json["website"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "name": name == null ? null : name,
        "open_now": openNow == null ? null : openNow,
        "website": website == null ? null : website,
    };
}
