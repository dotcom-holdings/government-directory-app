import 'dart:convert';

class GovCategory{
  String id;
  String name;

  GovCategory(
    {
      this.id,
      this.name
    }
  );

  factory GovCategory.fromjson(Map<String, dynamic> json) => new GovCategory(
    id: json['id'],
    name: json['name'],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name
  };
}