import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:product_hub/shared/shared.dart';

class CustomCachedImage extends StatelessWidget {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final String urlToImage;

  const CustomCachedImage({
    super.key,
    required this.urlToImage,
    this.width,
    this.borderRadius,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(0),
      child: CachedNetworkImage(
        imageUrl: urlToImage,
        height: height,
        placeholder: (context, url) => Skeleton(
          width: width,
          height: height,
        ),
        width: width,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => Image.asset(
          Constant.imagePlaceholderUrl,
        ),
      ),
    );
  }
}
