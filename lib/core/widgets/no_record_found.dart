import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/core/utils/app_extensions.dart';

class NoRecordFound extends StatelessWidget {
  const NoRecordFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("No Records found").withPadding(EdgeInsets.all(8)));
  }
}
