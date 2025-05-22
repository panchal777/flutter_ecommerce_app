import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/widgets/custom_network_widget.dart';
import 'package:flutter_ecommerce_app/core/widgets/no_record_found.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/add_to_cart_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/widgets/title_widget.dart';

class ItemsToCart extends StatelessWidget {
  ItemsToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddToCartProvider>(
      builder: (context, value, child) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sharpsell Store", style: TextStyle(color: Colors.grey)),
                SizedBox(height: 5),
                Text(
                  "Total Items",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),

                value.stateModel.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : value.addToCartList.isEmpty
                    ? NoRecordFound()
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: value.addToCartList.length,
                        itemBuilder: (context, index) {
                          var data = value.addToCartList[index];

                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Container(
                              width: 40,
                              height: 40,
                              color: Colors.grey[300],
                              child: CustomNetworkWidget(
                                borderRadius: BorderRadius.circular(8),
                                imageUrl: data.images.isNotEmpty
                                    ? data.images[0]
                                    : '',
                              ),
                            ),
                            title: BodyWidget(label: data.title ?? ''),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                BodyWidget(label: "\$ ${data.price}"),
                                SizedBox(width: 8),
                                IconButton(
                                  icon: Icon(Icons.cancel),
                                  color: Colors.grey,
                                  onPressed: () {
                                    value.removeItemFromCart(id: data.id!);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
