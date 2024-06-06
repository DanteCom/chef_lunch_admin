import 'dart:io';

import 'package:chef_lanch_admin/models/menu_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MenuProvider extends ChangeNotifier {
  final menu = FirebaseFirestore.instance.collection('menu');
  Future<String> uploadFile(XFile? file) async {
    final fileName = file!.path.split('/').last;
    final time = DateTime.now().microsecondsSinceEpoch;
    final storage = FirebaseStorage.instance.ref('/$time-$fileName');

    try {
      await storage.putFile(File(file.path));
    } catch (e) {
      debugPrint(e.toString());
    }
    return storage.getDownloadURL();
  }

  void addMenu(String id, String name, int price, String image) {
    menu.add(
      MenuModel(
        id: id,
        name: name,
        price: price,
        image: image,
      ).toJson(),
    );
  }
}
