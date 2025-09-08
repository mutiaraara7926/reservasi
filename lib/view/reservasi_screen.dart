import 'package:flutter/material.dart';
import 'package:projek_ara/api/list_menu_model.dart';

class ReservasiScreen extends StatefulWidget {
  final List<Datum> keranjang;

  const ReservasiScreen({super.key, required this.keranjang});

  @override
  State<ReservasiScreen> createState() => _ReservasiScreenState();
}

class _ReservasiScreenState extends State<ReservasiScreen> {
  TimeOfDay? selectedTime;
  TextEditingController notesController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Future<void> _pickTime() async {
    final TimeOfDay? pickerTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickerTime != null) {
      setState(() {
        selectedTime = pickerTime;
      });
    }
  }

  int get totalHarga {
    return widget.keranjang.fold(0, (sum, item) {
      final harga =
          int.tryParse(item.price.replaceAll(RegExp(r'[^0-9]'), "")) ?? 0;
      return sum + harga;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservasi"),
        backgroundColor: Colors.white,
      ),
      body: widget.keranjang.isEmpty
          ? const Center(child: Text("Keranjang kosong"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.keranjang.length,
                    itemBuilder: (context, index) {
                      final menu = widget.keranjang[index];
                      return Card(
                        color: const Color(0xff748873),
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

                  const SizedBox(height: 16),

                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: "Nama Reservasi",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Pilih Jam Reservasi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _pickTime,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff798645),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Atur Waktu"),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        selectedTime == null
                            ? "Belum dipilih"
                            : "${selectedTime!.hour.toString().padLeft(2, '0')} : ${selectedTime!.minute.toString().padLeft(2, '0')}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: notesController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Catatan untuk reservasi",
                      hintText: "Contoh: Tolong siapkan meja dekat jendela",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff798645),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        if (nameController.text.isEmpty ||
                            selectedTime == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                "Isi nama dan pilih waktu reservasi",
                              ),
                            ),
                          );
                          return;
                        }

                        showDialog(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text("Konfirmasi Reservasi"),
                            content: Text(
                              "Nama: ${nameController.text}\n"
                              "Jam: ${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}\n"
                              "Total: Rp$totalHarga\n"
                              "Catatan: ${notesController.text.isEmpty ? '-' : notesController.text}",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx),
                                child: const Text("Batal"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Reservasi berhasil!"),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff798645),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text("Konfirmasi"),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text("Reservasi Sekarang"),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
