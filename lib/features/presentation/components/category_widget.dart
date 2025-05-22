import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extensions.dart';
import 'package:flutter_ecommerce_app/features/data/models/category_model.dart';
import 'package:provider/provider.dart' show Consumer;
import 'package:shimmer/shimmer.dart' show Shimmer;

import '../../../core/utils/app_strings.dart';
import '../../../core/widgets/custom_network_widget.dart';
import '../../../core/widgets/no_record_found.dart';
import '../../../core/widgets/title_widget.dart';
import '../viewmodels/dashboard_provider.dart' show DashboardProvider;

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(
      builder: (context, value, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(title: AppStrings.categories).withOnlyPadding(left: 10),
            value.categoryStateModel.isLoading
                ? _buildShimmerList()
                : value.categories.isEmpty
                ? Center(child: NoRecordFound().withPadding(EdgeInsets.all(8)))
                : categories(value.categories),
          ],
        );
      },
    );
  }

  Widget categories(List<CategoryModel> categories) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: Row(
        children: List.generate(categories.length, (index) {
          var data = categories[index];

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: SizedBox(
              // color: Colors.blueGrey,
              width: 120,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: 110,
                      child: CustomNetworkWidget(imageUrl: data.image),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    flex: 1,
                    child: Text(
                      (data.name ?? '').capitalizeFirst(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(overflow: TextOverflow.ellipsis),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
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
          return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text('Category'),
                      // Replace with actual name if needed
                    ],
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
