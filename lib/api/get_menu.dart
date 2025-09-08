import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projek_ara/api/list_menu_model.dart';
import 'package:projek_ara/shared_preference/shared_preference.dart';

Future<List<Datum>> getMenu() async {
  final token = await PreferenceHandler.getToken();

  try {
    final response = await http.get(
      Uri.parse("http://appreservasi.mobileprojp.com/api/menus"),
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
    );
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final listMenu = ListMenuModel.fromJson(jsonData);
      return listMenu.data;
    } else {
      throw Exception("Gagal load menu: ${response.statusCode}");
    }
  } catch (e) {
    print("Error getMenu: $e");
    return [];
  }
}
