import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecomm/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../core/constants/app_url.dart';
import '../../core/widgets/search_bar.dart';
import '../blocs/Product/product_bloc.dart';
import '../blocs/Product/product_event.dart';
import '../blocs/Product/product_state.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    context.read<ProductBloc>().add(FetchSearchResults("", 1));
    _scrollController.addListener(scrollListner);
    super.initState();
  }

  scrollListner() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      final currentState = context.read<ProductBloc>().state as ProductLoaded;
      if (!currentState.isMoreLoading) {
        context.read<ProductBloc>().add(FetchSearchResults(_controller.text, currentState.currentPage + 1));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double padding = MediaQuery.of(context).size.width * .05;
    return Scaffold(
      appBar: AppBar(title: const Text('E Commerce')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          children: [
            SearchBarWidget(
              controller: _controller,
              onSearch: () {
                context.read<ProductBloc>().add(FetchSearchResults(_controller.text, 1));
              },
              onChanged: (value) {
                context.read<ProductBloc>().add(FetchSearchResults(_controller.text, 1));
              },
            ),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ProductLoaded) {
                    return ListView.builder(
                      controller: _scrollController,
                      itemCount: (state.products.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        final product = state.products[index + index];
                        final product1 =
                            state.products.length > (index + index + 1) ? state.products[index + index + 1] : null;
                        return Row(
                          children: [
                            ProductTileWidget(context, padding, product),
                            SizedBox(
                              width: padding / 2,
                            ),
                            Visibility(
                              visible: state.products.length > (index + index + 1),
                              child: ProductTileWidget(context, padding, product1),
                            )
                          ],
                        );
                      },
                    );
                  } else if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }
                  return const Center(child: Text('Search for products'));
                },
              ),
            ),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                return state is ProductLoaded
                    ? state.isMoreLoading ?? false
                        ? const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          )
                        : const SizedBox.shrink()
                    : const SizedBox.shrink(); // Return an empty widget when not loading
              },
            ),
          ],
        ),
      ),
    );
  }

  Container ProductTileWidget(
    BuildContext context,
    double padding,
    Product? product,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width * .5 - padding - (padding / 4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            height: MediaQuery.of(context).size.height * .3,
            imageUrl: "${AppUrl.imageBaseUrl}${product?.thumbnail}",
            progressIndicatorBuilder: (context, url, downloadProgress) => Container(
                width: MediaQuery.of(context).size.width * .5 - padding - (padding / 4),
                child: Center(child: CircularProgressIndicator(value: downloadProgress.progress))),
            errorWidget: (context, url, error) => Icon(Icons.error),
            fit: BoxFit.fill,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "${product?.title}" ?? "",
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              RatingBar.builder(
                ignoreGestures: true,
                initialRating: product?.averageRating ?? 0.0,
                glowColor: Colors.pink,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemSize: 15,
                itemCount: 5,
                glow: true,
                unratedColor: Colors.grey.withOpacity(0.8),
                itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.pink),
                onRatingUpdate: (val) {},
              ),
              Text(
                '${product?.averageRating?.toStringAsFixed(1) ?? ""}',
              ),
            ],
          ),
          Text(
            '\$${product?.priceStart?.toStringAsFixed(2)}',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}
