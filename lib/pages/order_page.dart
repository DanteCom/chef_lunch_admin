import 'package:chef_lanch_admin/components/my_menu_card.dart';
import 'package:chef_lanch_admin/models/order_model.dart';
import 'package:chef_lanch_admin/pages/food_page.dart';
import 'package:chef_lanch_admin/providers/order_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderPage extends StatefulWidget {
  final List<OrderModel> orderList;
  final String location;
  final String phone;
  final int index;
  const OrderPage({
    super.key,
    required this.orderList,
    required this.index,
    required this.location,
    required this.phone,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrderProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        centerTitle: true,
        title: const Text(
          'Order',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
                  title: Column(
                    children: [
                      const Text(
                        'Are you sure you want to delete the order?',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: CupertinoButton(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 15,
                                vertical: 6,
                              ),
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              borderRadius: BorderRadius.circular(8),
                              child: const Text('Cancle'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: CupertinoButton(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 6,
                              ),
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              borderRadius: BorderRadius.circular(8),
                              child: const Text('Delete'),
                              onPressed: () {
                                Navigator.pop(context);
                                state.deleteOrder(
                                  state.orderList[widget.index],
                                );
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15)
                  .copyWith(bottom: 0),
              itemBuilder: (context, index) => MyMenuCard(
                foodInfo:
                    widget.orderList[widget.index].foodInfo[index].foodInfo,
                onTab: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodPage(
                      foodInfo: widget.orderList[widget.index],
                      index: index,
                    ),
                  ),
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemCount: widget.orderList[widget.index].foodInfo.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => launchUrlString("tel://${widget.phone}"),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.phone_forwarded,
                              ),
                              Text(
                                'Call to User',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(width: 8),
                    Expanded(
                      child: GestureDetector(
                        onTap: widget.location == ""
                            ? () {
                                launchUrl(
                                  Uri.parse(
                                      'https://www.google.com/maps/search/?api=1&query=${widget.location}'),
                                );
                              }
                            : () => ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Location yoq'),
                                  ),
                                ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.inversePrimary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.map_rounded),
                              Text(
                                'Lets\'s to Map',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
