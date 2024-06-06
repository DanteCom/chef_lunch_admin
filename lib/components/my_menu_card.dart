import 'package:chef_lanch_admin/models/menu_model.dart';
import 'package:flutter/material.dart';

class MyMenuCard extends StatelessWidget {
  final MenuModel foodInfo;
  final void Function()? onTab;
  const MyMenuCard({
    super.key,
    required this.foodInfo,
    required this.onTab,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 256,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inversePrimary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Image.network(
              foodInfo.image,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    foodInfo.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    '\$${foodInfo.price}',
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
    );
  }
}
