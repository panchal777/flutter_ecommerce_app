import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extensions.dart';
import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart' show Provider;

import '../../../core/routes/route_name.dart';
import '../../../core/widgets/custom_network_widget.dart'
    show CustomNetworkWidget;
import '../viewmodels/add_to_cart_provider.dart';

class ProductListCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductListCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        // color: Colors.blueGrey,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: CustomNetworkWidget(
                    imageUrl: productModel.images.isNotEmpty
                        ? productModel.images[0]
                        : '',
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (productModel.title ?? '').capitalizeFirst(),
                        textAlign: TextAlign.start,
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                        maxLines: 2,
                      ),
                      Text('\$${productModel.price}'),
                    ],
                  ).withPadding(EdgeInsets.only(left: 8, top: 8, right: 8)),
                ),
              ],
            ),
            Positioned(
              top: 1,
              right: 1,
              child: GestureDetector(
                onTap: () {
                  if (productModel.isSelected) {
                    removeFromCart(productModel, context);
                  } else {
                    addToCart(productModel, context);
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: productModel.isSelected
                        ? Colors.white
                        : Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    productModel.isSelected ? Icons.cancel_outlined : Icons.add,
                    size: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  addToCart(ProductModel model, BuildContext context) {
    var addToCartProvider = Provider.of<AddToCartProvider>(
      context,
      listen: false,
    );
    addToCartProvider.addItemToCart(model);
    context.pushNamed(RouteName.addToCart);
  }

  removeFromCart(ProductModel model, BuildContext context) {
    var addToCartProvider = Provider.of<AddToCartProvider>(
      context,
      listen: false,
    );
    addToCartProvider.removeItemFromCart(id: model.id!);
    context.pushNamed(RouteName.addToCart);
  }
}
