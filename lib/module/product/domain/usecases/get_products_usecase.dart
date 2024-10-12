import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:product_hub/module/product/product.dart';
import 'package:product_hub/shared/shared.dart';

class GetProductsUsecase
    implements UseCaseFuture<Failure, List<ProductModel>, ProductRequest> {
  final ProductRepository repository;

  GetProductsUsecase({required this.repository});

  @override
  FutureOr<Either<Failure, List<ProductModel>>> call(ProductRequest params) {
    return repository.getProducts(param: params);
  }
}
