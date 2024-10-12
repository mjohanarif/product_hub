import 'package:dartz/dartz.dart';
import 'package:product_hub/module/product/product.dart';
import 'package:product_hub/shared/shared.dart';

class ProductRepositoryImpl implements ProductRepository {
  final NetworkInfo networkInfo;
  final ProductLocalDataSource localDataSource;
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ProductModel>>> getProducts({
    required ProductRequest param,
  }) async {
    if (param.offset == 0 && !(await networkInfo.isConnected)) {
      try {
        final result = await localDataSource.getProducts();

        return Right(result);
      } on CacheException catch (exception) {
        return Left(CacheFailure(exception.message));
      }
    } else {
      try {
        final result = await remoteDataSource.getProducts(param: param);
        if (param.offset == 0) {
          localDataSource.saveProducts(result);
        }

        return Right(result);
      } on ServerException catch (exception) {
        return Left(ServerFailure(exception.message));
      }
    }
  }
}
