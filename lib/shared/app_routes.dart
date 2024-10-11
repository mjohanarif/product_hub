import 'package:flutter/material.dart';
import 'package:product_hub/module/product/product.dart';

class AppRoutes {
  static const String main = '/';
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case main:
        return _materialRoute(
          const ProductPage(),
        );

      default:
        return _materialRoute(
          const ProductPage(),
        );
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute<dynamic>(
      builder: (_) => view,
    );
  }
}
