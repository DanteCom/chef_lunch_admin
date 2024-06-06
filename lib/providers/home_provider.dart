import 'package:chef_lanch_admin/models/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  final menu = FirebaseFirestore.instance.collection('menu');
  HomeProvider() {
    init();
  }

  bool isLoading = false;

  List<MenuModel> menuList = [];

  Future<void> getFoods({bool isInit = false}) async {
    if (isInit) {
      isLoading = true;
      notifyListeners();
    }
    try {
      final foods = await menu.get();
      menuList = foods.docs.map(
        (DocumentSnapshot document) {
          Map<String, dynamic> data = document.data() as Map<String, dynamic>;
          return MenuModel.fromJson(data);
        },
      ).toList();
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
    menu.snapshots().listen((event) {
      getFoods();
    });
  }
}
