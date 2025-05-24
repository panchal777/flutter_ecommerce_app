import 'package:flutter_ecommerce_app/features/data/models/category_model.dart';
import 'package:flutter_ecommerce_app/features/data/models/product_model.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../utils/env.dart';

part 'rest_client.g.dart';

@RestApi(baseUrl: Env.apiBaseUrl)
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /*dashboard*/
  @GET("/categories")
  Future<List<CategoryModel>> fetchCategories(@Query("limit") int limit);

  @GET("/products")
  Future<List<ProductModel>> fetchProducts(
    @Query("limit") int limit,
    @Query("offset") int offset,
  );

  /*product details*/
  @GET("/products/{id}")
  Future<ProductModel> getProductById(@Path("id") int id);

  @GET("/products/{id}/related")
  Future<List<ProductModel>> getSimilarProduct(@Path("id") int id);

  /*product list*/
  @GET("/categories/{id}/products")
  Future<List<ProductModel>> getProductListByCatId(
    @Path("id") int id,
    @Query("limit") int limit,
    @Query("offset") int offset,
  );
}
