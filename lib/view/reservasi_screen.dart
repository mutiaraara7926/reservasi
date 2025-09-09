import 'package:flutter/material.dart';
import 'package:projek_ara/api/list_menu_model.dart';
import 'package:projek_ara/api/reservasi_api.dart';

class ReservasiScreen extends StatefulWidget {
  final List<Datum> keranjang;

  const ReservasiScreen({super.key, required this.keranjang});

  @override
  State<ReservasiScreen> createState() => _ReservasiScreenState();
}

class _ReservasiScreenState extends State<ReservasiScreen> {
  TimeOfDay? selectedTime;
  DateTime? selectedDate;
  TextEditingController notesController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController guestCountController = TextEditingController(text: '1');
  bool isLoading = false;

  Future<void> _pickTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Future<void> _pickDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
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

  Future<void> _submitReservasi() async {
    if (nameController.text.isEmpty ||
        selectedTime == null ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harap isi nama, pilih tanggal dan waktu reservasi"),
        ),
      );
      return;
    }

    final guestCount = int.tryParse(guestCountController.text) ?? 1;
    if (guestCount < 1) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Jumlah tamu minimal 1")));
      return;
    }

    final reservedAt = DateTime(
      selectedDate!.year,
      selectedDate!.month,
      selectedDate!.day,
      selectedTime!.hour,
      selectedTime!.minute,
    );

    setState(() {
      isLoading = true;
    });

    try {
      final success = await ReservasiService.createReservasi(
        name: nameController.text,
        reservedAt: reservedAt,
        guestCount: guestCount,
        notes: notesController.text,
        totalHarga: totalHarga,
        items: widget.keranjang,
      );

      setState(() {
        isLoading = false;
      });

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Reservasi berhasil dibuat!"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Gagal membuat reservasi. Silakan coba lagi."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  void _showConfirmationDialog() {
    if (nameController.text.isEmpty ||
        selectedTime == null ||
        selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Harap isi nama, pilih tanggal dan waktu reservasi"),
        ),
      );
      return;
    }

    final guestCount = int.tryParse(guestCountController.text) ?? 1;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Konfirmasi Reservasi"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Nama: ${nameController.text}"),
              Text("Jumlah Tamu: $guestCount"),
              Text(
                "Tanggal: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
              ),
              Text(
                "Jam: ${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}",
              ),
              Text("Total: Rp$totalHarga"),
              Text(
                "Catatan: ${notesController.text.isEmpty ? '-' : notesController.text}",
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              _submitReservasi();
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reservasi"),
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : widget.keranjang.isEmpty
          ? const Center(child: Text("Keranjang kosong"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Daftar Menu
                  const Text(
                    "Menu yang dipesan:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
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
                  const Divider(),

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

                  TextField(
                    controller: guestCountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Jumlah Tamu",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Pilih Tanggal Reservasi",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: _pickDate,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff798645),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Pilih Tanggal"),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        selectedDate == null
                            ? "Belum dipilih"
                            : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
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
                        child: const Text("Pilih Waktu"),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        selectedTime == null
                            ? "Belum dipilih"
                            : "${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}",
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

                  const SizedBox(height: 16),

                  Card(
                    color: Colors.grey[200],
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Harga:",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Rp$totalHarga",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: _showConfirmationDialog,
                      child: const Text(
                        "Reservasi Sekarang",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
