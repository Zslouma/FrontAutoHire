import 'dart:convert';

TestModel testModelFromJson(String str) => TestModel.fromJson(json.decode(str));

String testModelToJson(TestModel data) => json.encode(data.toJson());

class TestModel {
  TestModel({
    this.question,
    this.reponse,
    this.sujet,
  });

  String question;
  String reponse;
  String sujet;

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        question: json["question"],
        reponse: json["reponse"],
        sujet: json["sujet"],
      );

  get createdAt => null;

  Map<String, dynamic> toJson() => {
        "question": question,
        "reponse": reponse,
        "sujet": sujet,
      };
}
