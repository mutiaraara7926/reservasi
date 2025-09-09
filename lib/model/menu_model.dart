import 'dart:convert';

MenuModel menuModelFromJson(String str) => MenuModel.fromJson(json.decode(str));

String menuModelToJson(MenuModel data) => json.encode(data.toJson());

class MenuModel {
  String? message;
  Data? data;

  MenuModel({this.message, this.data});

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
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
