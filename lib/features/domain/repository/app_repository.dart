import 'package:dartz/dartz.dart' show Either;
import 'package:flutter_ecommerce_app/features/data/models/category_model.dart';

import '../../../core/error_handling/failure.dart';
import '../../data/models/product_model.dart' show ProductModel;

abstract class AppRepository {
  //dashboard
  Future<Either<Failure, List<CategoryModel>>> getCategories(int limit);

  Future<Either<Failure, List<ProductModel>>> getProducts(int limit, int offset);

  //product details
  Future<Either<Failure, ProductModel>> getProductById(int productId);

  Future<Either<Failure, List<ProductModel>>> getSimilarProduct(int productId);

  //search home
  // product list on clicking category list item
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
    int categoryId,
  );
}
