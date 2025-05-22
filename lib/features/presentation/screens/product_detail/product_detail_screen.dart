import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/routes/route_name.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extensions.dart';
import 'package:flutter_ecommerce_app/core/utils/app_strings.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_network_widget.dart';
import 'package:flutter_ecommerce_app/features/presentation/components/similar_list_widget.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/product_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/title_widget.dart';
import '../../../data/models/product_model.dart';
import '../../viewmodels/add_to_cart_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.productDetail)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            bindProductDetailsCard(),
            const SizedBox(height: 15),
            SimilarListWidget(),
          ],
        ),
      ),
    );
  }

  bindProductDetailsCard() {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        var productModel = value.productModel;
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Main Product Image
              AspectRatio(
                aspectRatio: 1.5,
                child: Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: CustomNetworkWidget(
                      imageUrl: productModel?.images[0],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Category, Add Button and Description
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (productModel?.category?.name ?? '').capitalizeFirst(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            (productModel?.title ?? '').capitalizeFirst(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (productModel.isSelected) {
                              removeFromCart(productModel, context);
                            } else {
                              addToCart(productModel, context);
                            }
                          },
                          child: Text(
                            productModel!.isSelected ? "Remove" : "Add",
                            style: TextStyle(
                              color: productModel.isSelected
                                  ? Colors.red
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    BodyWidget(
                      label: productModel.description ?? 'Description',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
