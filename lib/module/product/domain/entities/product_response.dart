import 'package:equatable/equatable.dart';
import 'package:product_hub/module/product/domain/domain.dart';

class ProductResponse extends Equatable {
  final List<ProductModel> products;
  final bool isMax;

  const ProductResponse({required this.products, this.isMax = false});

  @override
  List<Object?> get props => [products, isMax];
}
