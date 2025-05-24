import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extensions.dart';
import 'package:flutter_ecommerce_app/core/utils/app_strings.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_search_bar.dart';
import 'package:flutter_ecommerce_app/features/presentation/components/category_widget.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/add_to_cart_provider.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/dashboard_provider.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/title_widget.dart';
import '../../components/add_to_cart/cart_app_bar_icon.dart';
import '../../components/product_grid_list_widget.dart';

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
          !provider.productUiModel.showProgress &&
          provider.p.hasMore &&
          !provider.isSearchFilterApplied) {
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
        appBar: CustomAppBar(
          title: AppStrings.dashboardTitle,
          actions: [CartAppBarIcon()],
          showBackButton: false,
        ),
        body: SingleChildScrollView(
          controller: _parentScrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              CustomSearchBar(
                onChanged: (value) {
                  searchByProductName(value);
                },
              ).withPadding(const EdgeInsets.all(10)),
              SizedBox(height: 10),
              CategoryWidget(),
              SizedBox(height: 10),
              Consumer2<DashboardProvider, AddToCartProvider>(
                builder: (context, value, value2, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(
                        title: AppStrings.products,
                      ).withOnlyPadding(left: 10, bottom: 10),
                      ProductGridListWidget(
                        isStateLoading: value.productUiModel.isLoading,
                        productList: value.displayProducts,
                        showProgress: value.productUiModel.showProgress,
                        addToCart: value2.addToCardProductMap,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  searchByProductName(String value) {
    Provider.of<DashboardProvider>(context, listen: false).searchFilter(value);
  }
}
