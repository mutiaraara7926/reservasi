import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projek_ara/model/update_menu.dart';

class MenuService {
  static const String baseUrl = "http://appreservasi.mobileprojp.com/api";

  // UPDATE MENU
  static Future<UpdateMenu?> updateMenu({
    required int id,
    required String name,
    required String description,
    required int price,
    required String imageUrl,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/menus/$id");
      final response = await http.put(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "description": description,
          "price": price,
          "image_url": imageUrl,
        }),
      );

      if (response.statusCode == 200) {
        return updateMenuFromJson(response.body);
      } else {
        print("❌ Update gagal: ${response.body}");
        return null;
      }
    } catch (e) {
      print("❌ Error updateMenu: $e");
      return null;
    }
  }

  // DELETE MENU
  static Future<bool> deleteMenu(int id) async {
    try {
      final url = Uri.parse("$baseUrl/menus/$id");
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        return true;
      } else {
        print("❌ Delete gagal: ${response.body}");
        return false;
      }
    } catch (e) {
      print("❌ Error deleteMenu: $e");
      return false;
    }
  }
}
