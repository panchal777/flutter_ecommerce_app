import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/routes/route_name.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extensions.dart';
import 'package:flutter_ecommerce_app/core/widgets/no_record_found.dart';
import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/features/presentation/components/loading_cards/simmer_product_card.dart'
    show SimmerProductCard;
import 'package:flutter_ecommerce_app/features/presentation/components/product_list_card.dart';
import 'package:go_router/go_router.dart';
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/title_widget.dart';

class ProductListWidget extends StatelessWidget {
  final bool isStateLoading;
  final List<ProductModel> productList;
  final bool showProgress;

  const ProductListWidget({
    super.key,
    required this.productList,
    required this.isStateLoading,
    required this.showProgress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(title: AppStrings.products).withOnlyPadding(left: 10),
        isStateLoading
            ? _buildShimmerList()
            : productList.isEmpty
            ? Center(child: NoRecordFound().withPadding(EdgeInsets.all(8)))
            : _products(context),
      ],
    );
  }

  Widget _products(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          controller: null,
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: productList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 10,
            mainAxisSpacing: 2,
          ),
          itemBuilder: (_, index) {
            var data = productList[index];
            return GestureDetector(
              onTap: () {
                context.pushNamed(RouteName.productDetails, extra: data);
              },
              child: ProductListCard(productModel: data),
            );
          },
        ),
        // Optional loader
        if (showProgress)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: CircularProgressIndicator(),
          ),
      ],
    );
  }

  Widget _buildShimmerList() {
    return GridView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        return SimmerProductCard();
      },
    );
  }
}
