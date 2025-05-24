import 'package:flutter/foundation.dart';
import 'package:flutter_ecommerce_app/core/utils/ui_model.dart';
import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';

class AddToCartProvider with ChangeNotifier {
  List<ProductModel> _addToCartList = [];
  UiModel _stateModel = UiModel();
  String itemTotal = '0';
  String festiveHandlingChargeOld = '10.0';
  String festiveHandlingCharge = '8.90';
  String deliveryPartner = '30.00';
  String gstAndCharges = '1.60';
  double toPay = 0;

  double toPayOld = 0;

  List<ProductModel> get addToCartList => _addToCartList;
  final Map<String, dynamic> addToCardProductMap = {};

  //states for loading, success, error
  UiModel get stateModel => _stateModel;

  addItemToCart(ProductModel model) {
    _addToCartList.add(model);
    addToCardProductMap[model.id.toString()] = model.title;

    notifyListeners();

    if (_addToCartList.isNotEmpty) {
      itemTotal = _addToCartList
          .map((item) => item.price!)
          .reduce((value, element) => value + element)
          .toString();
    }

    toPay =
        double.parse(itemTotal) +
        double.parse(festiveHandlingCharge) +
        double.parse(deliveryPartner) +
        double.parse(gstAndCharges);

    toPayOld = toPay + double.parse(festiveHandlingChargeOld);
    notifyListeners();
  }

  removeItemFromCart({required int id}) {
    _addToCartList.removeWhere((element) => element.id == id);
    addToCardProductMap.remove(id.toString());
    notifyListeners();
  }
}
