import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extensions.dart';
import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';

import '../../../core/widgets/custom_network_widget.dart'
    show CustomNetworkWidget;

class ProductListCard extends StatelessWidget {
  final ProductModel productModel;

  const ProductListCard({super.key, required this.productModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.blueGrey,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Center(
                  child: CustomNetworkWidget(
                    imageUrl: productModel.images.isNotEmpty
                        ? productModel.images[0]
                        : '',
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text((productModel.title ?? '').capitalizeFirst()),
                  Text('\$${productModel.price}'),
                ],
              ).withPadding(EdgeInsets.only(left: 8, top: 5)),
            ],
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.add, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
