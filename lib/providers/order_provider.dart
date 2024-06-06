import 'package:chef_lanch_admin/models/order_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrderProvider extends ChangeNotifier {
  final orders = FirebaseFirestore.instance.collection('orders');

  OrderProvider() {
    init();
  }

  bool isLoading = false;
  List<OrderModel> orderList = [];
  List<OrderModel> newOrderList = [];
  List<OrderModel> completeOrderList = [];
  void deleteOrder(OrderModel order) {
    orders.doc(order.orderId).delete();
  }

  // void updateOrder(OrderModel newOrderItems) {
  //   OrderModel newOrder = OrderModel(
  //     foodInfo: newOrderItems.foodInfo,
  //     userId: newOrderItems.userId,
  //     location: newOrderItems.location,
  //     phone: newOrderItems.phone,
  //     data: newOrderItems.data,
  //     totalPrice: newOrderItems.totalPrice,
  //   );
  //   orders.doc(newOrderItems.orderId).set(newOrder.toJson());
  // }

  Future<void> getFoods({bool isInit = false}) async {
    if (isInit) {
      isLoading = true;
      notifyListeners();
    }
    try {
      final foods = await orders.get();
      orderList = foods.docs.map(
        (DocumentSnapshot document) {
          final data = document.data() as Map<String, dynamic>;
          return OrderModel.fromJson(data, document.id);
        },
      ).toList();
      final formatter = DateFormat("yyyy-MM-dd – kk:mm");
      orderList.sort(
        (a, b) => formatter.parse(b.data).compareTo(formatter.parse(a.data)),
      );
      // newOrderList = orderList.where((e) => e.data == 'new').toList();
      // completeOrderList = orderList.where((e) => e.data == 'complete').toList();
    } catch (e) {
      debugPrint('$e');
    } finally {
      if (isInit) {
        await Future.delayed(
          const Duration(milliseconds: 400),
        );
        isLoading = false;
      }
      notifyListeners();
    }
  }

  void init() async {
    await getFoods(isInit: true);
    orders.snapshots().listen((event) {
      getFoods();
    });
  }
}
