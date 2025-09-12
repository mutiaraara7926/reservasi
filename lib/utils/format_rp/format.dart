import 'package:intl/intl.dart';

String formatRupiah(num number) {
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0, // bisa ubah ke 2 kalau mau ada sen
  );
  return formatter.format(number);
}
