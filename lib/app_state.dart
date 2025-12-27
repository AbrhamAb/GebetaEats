import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/order_data.dart';
import 'models/order_status.dart';

class AppState extends ChangeNotifier {
  final List<OrderData> _orders = [];

  List<OrderData> get orders => _orders;

  AppState() {
    _loadOrders();
  }

  // 🛒 PLACE ORDER
  void placeOrder(OrderData order) {
    _orders.add(order);
    _saveOrders();
    notifyListeners();
    _startOrderFlow(order);
  }

  // ⏳ ORDER STATUS FLOW
  void _startOrderFlow(OrderData order) async {
    await Future.delayed(const Duration(seconds: 3));
    order.status = OrderStatus.preparing;
    _saveOrders();
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));
    order.status = OrderStatus.onTheWay;
    _saveOrders();
    notifyListeners();

    await Future.delayed(const Duration(seconds: 3));
    order.status = OrderStatus.delivered;
    _saveOrders();
    notifyListeners();
  }

  // 💾 SAVE ORDERS LOCALLY
  Future<void> _saveOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = _orders.map((o) => jsonEncode(o.toJson())).toList();
    await prefs.setStringList('orders', encoded);
  }

  // 📥 LOAD ORDERS LOCALLY
  Future<void> _loadOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('orders') ?? [];

    _orders.clear();
    _orders.addAll(
      saved.map((e) => OrderData.fromJson(jsonDecode(e))),
    );

    notifyListeners();
  }
}

class AppStateScope extends InheritedNotifier<AppState> {
  const AppStateScope({
    super.key,
    required super.notifier,
    required Widget child,
  }) : super(child: child);

  static AppState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<AppStateScope>()!
        .notifier!;
  }
}
