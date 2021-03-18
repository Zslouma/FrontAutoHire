import 'dart:convert';

AvisModel avisModelFromJson(String str) => AvisModel.fromJson(json.decode(str));

String avisModelToJson(AvisModel data) => json.encode(data.toJson());

class AvisModel {
  AvisModel({
    this.niveau,
    this.commentaire,
    this.entreprise,
    this.personne,
  });

  int niveau;
  String commentaire;
  String entreprise;
  String personne;

  factory AvisModel.fromJson(Map<String, dynamic> json) => AvisModel(
        niveau: json["niveau"],
        commentaire: json["commentaire"],
        entreprise: json["entreprise"],
        personne: json["personne"],
      );
  get createdAt => null;
  Map<String, dynamic> toJson() => {
        "niveau": niveau,
        "commentaire": commentaire,
        "entreprise": entreprise,
        "personne": personne,
      };
}
