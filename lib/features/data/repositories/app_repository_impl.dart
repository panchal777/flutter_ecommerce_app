import 'package:dartz/dartz.dart' show Right, Either, Left;
import 'package:flutter_ecommerce_app/features/data/data_source/app_local_src.dart';
import 'package:flutter_ecommerce_app/features/data/models/category_model.dart';
import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';
import 'package:flutter_ecommerce_app/features/domain/repository/app_repository.dart';

import '../../../core/error_handling/failure.dart';

class AppRepositoryImpl extends AppRepository {
  final AppLocalSrc localSrc;

  AppRepositoryImpl({required this.localSrc});

  @override
  Future<Either<Failure, List<CategoryModel>>> getCategories(int limit) async {
    try {
      var response = await localSrc.getCategories(limit);
      return Right(response);
    } catch (e, s) {
      Failure error = await checkErrorState(e, s);
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts(int limit, int offset) async {
    try {
      var response = await localSrc.getProducts(limit,offset);
      return Right(response);
    } catch (e, s) {
      Failure error = await checkErrorState(e, s);
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, ProductModel>> getProductById(int productId) async {
    try {
      var response = await localSrc.getProductById(productId);
      return Right(response);
    } catch (e, s) {
      Failure error = await checkErrorState(e, s);
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getSimilarProduct(
    int productId,
  ) async {
    try {
      var response = await localSrc.getSimilarProduct(productId);
      return Right(response);
    } catch (e, s) {
      Failure error = await checkErrorState(e, s);
      return Left(error);
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductsByCategory(
    int categoryId,
  ) async {
    try {
      var response = await localSrc.getProductsByCategory(categoryId);
      return Right(response);
    } catch (e, s) {
      Failure error = await checkErrorState(e, s);
      return Left(error);
    }
  }

  //handling all errors
  Future<Failure> checkErrorState(e, StackTrace s) async {
    return FailureMessage(e.toString());
  }
}
