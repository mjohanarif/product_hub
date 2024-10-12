import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:product_hub/module/product/product.dart';
import 'package:product_hub/shared/shared.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  locator
    // repository
    ..registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(
        networkInfo: locator(),
        localDataSource: locator(),
        remoteDataSource: locator(),
      ),
    )

    // usecase
    ..registerLazySingleton(
      () => GetProductsUsecase(
        repository: locator(),
      ),
    )

    // data source
    ..registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(
        cacheHandler: locator(),
      ),
    )
    ..registerLazySingleton<ProductRemoteDataSource>(
      () => ProductRemoteDataSourceImpl(
        client: locator(),
      ),
    )

    // BLOC
    ..registerFactory(
      () => GetProductsBloc(
        locator(),
      ),
    )

    // external
    ..registerLazySingleton(
      () => Dio()
        ..options = BaseOptions(baseUrl: Constant.baseUrl)
        ..interceptors.addAll(
          [
            LogInterceptor(
              requestBody: true,
              responseBody: true,
            ),
          ],
        ),
    )
    ..registerLazySingleton(InternetConnectionChecker.new)
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(
        locator(),
      ),
    )
    ..registerLazySingleton(
      () => CacheHandler(
        cache: locator(),
      ),
    )
    ..registerLazySingleton<HiveInterface>(
      () => Hive,
    );
  if (!kIsWeb) {
    final appDocDir = await getApplicationDocumentsDirectory();
    Hive.init('${appDocDir.path}/db');
  }
}
