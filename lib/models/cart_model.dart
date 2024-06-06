import 'package:chef_lanch_admin/models/menu_model.dart';

class CartModel {
  MenuModel foodInfo;
  int quantity;
  CartModel({
    required this.foodInfo,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'foodInfo': foodInfo.toJson(),
      'quantity': quantity,
    };
  }

  factory CartModel.fromJson(Map<String, dynamic> map) {
    return CartModel(
      foodInfo: MenuModel.fromJson(map['foodInfo'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
    );
  }
}
