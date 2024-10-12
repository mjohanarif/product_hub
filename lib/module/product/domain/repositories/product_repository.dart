import 'package:dartz/dartz.dart';
import 'package:product_hub/module/product/product.dart';
import 'package:product_hub/shared/shared.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductModel>>> getProducts({
    required ProductRequest param,
  });
}
