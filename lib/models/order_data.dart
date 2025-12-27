import 'order_status.dart';

class OrderData {
  final String id;
  final String restaurantName;
  final double totalPrice;
  OrderStatus status;

  OrderData({
    required this.id,
    required this.restaurantName,
    required this.totalPrice,
    this.status = OrderStatus.placed,
  });

  // 🔁 Convert to Map (save)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurantName': restaurantName,
      'totalPrice': totalPrice,
      'status': status.name,
    };
  }

  // 🔁 Convert from Map (load)
  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'],
      restaurantName: json['restaurantName'],
      totalPrice: json['totalPrice'],
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
      ),
    );
  }
}
