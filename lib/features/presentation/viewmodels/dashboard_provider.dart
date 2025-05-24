import 'package:flutter/foundation.dart';
import 'package:flutter_ecommerce_app/core/utils/ui_model.dart';
import 'package:flutter_ecommerce_app/features/data/data_source/app_local_src_impl.dart';
import 'package:flutter_ecommerce_app/features/data/models/category_model.dart';
import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/features/data/repositories/app_repository_impl.dart';
import 'package:flutter_ecommerce_app/features/domain/repository/app_repository.dart';

class DashboardProvider with ChangeNotifier {
  final AppRepository _appRepository = AppRepositoryImpl(
    localSrc: AppLocalSrcImpl(),
  );

  //Setting all list
  List<CategoryModel> _categories = [];
  List<ProductModel> _products = []; // original list
  List<ProductModel> _displayProducts = []; //filter and display

  // state model to check status, error, success
  UiModel _catUiModel = UiModel();
  UiModel _productUiModel = UiModel();

  // getting all values
  List<CategoryModel> get categories => _categories;

  List<ProductModel> get displayProducts => _displayProducts;

  UiModel get catUiModel => _catUiModel;

  UiModel get productUiModel => _productUiModel;

  //locals
  bool isSearchFilterApplied = false;
  Pagination p = Pagination(limit: 10, offset: 0);

  Future<void> fetchAllDataForDashboard() async {
    _catUiModel.isLoading = true;
    _productUiModel.isLoading = true;
    isSearchFilterApplied = false;
    getCategories();
    getProducts();
    notifyListeners();
  }

  getCategories() async {
    var categoryCall = await _appRepository.getCategories(10);
    categoryCall.fold(
      (onError) {
        notifyStates(isCategory: true, isError: true, msg: onError.toString());
      },
      (list) {
        _categories = list;
        notifyStates(isCategory: true, isSuccess: true);
      },
    );
  }

  getProducts() async {
    var productCall = await _appRepository.getProducts(p.limit, p.offset);
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
    _displayProducts.addAll(list);
    debugPrint('fetched products ----> ${_products.length}');
  }

  fetchMoreProducts() {
    productUiModel.showProgress = true;
    notifyListeners();
    getProducts();
  }

  searchFilter(String searchText) {
    if (searchText.isEmpty) {
      isSearchFilterApplied = false;
      _displayProducts = List.from(_products);
    } else {
      isSearchFilterApplied = true;
      _displayProducts = _products.where((product) {
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
    if (isCategory) {
      _catUiModel.isLoading = isLoading ?? _catUiModel.isLoading;
      _catUiModel.isError = isError ?? _catUiModel.isError;
      _catUiModel.isSuccess = isSuccess ?? _catUiModel.isSuccess;
      _catUiModel.showProgress = showProgress ?? _catUiModel.showProgress;
      _catUiModel.msg = msg ?? _catUiModel.msg;
    } else {
      _productUiModel.isLoading = isLoading ?? _productUiModel.isLoading;
      _productUiModel.isError = isError ?? _productUiModel.isError;
      _productUiModel.isSuccess = isSuccess ?? _productUiModel.isSuccess;
      _productUiModel.showProgress =
          showProgress ?? _productUiModel.showProgress;
      _productUiModel.msg = msg ?? _productUiModel.msg;
    }

    notifyListeners();
  }

  setDefaultToFalse() {
    _catUiModel = UiModel();
    _productUiModel = UiModel();
  }
}
