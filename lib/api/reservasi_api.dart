import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projek_ara/model/list_reservasi_model.dart';

class ReservasiService {
  static const String baseUrl = 'http://appreservasi.mobileprojp.com/api';

  static Future<bool> createReservasi({
    required String name,
    required DateTime reservedAt,
    required int guestCount,
    required String notes,
    required int totalHarga,
    required List<dynamic> items,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/reservations'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'reserved_at': reservedAt.toIso8601String(),
          'guest_count': guestCount,
          'notes': notes,
          'total_price': totalHarga,
          'items': items
              .map(
                (item) => {
                  'menu_id': item.id,
                  'quantity': 1,
                  'price': int.parse(
                    item.price.replaceAll(RegExp(r'[^0-9]'), ""),
                  ),
                },
              )
              .toList(),
        }),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Error creating reservation: $e');
      return false;
    }
  }

  static Future<ListReservasi> getReservasiList() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/reservations'));

      if (response.statusCode == 200) {
        return listReservasiFromJson(response.body);
      } else {
        throw Exception('Failed to load reservations');
      }
    } catch (e) {
      print('Error fetching reservations: $e');
      rethrow;
    }
  }
}
