import 'package:pos/domain/entities/cart.dart';

class TransactionEntity{
  String id;
  String uid;
  String? customerName;
  CartEntity cart;
  TransactionStatus status;
  DateTime? createdAt;
  DateTime? updatedAt;

  TransactionEntity({
    required this.id,
    required this. cart,
    required this.uid,
    required this.status,
    this.createdAt,
    this.updatedAt,
    this.customerName
  });
}

class TransactionStatus {
  String id;
  String name;

  TransactionStatus({required this.id, required this.name});
}

List<TransactionStatus> transactionStatusMasterData = [
  TransactionStatus(id: '1', name: 'Pending'),
  TransactionStatus(id: '2', name: 'Processing'),
  TransactionStatus(id: '3', name: 'Completed'),
  TransactionStatus(id: '4', name: 'Cancelled'),
];
