import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductsManager(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartManager(),
        ),
      ],
      child: MaterialApp(
        title: 'My Shop',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Lato',
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
          ).copyWith(
            secondary: Colors.yellow,
          ),
        ),
        home: const ProductsOverviewScreen(),
        routes: {
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
          UserProductsScreen.routeName: (context) => const UserProductsScreen(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == ProductDetailScreen.routeName) {
            final productId = settings.arguments as String;
            return MaterialPageRoute(
              builder: (ctx) {
                return ProductDetailScreen(
                  ctx.read<ProductsManager>().findById(productId),
                );
              },
            );
          }

          // if (settings.name == EditProductScreen.routeName) {
          //   final productId = settings.arguments as String?;
          //   return MaterialPageRoute(
          //     builder: (ctx) {
          //       return EditProductScreen(
          //         productId != null
          //             ? ctx.read<ProductsManager>().findById(productId)
          //             : null,
          //       );
          //     },
          //   );
          // }
          return null;
        },
      ),
    );
  }
}
