import 'dart:convert';

import 'package:product_hub/module/product/product.dart';
import 'package:product_hub/shared/shared.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<String> saveProducts(List<ProductModel> products);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final CacheHandler cacheHandler;

  ProductLocalDataSourceImpl({required this.cacheHandler});

  @override
  Future<List<ProductModel>> getProducts() async {
    try {
      final result = await cacheHandler.getCache(
        boxKey: Constant.productKey,
      );

      if (result == null) {
        throw CacheException(message: "Can't get Products data");
      }

      final res = json.decode(result);
      return List<ProductModel>.from(res.map((e) => ProductModel.fromJson(e)));
    } on CacheException catch (e) {
      throw CacheException(message: e.message);
    }
  }

  @override
  Future<String> saveProducts(List<ProductModel> products) async {
    try {
      final result = await cacheHandler.setCache(
        boxKey: Constant.productKey,
        value: jsonEncode((products).map((e) => e.toJson()).toList()),
      );

      if (result == null) {
        throw CacheException(message: "Can't save Products data");
      }

      return "Success saving products data";
    } on CacheException catch (e) {
      throw CacheException(message: e.message);
    }
  }
}
