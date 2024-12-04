import 'package:ecomm/presentation/blocs/Product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/product_repository.dart';
import 'domain/usecases/get_products_usecase.dart';

import 'presentation/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Commerce App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: BlocProvider(
        create: (_) => ProductBloc(GetProductsUseCase(ProductRepository())),
        child: const SearchScreen(),
      ),
    );
  }
}
