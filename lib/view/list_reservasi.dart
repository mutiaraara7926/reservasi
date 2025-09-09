import 'package:flutter/material.dart';
// import 'package:projek_ara/api/list_reservasi_model.dart';
import 'package:projek_ara/api/reservasi_api.dart';
import 'package:projek_ara/model/list_reservasi_model.dart';
// import 'package:projek_ara/services/reservasi_service.dart';

class ListReservasiScreen extends StatefulWidget {
  const ListReservasiScreen({super.key});

  @override
  State<ListReservasiScreen> createState() => _ListReservasiScreenState();
}

class _ListReservasiScreenState extends State<ListReservasiScreen> {
  late Future<ListReservasi> futureReservasi;

  @override
  void initState() {
    super.initState();
    futureReservasi = ReservasiService.getReservasiList();
  }

  Future<void> _refreshReservasi() async {
    setState(() {
      futureReservasi = ReservasiService.getReservasiList();
    });
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '-';
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Reservasi"),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshReservasi,
          ),
        ],
      ),
      body: FutureBuilder<ListReservasi>(
        future: futureReservasi,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshReservasi,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData ||
              snapshot.data!.data == null ||
              snapshot.data!.data!.isEmpty) {
            return const Center(child: Text('Tidak ada reservasi'));
          }

          final reservasiList = snapshot.data!.data!;
          return RefreshIndicator(
            onRefresh: _refreshReservasi,
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reservasiList.length,
              itemBuilder: (context, index) {
                final reservasi = reservasiList[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Reservasi #${reservasi.id}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16),
                            const SizedBox(width: 8),
                            Text(_formatDateTime(reservasi.reservedAt)),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.people, size: 16),
                            const SizedBox(width: 8),
                            Text('${reservasi.guestCount} Tamu'),
                          ],
                        ),
                        if (reservasi.notes != null &&
                            reservasi.notes!.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(Icons.note, size: 16),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  reservasi.notes!,
                                  style: const TextStyle(
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                        const SizedBox(height: 8),
                        Text(
                          'Dibuat: ${_formatDateTime(reservasi.createdAt)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
