// To parse this JSON data, do
//
//     final listMenuModel = listMenuModelFromJson(jsonString);

import 'dart:convert';

ListMenuModel listMenuModelFromJson(String str) =>
    ListMenuModel.fromJson(json.decode(str));

String listMenuModelToJson(ListMenuModel data) => json.encode(data.toJson());

class ListMenuModel {
  final String message;
  final List<Datum> data;

  ListMenuModel({required this.message, required this.data});

  factory ListMenuModel.fromJson(Map<String, dynamic> json) => ListMenuModel(
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  final int id;
  final String name;
  final String description;
  final String price;
  final String? imageUrl;

  Datum({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "image_url": imageUrl,
  };
}
