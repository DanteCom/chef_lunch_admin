import 'dart:io';
import 'package:chef_lanch_admin/components/my_text_filed.dart';
import 'package:chef_lanch_admin/providers/home_provider.dart';
import 'package:chef_lanch_admin/providers/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddMenuPage extends StatefulWidget {
  const AddMenuPage({super.key});

  @override
  State<AddMenuPage> createState() => _AddMenuPageState();
}

class _AddMenuPageState extends State<AddMenuPage> {
  final nameController = TextEditingController();
  final idController = TextEditingController();
  final priceController = TextEditingController();
  XFile? selectedImage;
  bool image = false;
  bool name = false;
  bool price = false;
  bool isId = true;
  bool isIds = true;
  bool? valueText;
  String nameText = 'name';
  String priceText = '\$0';
  @override
  Widget build(BuildContext context) {
    final stateHome = context.watch<HomeProvider>();
    final stateMenu = context.watch<MenuProvider>();
    Future pickImage() async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        return selectedImage = image;
      }
    }

    void testName() {
      name = false;
      if (nameController.text.isEmpty) {
        name = true;
      }
      setState(() {});
    }

    void testImage() {
      image = false;
      if (selectedImage == null) {
        image = true;
      }
      setState(() {});
    }

    void testPrice() {
      price = false;
      if (priceController.text.isEmpty) {
        price = true;
      }
      setState(() {});
    }

    void testIds() async {
      isId = true;
      if (idController.text.isEmpty) {
        isId = false;
      }
      if (idController.text.isNotEmpty) {
        final id = idController.text.trim();
        for (var result in stateHome.menuList) {
          if (result.id == id) {
            isIds = false;
            return;
          }
        }
      }
      setState(() {});
    }

    String? hasError() {
      if (valueText == false) {
        return 'Please add id';
      }
      if (isIds == false) {
        return 'Current id';
      }
      if (valueText == true && isIds == true) {
        return 'Tori';
      } else {
        return null;
      }
    }

    void addToMenu() async {
      testName();
      testPrice();
      testImage();
      testIds();
      if (isId != false &&
          name == false &&
          price == false &&
          selectedImage != null) {
        if (isIds == true) {
          Navigator.pop(context);
          try {
            final result = await stateMenu.uploadFile(selectedImage);
            stateMenu.addMenu(
              idController.text.trim(),
              nameController.text,
              int.parse(priceController.text),
              result,
            );
          } catch (e) {
            debugPrint(e.toString());
          }
          selectedImage = null;
          isIds = false;
          nameController.clear();
          priceController.clear();
          idController.clear();
        }
      }
    }

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: 256,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async {
                          selectedImage = await pickImage();
                          //  await getImageFromGallery();
                          if (selectedImage != null) {
                            image = false;
                          }

                          setState(() {});
                        },
                        child: Container(
                          decoration: const BoxDecoration(color: Colors.grey),
                          height: 200,
                          width: double.infinity,
                          child: selectedImage != null
                              ? Image.file(
                                  File(selectedImage!.path),
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.image),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              nameText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              priceText,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: image ? 5 : 0),
                Text(
                  image ? 'Please add Image' : '',
                  style: TextStyle(color: Colors.red.shade700),
                ),
                const Spacer(),
                MyTextFiled(
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isId
                          ? isIds
                              ? Colors.green
                              : Colors.red.shade700
                          : Colors.red.shade700,
                    ),
                  ),
                  onTab: (value) {
                    isIds = true;
                    if (value.isEmpty) {
                      isId = false;
                    } else {
                      isId = true;
                    }
                    if (value.isEmpty) {
                      valueText = false;
                    } else {
                      valueText = true;
                    }

                    final id = value.trim();
                    for (var result in stateHome.menuList) {
                      if (result.id == id) {
                        isIds = false;
                      }
                    }
                    setState(() {});
                  },
                  controller: idController,
                  hintText: 'id',
                  keyboardType: TextInputType.number,
                  hasError: isId ? hasError() : 'Please add id',
                  focusedColor: isId
                      ? isIds
                          ? Colors.green
                          : Colors.red.shade700
                      : Colors.red.shade700,
                  errorStyle: isId
                      ? isIds
                          ? const TextStyle(color: Colors.green)
                          : null
                      : null,
                ),
                const SizedBox(height: 20),
                MyTextFiled(
                  onTab: (value) {
                    if (value.isEmpty) {
                      name = true;
                    } else {
                      name = false;
                    }
                    if (value.isNotEmpty) {
                      nameText = value;
                    } else {
                      nameText = 'name';
                    }
                    setState(() {});
                  },
                  controller: nameController,
                  hintText: 'name',
                  hasError: name ? 'Please add name' : null,
                ),
                const SizedBox(height: 20),
                MyTextFiled(
                  keyboardType: TextInputType.number,
                  onTab: (value) {
                    if (value.isEmpty) {
                      price = true;
                    } else {
                      price = false;
                    }
                    if (value.isNotEmpty) {
                      priceText = '\$$value';
                    } else {
                      priceText = 'price';
                    }
                    setState(() {});
                  },
                  controller: priceController,
                  hintText: 'price',
                  hasError: price ? 'Please add price' : null,
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text('Cancle'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          addToMenu();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text('Save'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
