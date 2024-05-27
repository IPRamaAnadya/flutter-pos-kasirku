import 'package:intl/intl.dart';

extension IndonesianRupiah on int {
  String toRupiah() {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return formatter.format(this);
  }
}