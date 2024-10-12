import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:product_hub/injection.dart';
import 'package:product_hub/module/product/product.dart';
import 'package:product_hub/shared/shared.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();
  Bloc.observer = AppBlocObserver();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(375, 820),
      child: BlocProvider(
        create: (context) => locator<GetProductsBloc>()
          ..add(
            GetProductsEvent.getProducts(
              ProductRequest(
                offset: 0,
                limit: 10,
              ),
            ),
          ),
        child: MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            colorSchemeSeed: AppColors.primary,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
            ),
          ),
          onGenerateRoute: AppRoutes.onGenerateRoutes,
        ),
      ),
    );
  }
}
