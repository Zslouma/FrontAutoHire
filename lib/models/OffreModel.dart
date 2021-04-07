// To parse this JSON data, do
//
//     final offreModel = offreModelFromJson(jsonString);

import 'dart:convert';

OffreModel offreModelFromJson(String str) =>
    OffreModel.fromJson(json.decode(str));

String offreModelToJson(OffreModel data) => json.encode(data.toJson());

class OffreModel {
  OffreModel({
    this.titre,
    this.description,
    this.poste,
    this.address,
    this.creator,
    this.salary,
    this.type,
    this.jobTime,
    this.longitude,
    this.latitude,
    this.createdAt,
    this.updatedAt,
  });

  String titre;
  String description;
  String poste;
  String address;
  String creator;
  String salary;
  String type;
  String jobTime;
  String longitude;
  String latitude;
  String createdAt;
  String updatedAt;

  factory OffreModel.fromJson(Map<String, dynamic> json) => OffreModel(
        titre: json["titre"],
        description: json["description"],
        poste: json["poste"],
        address: json["address"],
        creator: json["creator"],
        salary: json["salary"],
        type: json["type"],
        jobTime: json["jobTime"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
      );

  Map<String, dynamic> toJson() => {
        "titre": titre,
        "description": description,
        "poste": poste,
        "address": address,
        "creator": creator,
        "salary": salary,
        "type": type,
        "jobTime": jobTime,
        "longitude": longitude,
        "latitude": latitude,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}
