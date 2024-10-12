import 'package:dio/dio.dart';
import 'package:product_hub/module/product/product.dart';
import 'package:product_hub/shared/shared.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts({required ProductRequest param});
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final Dio client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts({
    required ProductRequest param,
  }) async {
    try {
      final response = await client.get(
        'products?offset=${param.offset}&limit=${param.limit}',
      );

      final result = List<Map<String, dynamic>>.from(response.data);

      return result.map((e) => ProductModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerException(
        message: e.response != null
            ? 'Error ${e.response!.statusCode}: ${e.response!.statusMessage}'
            : e.message ?? 'Server Error',
      );
    }
  }
}
