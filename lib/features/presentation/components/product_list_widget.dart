import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extensions.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_network_widget.dart';
import 'package:flutter_ecommerce_app/core/widgets/no_record_found.dart';
import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';
import 'package:shimmer/shimmer.dart' show Shimmer;

import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/title_widget.dart';

class ProductListWidget extends StatelessWidget {
  final bool isStateLoading;
  final List<ProductModel> productList;

  const ProductListWidget({
    super.key,
    required this.productList,
    required this.isStateLoading,
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
            : _products(),
      ],
    );
  }

  Widget _products() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.all(10),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (_, index) {
        var data = productList[index];
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
                        imageUrl: data.images.isNotEmpty ? data.images[0] : '',
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text((data.title ?? '').capitalizeFirst()),
                      Text('\$${data.price}'),
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
      },
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
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 12,
                          width: 100,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 12,
                          width: 50,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 8,
              right: 8,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.transparent,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
