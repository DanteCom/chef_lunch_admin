import 'package:chef_lanch_admin/models/cart_model.dart';

class OrderModel {
  final List<CartModel> foodInfo;
  final String userId;
  final String location;
  final String phone;
  final String data;
  final int totalPrice;
  String token;
  String? orderId;

  OrderModel(
      {this.orderId,
      required this.foodInfo,
      required this.userId,
      required this.location,
      required this.phone,
      required this.data,
      required this.totalPrice,
      required this.token});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'foodInfo': foodInfo.map((x) => x.toJson()).toList(),
      'userId': userId,
      'location': location,
      'phone': phone,
      'data': data,
      'totalPrice': totalPrice,
      'token': token
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> map, String orderId) {
    return OrderModel(
        foodInfo: List<CartModel>.from(
          (map['foodInfo'] as List<dynamic>).map<CartModel>(
            (x) => CartModel.fromJson(x as Map<String, dynamic>),
          ),
        ),
        orderId: orderId,
        userId: map['userId'] as String,
        location: map['location'] as String,
        phone: map['phone'] as String,
        data: map['data'] as String,
        totalPrice: map['totalPrice'] as int,
        token: map['token'] as String);
  }
}
