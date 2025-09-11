import 'dart:convert';

ListReservasi listReservasiFromJson(String str) =>
    ListReservasi.fromJson(json.decode(str));

class ListReservasi {
  List<ReservasiData>? data;

  ListReservasi({this.data});

  factory ListReservasi.fromJson(Map<String, dynamic> json) => ListReservasi(
    data: json["data"] == null
        ? []
        : List<ReservasiData>.from(
            json["data"].map((x) => ReservasiData.fromJson(x)),
          ),
  );
}

class ReservasiData {
  int? id;
  String name;
  DateTime? reservedAt;
  int? guestCount;
  String? notes;
  DateTime? createdAt;

  ReservasiData({
    required this.id,
    required this.name,
    this.reservedAt,
    required this.guestCount,
    this.notes,
    this.createdAt,
  });

  factory ReservasiData.fromJson(Map<String, dynamic> json) => ReservasiData(
    id: int.tryParse(json["id"].toString()),
    name: json["name"] ?? "",
    reservedAt: json["reserved_at"] != null
        ? DateTime.tryParse(json["reserved_at"])
        : null,
    guestCount: int.tryParse(json["guest_count"].toString()),
    notes: json["notes"] ?? "",
    createdAt: json["created_at"] != null
        ? DateTime.tryParse(json["created_at"])
        : null,
  );
}
