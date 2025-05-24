import 'package:flutter/foundation.dart';
import 'package:flutter_ecommerce_app/core/utils/ui_model.dart';
import 'package:flutter_ecommerce_app/features/data/data_source/app_local_src_impl.dart';
import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/features/data/repositories/app_repository_impl.dart';
import 'package:flutter_ecommerce_app/features/domain/repository/app_repository.dart';

class ProductListProvider with ChangeNotifier {
  final AppRepository _appRepository = AppRepositoryImpl(
    localSrc: AppLocalSrcImpl(),
  );
  List<ProductModel> _products = [];
  List<ProductModel> displayProducts = [];
  UiModel uiModel = UiModel();
  Pagination p = Pagination(limit: 5, offset: 0);
  int currentCatId = -1;
  bool isSearchFilterApplied = false;

  Future<void> getProductsFromCatId(int catId) async {
    currentCatId = catId;
    uiModel.isLoading = true;
    isSearchFilterApplied = false;
    _getProducts(catId);
    notifyListeners();
  }

  _getProducts(int catId) async {
    var productCall = await _appRepository.getProductsByCategory(
      catId,
      p.limit,
      p.offset,
    );
    productCall.fold(
      (onError) {
        notifyStates(
          isCategory: false,
          isError: true,
          msg: onError.toString(),
          showProgress: false,
        );
      },
      (list) {
        updateCountsForProducts(list);
        notifyStates(isCategory: false, isSuccess: true, showProgress: false);
      },
    );
  }

  updateCountsForProducts(List<ProductModel> list) {
    debugPrint(
      'products '
      '---> offset ${p.offset}'
      '----> limit ${p.limit} ',
    );
    p.offset = p.offset + p.limit;
    p.hasMore = list.length == p.limit;
    _products.addAll(list);
    displayProducts.addAll(list);
    debugPrint('fetched products ----> ${_products.length}');
  }

  fetchMoreProducts() {
    uiModel.showProgress = true;
    notifyListeners();
    _getProducts(currentCatId);
  }

  searchFilter(String searchText) {
    if (searchText.isEmpty) {
      isSearchFilterApplied = false;
      displayProducts = List.from(_products);
    } else {
      isSearchFilterApplied = true;
      displayProducts = _products.where((product) {
        return (product.title ?? '').toLowerCase().contains(
          searchText.toLowerCase(),
        );
      }).toList();

      debugPrint('search text ----> $searchText');
      debugPrint('search products ----> ${displayProducts.length}');
    }
    notifyListeners();
  }

  notifyStates({
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    bool? showProgress,
    String? msg,
    required bool isCategory,
  }) {
    setDefaultToFalse();
    uiModel.isLoading = isLoading ?? uiModel.isLoading;
    uiModel.isError = isError ?? uiModel.isError;
    uiModel.isSuccess = isSuccess ?? uiModel.isSuccess;
    uiModel.showProgress = showProgress ?? uiModel.showProgress;
    uiModel.msg = msg ?? uiModel.msg;
    notifyListeners();
  }

  setDefaultToFalse() {
    uiModel = UiModel();
  }
}
