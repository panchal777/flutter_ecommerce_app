import 'package:flutter_ecommerce_app/core/retrofit/rest_client.dart';
import 'package:flutter_ecommerce_app/features/data/data_source/app_local_src.dart';
import 'package:flutter_ecommerce_app/features/data/models/category_model.dart';
import 'package:dio/dio.dart';

import '../../../core/utils/env.dart';
import '../models/product_model.dart';

class AppLocalSrcImpl extends AppLocalSrc {
  late RestClient restClient;

  AppLocalSrcImpl() {
    initRestClient();
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    var list = await restClient.fetchCategories(10);
    return list;
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    var list = await restClient.fetchProducts(10, 0);
    return list;
  }

  @override
  Future<ProductModel> getProductById(int productId) async {
    var product = await restClient.getProductById(productId);
    return product;
  }

  @override
  Future<List<ProductModel>> getProductsByCategory(int categoryId) async {
    var list = await restClient.getProductListByCatId(categoryId);
    return list;
  }

  @override
  Future<List<ProductModel>> getSimilarProduct(int productId) async {
    var list = await restClient.getSimilarProduct(productId);
    return list;
  }

  Future initRestClient() async {
    Dio dio = Dio();
    dio.options.baseUrl = Env.apiBaseUrl;
    dio.interceptors.add(LogInterceptor(responseBody: true));
    restClient = (RestClient(dio));
  }
}
