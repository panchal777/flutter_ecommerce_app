import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/routes/route_name.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extensions.dart';
import 'package:flutter_ecommerce_app/core/utils/app_strings.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_search_bar.dart';
import 'package:flutter_ecommerce_app/features/presentation/components/category_widget.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/dashboard_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/product_list_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.dashboardTitle),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                context.pushNamed(RouteName.addToCart);
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              CustomSearchBar(
                onChanged: (value) {},
              ).withPadding(const EdgeInsets.all(10)),
              SizedBox(height: 10),
              CategoryWidget(),
              SizedBox(height: 10),
              Consumer<DashboardProvider>(
                builder: (context, value, child) {
                  return ProductListWidget(
                    isStateLoading: value.productsStateModel.isLoading,
                    productList: value.products,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
