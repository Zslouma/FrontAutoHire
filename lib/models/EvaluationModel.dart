// To parse this JSON data, do
//
//     final evaluationModel = evaluationModelFromJson(jsonString);

import 'dart:convert';

EvaluationModel evaluationModelFromJson(String str) =>
    EvaluationModel.fromJson(json.decode(str));

String evaluationModelToJson(EvaluationModel data) =>
    json.encode(data.toJson());

class EvaluationModel {
  EvaluationModel({
    this.integrity,
    this.planification,
    this.ponctuality,
    this.innovation,
    this.motivation,
    this.amelioration,
    this.commentaire,
    this.employee,
    this.entreprise,
  });

  String integrity;
  String planification;
  String ponctuality;
  String innovation;
  String motivation;
  String amelioration;
  String commentaire;
  String employee;
  String entreprise;

  factory EvaluationModel.fromJson(Map<String, dynamic> json) =>
      EvaluationModel(
        integrity: json["integrity"],
        planification: json["planification"],
        ponctuality: json["ponctuality"],
        innovation: json["innovation"],
        motivation: json["motivation"],
        amelioration: json["amelioration"],
        commentaire: json["commentaire"],
        employee: json["employee"],
        entreprise: json["entreprise"],
      );

  get createdAt => null;

  Map<String, dynamic> toJson() => {
        "integrity": integrity,
        "planification": planification,
        "ponctuality": ponctuality,
        "innovation": innovation,
        "motivation": motivation,
        "amelioration": amelioration,
        "commentaire": commentaire,
        "employee": employee,
        "entreprise": entreprise,
      };
}
