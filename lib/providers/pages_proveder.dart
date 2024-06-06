import 'package:chef_lanch_admin/main.dart';
import 'package:chef_lanch_admin/pages/connection_page.dart';
import 'package:chef_lanch_admin/pages/orders_page.dart';
import 'package:chef_lanch_admin/pages/menus_page.dart';
import 'package:flutter/material.dart';

class PagesProvider extends StatefulWidget {
  const PagesProvider({super.key});

  @override
  State<PagesProvider> createState() => _HomePageState();
}

class _HomePageState extends State<PagesProvider> {
  List<Widget> pagesList = [
    const OrdersPage(),
    const MenusPage(),
  ];
  int currentIndex = 0;
  void chengePage(int newIndex) {
    currentIndex = newIndex;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isDeviceConnected,
        builder: (context, hasConnection, child) {
          if (!hasConnection) {
            return const ConnectionPage();
          }
          return Scaffold(
            body: pagesList.elementAt(currentIndex),
            bottomNavigationBar: NavigationBar(
              indicatorColor: Theme.of(context).colorScheme.inversePrimary,
              onDestinationSelected: chengePage,
              selectedIndex: currentIndex,
              destinations: const [
                NavigationDestination(
                  label: 'Orders',
                  icon: Icon(Icons.info),
                ),
                NavigationDestination(
                  label: 'Home',
                  icon: Icon(Icons.home),
                ),
              ],
            ),
          );
        });
  }
}
