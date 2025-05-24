import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extensions.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_search_bar.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/add_to_cart_provider.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/product_list_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../components/add_to_cart/cart_app_bar_icon.dart';
import '../../components/product_grid_list_widget.dart';

class ProductListScreen extends StatefulWidget {
  final String categoryName;

  const ProductListScreen({super.key, required this.categoryName});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ScrollController _childScrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<ProductListProvider>(context, listen: false);

    _childScrollController.addListener(() {
      if (_childScrollController.position.pixels >=
              _childScrollController.position.maxScrollExtent &&
          !provider.uiModel.showProgress &&
          provider.p.hasMore &&
          !provider.isSearchFilterApplied) {
        provider.fetchMoreProducts();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _childScrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: widget.categoryName,
          actions: [CartAppBarIcon()],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            CustomSearchBar(
              onChanged: (value) {
                searchByProductName(value);
              },
            ).withPadding(const EdgeInsets.all(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleWidget(
                    title: AppStrings.products,
                  ).withOnlyPadding(left: 10, bottom: 10),

                  Expanded(
                    child: SingleChildScrollView(
                      controller: _childScrollController,
                      child: Consumer2<ProductListProvider, AddToCartProvider>(
                        builder: (context, value, value2, child) {
                          return ProductGridListWidget(
                            isStateLoading: value.uiModel.isLoading,
                            productList: value.displayProducts,
                            showProgress: value.uiModel.showProgress,
                            addToCart: value2.addToCardProductMap,
                          );
                        },
                      ),
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

  searchByProductName(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    // Set new timer
    _debounce = Timer(const Duration(milliseconds: 500), () {
      Provider.of<ProductListProvider>(
        context,
        listen: false,
      ).searchFilter(value);
    });
  }
}
