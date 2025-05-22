import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/app_strings.dart';
import 'package:flutter_ecommerce_app/features/presentation/components/add_to_cart/items_to_cart.dart';

import '../../components/add_to_cart/billing_details.dart';

class AddToCartScreen extends StatelessWidget {
  const AddToCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.addToCart)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              ItemsToCart(),
              SizedBox(height: 20),
              BillingDetailsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
