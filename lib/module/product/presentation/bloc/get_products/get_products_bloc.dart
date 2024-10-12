import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:product_hub/module/product/domain/domain.dart';

part 'get_products_bloc.freezed.dart';
part 'get_products_event.dart';
part 'get_products_state.dart';

class GetProductsBloc extends Bloc<GetProductsEvent, GetProductsState> {
  final GetProductsUsecase getProductsUsecase;
  GetProductsBloc(
    this.getProductsUsecase,
  ) : super(const _Initial()) {
    List<ProductModel>? currentProduct;

    on<_GetProducts>((event, emit) async {
      if (event.request.offset == 0) emit(const _Loading());

      final result = await getProductsUsecase(event.request);
      result.fold((l) => emit(_Error(l.message)), (response) {
        emit(const _Loading());
        // ignore: unnecessary_null_comparison
        if (currentProduct == null) {
          currentProduct = response;
        } else {
          currentProduct!.addAll(response);
        }

        emit(
          _Loaded(
            ProductResponse(products: currentProduct!, isMax: response.isEmpty),
          ),
        );
      });
    });
  }
}
