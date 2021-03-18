import 'dart:convert';

CompanyModel companyModelFromJson(String str) =>
    CompanyModel.fromJson(json.decode(str));

String companyModelToJson(CompanyModel data) => json.encode(data.toJson());

class CompanyModel {
  CompanyModel({
    this.nom,
    this.industry,
    this.about,
    this.adresse,
  });

  String nom;
  String industry;
  String about;
  String adresse;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        nom: json["nom"],
        industry: json["industry"],
        about: json["about"],
        adresse: json["adresse"],
      );

  get createdAt => null;

  Map<String, dynamic> toJson() => {
        "nom": nom,
        "industry": industry,
        "about": about,
        "adresse": adresse,
      };
}
