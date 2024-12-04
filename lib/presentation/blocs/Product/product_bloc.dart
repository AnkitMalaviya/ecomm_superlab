import 'package:ecomm/presentation/blocs/Product/product_event.dart';
import 'package:ecomm/presentation/blocs/Product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_products_usecase.dart';


class ProductBloc extends Bloc<SearchEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;

  ProductBloc(this.getProductsUseCase) : super(ProductInitial()) {
    on<FetchSearchResults>((event, emit) async {
      print(event.page);
      if (event.page == 1) {
        emit(ProductLoading());
      } else {
        final currentState = state as ProductLoaded;
        emit(currentState.copyWith(isMoreLoading: true, currentPage: event.page));
      }
      try {
        if (event.page == 1) {
          final products = await getProductsUseCase.execute(event.query, event.page);
          emit(ProductLoaded(products: products, currentPage: event.page, isMoreLoading: false));
        } else {
          final products = await getProductsUseCase.execute(event.query, event.page);
          final currentState = state as ProductLoaded;
          emit(currentState.copyWith(isMoreLoading: false, products: [...currentState.products, ...products]));
        }
      } catch (e) {
        emit(ProductError('Failed to load search results.'));
      }
    });
  }
}
