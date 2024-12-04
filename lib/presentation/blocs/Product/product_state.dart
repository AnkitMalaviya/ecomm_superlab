import 'package:equatable/equatable.dart';

import '../../../data/models/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final int currentPage;
  final List<Product> products;
  bool isMoreLoading = false;
  ProductLoaded({
    required this.products,
    required this.currentPage,
    required this.isMoreLoading,
  });

  @override
  List<Object?> get props => [products, currentPage, isMoreLoading];
  ProductLoaded copyWith({
    List<Product>? products,
    int? currentPage,
    bool? isMoreLoading,
  }) {
    return ProductLoaded(
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      isMoreLoading: isMoreLoading ?? this.isMoreLoading,
    );
  }
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);

  @override
  List<Object?> get props => [message];
}
