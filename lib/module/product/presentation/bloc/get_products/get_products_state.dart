part of 'get_products_bloc.dart';

@freezed
class GetProductsState with _$GetProductsState {
  const factory GetProductsState.initial() = _Initial;
  const factory GetProductsState.loading() = _Loading;
  const factory GetProductsState.loaded(ProductResponse result) = _Loaded;
  const factory GetProductsState.error(String message) = _Error;
}
