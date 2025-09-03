// To parse this JSON data, do
//
//     final creatReservasi = creatReservasiFromJson(jsonString);

import 'dart:convert';

CreatReservasi creatReservasiFromJson(String str) =>
    CreatReservasi.fromJson(json.decode(str));

String creatReservasiToJson(CreatReservasi data) => json.encode(data.toJson());

class CreatReservasi {
  String? message;
  Data? data;

  CreatReservasi({this.message, this.data});

  factory CreatReservasi.fromJson(Map<String, dynamic> json) => CreatReservasi(
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {"message": message, "data": data?.toJson()};
}

class Data {
  DateTime? reservedAt;
  int? guestCount;
  String? notes;
  int? userId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.reservedAt,
    this.guestCount,
    this.notes,
    this.userId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    reservedAt: json["reserved_at"] == null
        ? null
        : DateTime.parse(json["reserved_at"]),
    guestCount: json["guest_count"],
    notes: json["notes"],
    userId: json["user_id"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "reserved_at": reservedAt?.toIso8601String(),
    "guest_count": guestCount,
    "notes": notes,
    "user_id": userId,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
