import 'package:flutter/material.dart';
import 'package:product_hub/module/product/product.dart';
import 'package:product_hub/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
      ),
      height: 115.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.grey,
      ),
      child: Row(
        children: [
          CustomCachedImage(
            height: 115.h,
            width: 100.w,
            urlToImage: product.images.first,
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(20),
            ),
          ),
          const AppSpacing(h: 10),
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const AppSpacing(v: 4),
                Text(
                  product.description,
                  textAlign: TextAlign.justify,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      product.price.currencyFormatRp,
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
