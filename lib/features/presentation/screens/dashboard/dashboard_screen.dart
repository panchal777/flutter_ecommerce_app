import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/routes/route_name.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extensions.dart';
import 'package:flutter_ecommerce_app/core/utils/app_strings.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_search_bar.dart';
import 'package:flutter_ecommerce_app/features/presentation/components/category_widget.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/add_to_cart_provider.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/dashboard_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/product_list_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ScrollController _parentScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<DashboardProvider>(context, listen: false);

    _parentScrollController.addListener(() {
      if (_parentScrollController.position.pixels >=
              _parentScrollController.position.maxScrollExtent &&
          !provider.productsStateModel.showProgress &&
          provider.p.hasMore) {
        provider.fetchMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _parentScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppStrings.dashboardTitle),
          actions: [
            Consumer<AddToCartProvider>(
              builder: (context, value, child) {
                int itemCount = value.addToCartList.length;

                return Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart,size: 28,),
                      onPressed: () {
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
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          controller: _parentScrollController,
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
              Consumer2<DashboardProvider, AddToCartProvider>(
                builder: (context, value, value2, child) {
                  return ProductListWidget(
                    isStateLoading: value.productsStateModel.isLoading,
                    productList: value.products,
                    showProgress: value.productsStateModel.showProgress,
                    addToCart: value2.addToCardProductMap,
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
