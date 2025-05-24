import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show ElevatedButton, Colors, Divider, Card, Icons;
import 'package:flutter_ecommerce_app/core/utils/common.dart';
import 'package:flutter_ecommerce_app/features/presentation/viewmodels/add_to_cart_provider.dart';
import 'package:provider/provider.dart';

class BillingDetailsWidget extends StatelessWidget {
  const BillingDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddToCartProvider>(
      builder: (context, value, child) {
        return Visibility(
          visible: value.addToCartList.isNotEmpty,
          child: Column(
            children: [
              // Bill Details
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Bill Details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Card(
                color: Colors.grey[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildBillRow("Item Total", "", "\$${value.itemTotal}"),
                      _buildBillRow(
                        "Festive handling charge",
                        "\$${value.festiveHandlingChargeOld}",
                        "\$${value.festiveHandlingCharge}",
                      ),
                      _buildBillRowWithSubtext(
                        "Delivery Partner Fee",
                        "\$${value.deliveryPartner}",
                        "Add items worth \$83 to avail your Swiggy Black Free Delivery on this order",
                      ),
                      _buildBillRow(
                        "GST and Charges",
                        "",
                        "\$${value.gstAndCharges}",
                      ),
                      Divider(),
                      _buildBillRow(
                        "To Pay",
                        "\$${value.toPayOld}",
                        "\$${value.toPay}",
                        bold: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  backgroundColor: Colors.black,
                ),
                onPressed: () {
                  Common.toastMessage("Order placed Successfully");
                },
                child: Text("Pay", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBillRow(
    String label,
    String oldPrice,
    String newPrice, {
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: bold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Row(
            children: [
              if (oldPrice.isNotEmpty)
                Text(
                  oldPrice,
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.grey,
                  ),
                ),
              if (oldPrice.isNotEmpty) SizedBox(width: 6),
              Text(
                newPrice,
                style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBillRowWithSubtext(String label, String value, String subtext) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, size: 16),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text(label), Text(value)],
                ),
                SizedBox(height: 4),
                Text(
                  subtext,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
