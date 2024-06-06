import 'package:chef_lanch_admin/components/order_card.dart';
import 'package:chef_lanch_admin/pages/order_page.dart';
import 'package:chef_lanch_admin/providers/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    final state = context.watch<OrderProvider>();

    return Scaffold(
      appBar: AppBar(
        elevation: 12,
        centerTitle: true,
        title: const Text(
          'Customers Orders',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.orderList.isEmpty
              ? const Center(
                  child: Text(
                    'No Orders',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                        itemCount: state.orderList.length,
                        itemBuilder: (context, index) => OrderCard(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderPage(
                                  location: state.orderList[index].location,
                                  phone: state.orderList[index].phone,
                                  orderList: state.orderList,
                                  index: index,
                                ),
                              ),
                            );
                          },
                          id: state.orderList[index].orderId ?? '1',
                          item: state.orderList[index].foodInfo.length,
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
