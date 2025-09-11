import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projek_ara/api/endpoint/endpoint.dart';
import 'package:projek_ara/model/delete_model.dart';
import 'package:projek_ara/model/list_menu_model.dart';
import 'package:projek_ara/model/list_reservasi_model.dart';
import 'package:projek_ara/shared_preference/shared_preference.dart';

class ReservasiService {
  static const String baseUrl = "http://appreservasi.mobileprojp.com/api";

  static Future<bool> createReservasi({
    required String name,
    required DateTime reservedAt,
    required int guestCount,
    required String notes,
    required int totalHarga,
    required List<Datum> items,
  }) async {
    try {
      final token = await PreferenceHandler.getToken();

      if (token == null) {
        print("Token tidak ditemukan");
        return false;
      }

      final url = Uri.parse("$baseUrl/reservations");
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "name": name,
          "reserved_at": reservedAt.toIso8601String(),
          "guest_count": guestCount,
          "notes": notes,
          "total_price": totalHarga,
          "items": items
              .map(
                (item) => {
                  "menu_id": item.id,
                  "quantity": 1,
                  "price": int.parse(
                    item.price.replaceAll(RegExp(r'[^0-9]'), ""),
                  ),
                },
              )
              .toList(),
        }),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        print("Create reservasi gagal: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Error createReservasi: $e");
      return false;
    }
  }

  static Future<ListReservasi> getReservasiList() async {
    try {
      final token = await PreferenceHandler.getToken();

      if (token == null) {
        throw Exception("Token tidak ditemukan");
      }

      final url = Uri.parse("$baseUrl/reservations");
      final response = await http.get(
        url,
        headers: {"Authorization": "Bearer $token"},
      );

      if (response.statusCode == 200) {
        return listReservasiFromJson(response.body);
      } else {
        throw Exception(
          "Gagal ambil data reservasi: ${response.statusCode} - ${response.body}",
        );
      }
    } catch (e) {
      throw Exception("Error getReservasiList: $e");
    }
  }

  static Future<DeleteModel> deleteCategory({
    required String name,
    required int id,
  }) async {
    final url = Uri.parse("${Endpoint.reservasi}/$id");
    final token = await PreferenceHandler.getToken();
    final response = await http.delete(
      url,
      body: {"name": name},
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200) {
      return DeleteModel.fromJson(json.decode(response.body));
    } else {
      final error = json.decode(response.body);
      throw Exception(error["message"] ?? "Register gagal");
    }
  }
}
