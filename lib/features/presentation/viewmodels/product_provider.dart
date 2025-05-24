import 'package:flutter/foundation.dart';
import 'package:flutter_ecommerce_app/core/utils/ui_model.dart';
import 'package:flutter_ecommerce_app/features/data/data_source/app_local_src_impl.dart';
import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/features/data/repositories/app_repository_impl.dart';
import 'package:flutter_ecommerce_app/features/domain/repository/app_repository.dart';

class ProductProvider with ChangeNotifier {
  final AppRepository _appRepository = AppRepositoryImpl(
    localSrc: AppLocalSrcImpl(),
  );
  ProductModel? _productModel;
  List<ProductModel> _similarList = [];

  UiModel _productState = UiModel();
  UiModel _similarListState = UiModel();

  ProductModel? get productModel => _productModel;

  List<ProductModel> get similarList => _similarList;

  //states for loading, success, error
  UiModel get productState => _productState;

  UiModel get similarListState => _similarListState;

  Future<void> getProductDetailsScreenData(ProductModel model) async {
    _productState.isLoading = true;
    _similarListState.isLoading = true;
    notifyListeners();

    getProductDetails(model);
    await getSimilarList(model.id!);
  }

  //currently not fetching product detail from api as it is already having the same object on item click from product list
  getProductDetails(ProductModel model) {
    _productModel = model;
    _productState.isLoading = false;
    notifyListeners();
  }

  getSimilarList(int productId) async {
    var categoryCall = await _appRepository.getSimilarProduct(productId);
    categoryCall.fold(
      (onError) {
        notifyStates(
          isSimilarList: true,
          isError: true,
          msg: onError.toString(),
        );
      },
      (list) {
        _similarList = list;
        notifyStates(isSimilarList: true, isSuccess: true);
      },
    );
  }

  notifyStates({
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    bool? showProgress,
    String? msg,
    required bool isSimilarList,
  }) {
    setDefaultToFalse();
    if (isSimilarList) {
      _similarListState.isLoading = isLoading ?? _similarListState.isLoading;
      _similarListState.isError = isError ?? _similarListState.isError;
      _similarListState.isSuccess = isSuccess ?? _similarListState.isSuccess;
      _similarListState.showProgress =
          showProgress ?? _similarListState.showProgress;
      _similarListState.msg = msg ?? _similarListState.msg;
    } else {
      _productState.isLoading = isLoading ?? _productState.isLoading;
      _productState.isError = isError ?? _productState.isError;
      _productState.isSuccess = isSuccess ?? _productState.isSuccess;
      _productState.showProgress = showProgress ?? _productState.showProgress;
      _productState.msg = msg ?? _productState.msg;
    }

    notifyListeners();
  }

  setDefaultToFalse() {
    _productState = UiModel();
    _similarListState = UiModel();
  }
}
