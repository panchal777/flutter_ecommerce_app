import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';

import '../models/category_model.dart';

abstract class AppLocalSrc {
  //dashboard
  Future<List<CategoryModel>> getCategories(int limit);

  Future<List<ProductModel>> getProducts(int limit, int offset);

  //product details
  Future<ProductModel> getProductById(int productId);

  Future<List<ProductModel>> getSimilarProduct(int productId);

  //search home
  // product list on clicking category list item
  Future<List<ProductModel>> getProductsByCategory(int categoryId);
}
