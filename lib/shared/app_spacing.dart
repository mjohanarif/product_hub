import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacing extends StatelessWidget {
  const AppSpacing({
    ///vertical space
    this.v = 0,

    ///horizontal space
    this.h = 0,
    super.key,
  });

  factory AppSpacing.h8() => const AppSpacing(h: 8);
  factory AppSpacing.v8() => const AppSpacing(v: 8);
  factory AppSpacing.h16() => const AppSpacing(h: 16);
  factory AppSpacing.v16() => const AppSpacing(v: 16);
  factory AppSpacing.h24() => const AppSpacing(h: 24);
  factory AppSpacing.v24() => const AppSpacing(v: 24);
  factory AppSpacing.h32() => const AppSpacing(h: 32);
  factory AppSpacing.v32() => const AppSpacing(v: 32);
  factory AppSpacing.v40() => const AppSpacing(v: 40);
  factory AppSpacing.h40() => const AppSpacing(h: 40);
  factory AppSpacing.v48() => const AppSpacing(v: 48);
  factory AppSpacing.h48() => const AppSpacing(h: 48);
  factory AppSpacing.v56() => const AppSpacing(v: 56);
  factory AppSpacing.h56() => const AppSpacing(h: 56);
  factory AppSpacing.v64() => const AppSpacing(v: 64);
  factory AppSpacing.h64() => const AppSpacing(h: 64);
  factory AppSpacing.v72() => const AppSpacing(v: 72);
  factory AppSpacing.h72() => const AppSpacing(h: 72);
  factory AppSpacing.v80() => const AppSpacing(v: 80);
  factory AppSpacing.h80() => const AppSpacing(h: 80);

  final int v;
  final int h;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: v.h,
      width: h.w,
    );
  }
}
