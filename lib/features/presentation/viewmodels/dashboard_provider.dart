import 'package:flutter/foundation.dart';
import 'package:flutter_ecommerce_app/core/utils/state_model.dart';
import 'package:flutter_ecommerce_app/features/data/data_source/app_local_src_impl.dart';
import 'package:flutter_ecommerce_app/features/data/models/category_model.dart';
import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/features/data/repositories/app_repository_impl.dart';
import 'package:flutter_ecommerce_app/features/domain/repository/app_repository.dart';

class DashboardProvider with ChangeNotifier {
  final AppRepository _appRepository = AppRepositoryImpl(
    localSrc: AppLocalSrcImpl(),
  );
  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];
  StateModel _categoryStateModel = StateModel();
  StateModel _productsStateModel = StateModel();

  List<CategoryModel> get categories => _categories;

  List<ProductModel> get products => _products;

  StateModel get categoryStateModel => _categoryStateModel;

  StateModel get productsStateModel => _productsStateModel;

  Future<void> fetchAllDataForDashboard() async {
    _categoryStateModel.isLoading = true;
    _productsStateModel.isLoading = true;
    notifyListeners();
    var categoryCall = await _appRepository.getCategories();
    categoryCall.fold(
      (onError) {
        notifyStates(isCategory: true, isError: true, msg: onError.toString());
      },
      (list) {
        _categories = list;
        notifyStates(isCategory: true, isSuccess: true);
      },
    );

    var productCall = await _appRepository.getProducts();
    productCall.fold(
      (onError) {
        notifyStates(isCategory: false, isError: true, msg: onError.toString());
      },
      (list) {
        _products = list;
        notifyStates(isCategory: false, isSuccess: true);
      },
    );
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
      _categoryStateModel.isLoading =
          isLoading ?? _categoryStateModel.isLoading;
      _categoryStateModel.isError = isError ?? _categoryStateModel.isError;
      _categoryStateModel.isSuccess =
          isSuccess ?? _categoryStateModel.isSuccess;
      _categoryStateModel.showProgress =
          showProgress ?? _categoryStateModel.showProgress;
      _categoryStateModel.msg = msg ?? _categoryStateModel.msg;
    } else {
      _productsStateModel.isLoading =
          isLoading ?? _productsStateModel.isLoading;
      _productsStateModel.isError = isError ?? _productsStateModel.isError;
      _productsStateModel.isSuccess =
          isSuccess ?? _productsStateModel.isSuccess;
      _productsStateModel.showProgress =
          showProgress ?? _productsStateModel.showProgress;
      _productsStateModel.msg = msg ?? _productsStateModel.msg;
    }

    notifyListeners();
  }

  setDefaultToFalse() {
    _categoryStateModel = StateModel();
    _productsStateModel = StateModel();
  }
}
