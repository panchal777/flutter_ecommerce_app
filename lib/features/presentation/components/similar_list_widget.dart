import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extensions.dart';
import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/features/presentation/components/product_list_card.dart';
import 'package:flutter_ecommerce_app/features/presentation/components/loading_cards/simmer_product_card.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/add_to_cart_provider.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/product_provider.dart';
import 'package:provider/provider.dart' show  Consumer2;
import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/no_record_found.dart';
import '../../../core/widgets/title_widget.dart';

class SimilarListWidget extends StatelessWidget {
  const SimilarListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProductProvider, AddToCartProvider>(
      builder: (context, value, value2, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(
              title: AppStrings.similarProducts,
            ).withOnlyPadding(left: 10),
            value.similarListState.isLoading
                ? _buildShimmerList()
                : value.similarList.isEmpty
                ? NoRecordFound()
                : similarList(value.similarList, value2.addToCardProductMap),
            SizedBox(height: 30),
          ],
        );
      },
    );
  }

  Widget similarList(
    List<ProductModel> similarList,
    Map<String, dynamic> addToCart,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Row(
        children: List.generate(similarList.length, (index) {
          var data = similarList[index];
          data.isSelected = addToCart.containsKey(data.id.toString());
          return Container(
            margin: EdgeInsets.all(5),
            height: 250,
            width: 150,
            child: ProductListCard(productModel: data),
          );
        }),
      ),
    );
  }

  Widget _buildShimmerList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Row(
        children: List.generate(10, (index) => index).map((e) {
          return Container(
            padding: EdgeInsets.all(5),
            height: 200,
            width: 200,
            child: SimmerProductCard(),
          );
        }).toList(),
      ),
    );
  }
}
