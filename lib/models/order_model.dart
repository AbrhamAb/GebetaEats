class OrderModel {
  OrderModel({
    required this.id,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final List<CartSnapshotItem> items;
  final double total;
  String status;
  final DateTime createdAt;
}

/// This represents each cart item at checkout moment.
/// (So even if price later changes, order keeps original snapshot)
class CartSnapshotItem {
  CartSnapshotItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  final String id;
  final String name;
  final int quantity;
  final double price;
}
