import 'package:flutter/material.dart';
import 'package:product_hub/shared/shared.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  final Color? baseColor;
  final Color? highlightColor;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  const Skeleton({
    super.key,
    this.baseColor,
    this.highlightColor,
    this.width,
    this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(milliseconds: 1500),
      baseColor: AppColors.greyBackground,
      highlightColor: Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: borderRadius ?? BorderRadius.circular(4),
        ),
      ),
    );
  }
}
