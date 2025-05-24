import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/routes/route_name.dart';
import '../../../../core/utils/common.dart';
import '../../viewmodels/add_to_cart_provider.dart' show AddToCartProvider;

class CartAppBarIcon extends StatelessWidget {
  const CartAppBarIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddToCartProvider>(
      builder: (context, value, child) {
        int itemCount = value.addToCartList.length;

        return Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.shopping_cart, size: 28),
              onPressed: () {
                Common.hideKeyboard(context);
                context.pushNamed(RouteName.addToCart);
              },
            ),
            if (itemCount > 0)
              Positioned(
                right: 4,
                top: 1,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 15,
                    minHeight: 15,
                  ),
                  child: Text(
                    '$itemCount',
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
