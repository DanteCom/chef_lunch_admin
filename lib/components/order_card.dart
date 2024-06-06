import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderCard extends StatelessWidget {
  final VoidCallback onPressed;
  final String id;
  final int item;
  const OrderCard({
    super.key,
    required this.id,
    required this.item,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          width: 3,
          color: Theme.of(context).colorScheme.inversePrimary.withOpacity(.9),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/svgs/complete.svg',
                width: 50,
                height: 50,
                // ignore: deprecated_member_use
                color: Colors.green,
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: MediaQuery.of(context).size.width * .5,
                child: Text(
                  'ID- #$id',
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Spacer(),
              Text(
                'Items ($item)',
              ),
            ],
          ),
          const SizedBox(height: 13),
          SizedBox(
            width: double.infinity,
            child: GestureDetector(
              onTap: onPressed,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 23),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text('Show Order'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
