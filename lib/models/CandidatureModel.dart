import 'dart:convert';

CandidatureModel candidatureModelFromJson(String str) =>
    CandidatureModel.fromJson(json.decode(str));

String candidatureModelToJson(CandidatureModel data) =>
    json.encode(data.toJson());

class CandidatureModel {
  CandidatureModel({
    this.ref,
    this.etat,
    this.date,
  });

  String ref;
  String etat;
  String date;

  factory CandidatureModel.fromJson(Map<String, dynamic> json) =>
      CandidatureModel(
        ref: json["ref"],
        etat: json["etat"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "ref": ref,
        "etat": etat,
        "date": date,
      };
}
