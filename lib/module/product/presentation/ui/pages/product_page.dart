import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_hub/injection.dart';
import 'package:product_hub/module/product/product.dart';
import 'package:product_hub/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final Debouncer _debouncer = Debouncer();
  int newOffset = 0;
  final ScrollController _scrollController = ScrollController();
  Future<void> scrollListener() async {
    if (await locator<NetworkInfo>().isConnected && newOffset != -1) {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScroll - currentScroll <= 100) {
        _debouncer.run(() {
          context.read<GetProductsBloc>().add(
                GetProductsEvent.getProducts(ProductRequest(offset: newOffset)),
              );
        });
      }
    }
  }

  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<GetProductsBloc>().add(
                GetProductsEvent.getProducts(ProductRequest()),
              );
        },
        child: SafeArea(
          child: BlocConsumer<GetProductsBloc, GetProductsState>(
            listener: (context, state) {
              state.mapOrNull(
                loaded: (value) {
                  if (value.result.isMax) {
                    newOffset = -1;
                  } else {
                    newOffset += 10;
                  }
                },
              );
            },
            builder: (context, state) {
              return state.maybeWhen(
                orElse: () {
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    itemBuilder: (context, index) {
                      return const ProductSkeleton();
                    },
                    separatorBuilder: (context, index) {
                      return AppSpacing.v16();
                    },
                    itemCount: 7,
                  );
                },
                loaded: (results) {
                  return ListView.separated(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    controller: _scrollController,
                    itemBuilder: (context, index) {
                      if (!results.isMax &&
                          index == results.products.length - 1) {
                        return const ProductSkeleton();
                      }
                      return ProductCard(product: results.products[index]);
                    },
                    separatorBuilder: (context, index) {
                      return AppSpacing.v16();
                    },
                    itemCount: results.products.length,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 115.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Skeleton(
            height: 115.h,
            width: 100,
            borderRadius: BorderRadius.circular(20),
          ),
          const AppSpacing(h: 10),
          Expanded(
            child: Column(
              children: [
                Skeleton(height: 20.h),
                const AppSpacing(v: 4),
                Skeleton(height: 40.h),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Skeleton(
                    height: 20.h,
                    width: 50.w,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({
    this.milliseconds = 500,
  });

  run(VoidCallback action) {
    if (null != _timer) {
      _timer!.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
