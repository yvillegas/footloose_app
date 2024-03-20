import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/core/variables.dart';
import 'package:footloose_app/domain/use_cases/get_product.dart';
import 'package:footloose_app/injection/injection.dart';
import 'package:footloose_app/presentation/blocs/product_detail_bloc/product_detail_bloc.dart';
import 'package:footloose_app/presentation/blocs/shopping_cart/shopping_cart_bloc.dart';
import 'package:footloose_app/presentation/ui/products/product_detail/widgets/product_detail_section.dart';

class ProductDetailPageArguments {
  ProductDetailPageArguments({
    required this.productoId,
  });

  final int productoId;
}

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailBloc(
        getProduct: getIt<GetProduct>(),
      ),
      child: ProductDetailView(id: id),
    );
  }
}

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({
    super.key,
    required this.id,
  });

  final int id;

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  late ProductDetailBloc _productDetailBloc;
  late ShoppingCartBloc _shoppingCartBloc;

  int _total = 0;

  @override
  void initState() {
    super.initState();
    _productDetailBloc = context.read<ProductDetailBloc>();
    _shoppingCartBloc = context.read<ShoppingCartBloc>();

    _productDetailBloc.add(OnGetProduct(id: widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Producto #${widget.id}',
        ),
      ),
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          if (state is LoadingGetProduct) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessGetProduct) {
            final product = state.product;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(width: double.infinity),
                  const SizedBox(height: 20),
                  Text(
                    product.nombreProducto,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.network(
                      '${Variables.baseImageURL}/${product.imagenProducto}',
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Características del producto',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ProductDetailSection(
                    title: 'Marca: ',
                    description: product.nombreMarca,
                  ),
                  ProductDetailSection(
                    title: 'Modelo: ',
                    description: product.nombreModelo,
                  ),
                  ProductDetailSection(
                    title: 'Precio: ',
                    description: 'S/${product.precioProducto}',
                  ),
                  ProductDetailSection(
                    title: 'Color: ',
                    description: product.nombreColor,
                  ),
                  const Spacer(),
                  SafeArea(
                    top: false,
                    child: Container(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (_total > 0) {
                                      _total--;
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(_total.toString()),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _total++;
                                  });
                                },
                                icon: const Icon(Icons.add),
                              )
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                            ),
                            onPressed: _total > 0
                                ? () {
                                    _shoppingCartBloc.add(
                                      OnAddProduct(
                                        product: product,
                                        total: _total,
                                      ),
                                    );
                                    Navigator.pop(context);
                                  }
                                : null,
                            child: const Text('Agregar al carrito'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
