// To parse this JSON data, do
//
//     final updateMenu = updateMenuFromJson(jsonString);

import 'dart:convert';

UpdateMenu updateMenuFromJson(String str) =>
    UpdateMenu.fromJson(json.decode(str));

String updateMenuToJson(UpdateMenu data) => json.encode(data.toJson());

class UpdateMenu {
  String? message;
  Data? data;

  UpdateMenu({this.message, this.data});

  factory UpdateMenu.fromJson(Map<String, dynamic> json) => UpdateMenu(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class Data {
  int? id;
  String? name;
  String? description;
  int? price;
  String? imageUrl;

  Data({this.id, this.name, this.description, this.price, this.imageUrl});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
