import 'package:chef_lanch_admin/components/my_menu_card.dart';
import 'package:chef_lanch_admin/pages/add_menu_page.dart';
import 'package:chef_lanch_admin/pages/menu_page.dart';
import 'package:chef_lanch_admin/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenusPage extends StatefulWidget {
  const MenusPage({super.key});

  @override
  State<MenusPage> createState() => _MenusPageState();
}

class _MenusPageState extends State<MenusPage> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<HomeProvider>();
    final foodList = state.menuList;
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        centerTitle: true,
        title: const Text(
          'Menus',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : foodList.isEmpty
              ? const Text(
                  'No Foods available',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                )
              : ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  itemCount: foodList.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemBuilder: (context, index) => MyMenuCard(
                    foodInfo: foodList[index],
                    onTab: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MenuPage(index: index),
                        ),
                      );
                    },
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddMenuPage(),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
