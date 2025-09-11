import 'package:flutter/material.dart';
import 'package:projek_ara/model/list_menu_model.dart';

class DetailScreen extends StatelessWidget {
  final Datum menu;
  const DetailScreen({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu.name),
        backgroundColor: const Color.fromARGB(255, 82, 148, 121),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (menu.imageUrl != null)
              Center(
                child: Image.network(
                  menu.imageUrl!,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            Text(
              "Nama: ${menu.name}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text("Deskripsi: ${menu.description}"),
            const SizedBox(height: 10),
            Text(
              "Harga: Rp ${menu.price}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
