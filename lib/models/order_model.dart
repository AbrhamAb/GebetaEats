import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final String id;
  final double total;

  const OrderModel({required this.id, required this.total});

  @override
  List<Object?> get props => [id, total];
}
