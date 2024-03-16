import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/domain/use_cases/get_products.dart';
import 'package:footloose_app/injection/injection.dart';
import 'package:footloose_app/presentation/blocs/product_list/product_list_bloc.dart';
import 'package:footloose_app/presentation/ui/products/product_list/widgets/product_list_item.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductListBloc(
        getProducts: getIt<GetProducts>(),
      ),
      child: const ProductList(),
    );
  }
}

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  late ProductListBloc _productListBloc;

  @override
  void initState() {
    super.initState();
    _productListBloc = context.read<ProductListBloc>();

    _productListBloc.add(const OnGetProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.qr_code),
        onPressed: () {},
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state is LoadingGetProducts) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessGetProducts) {
            final products = state.products;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                    products.length,
                    (index) => ProductListItem(
                      product: products[index],
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            );
          }
          return Container(
            child: const Text('Failure'),
          );
        },
      ),
    );
  }
}
