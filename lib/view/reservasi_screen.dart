import 'package:flutter/material.dart';
import 'package:projek_ara/model/list_menu_model.dart';

class ReservasiScreen extends StatelessWidget {
  final List<Datum> keranjang;

  const ReservasiScreen({super.key, required this.keranjang});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservasi"),
        backgroundColor: Colors.white,
      ),
      body: keranjang.isEmpty
          ? SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: const Center(child: Text("Keranjang kosong")),
              ),
            )
          : ListView.builder(
              itemCount: keranjang.length,
              itemBuilder: (context, index) {
                final menu = keranjang[index];
                return Card(
                  color: Color(0xff748873),
                  // color: Colors.transparent,
                  elevation: 4,
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(menu.name),
                    subtitle: Text("Rp ${menu.price}"),
                    trailing: const Icon(Icons.fastfood),
                  ),
                );
              },
            ),
    );
  }
}
