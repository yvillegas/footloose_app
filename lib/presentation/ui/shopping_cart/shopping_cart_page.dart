import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/presentation/blocs/shopping_cart/shopping_cart_bloc.dart';
import 'package:footloose_app/presentation/ui/shopping_cart/widgets/shopping_cart_item.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  late ShoppingCartBloc _shoppingCartBloc;

  @override
  void initState() {
    super.initState();
    _shoppingCartBloc = context.read<ShoppingCartBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
      ),
      body: BlocConsumer<ShoppingCartBloc, ShoppingCartState>(
        listener: (context, state) {
          if (state is SuccessSaveShoppingCart) {
            Navigator.pop(context);
            final snackBar = SnackBar(
              content: const Text('Compra Realizada!'),
              action: SnackBarAction(
                label: 'Cerrar',
                onPressed: () {
                  // Some code to undo the change.
                },
              ),
            );

            // Find the ScaffoldMessenger in the widget tree
            // and use it to show a SnackBar.
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        builder: (context, state) {
          if (state is LoadingSaveShoppingCart ||
              state is LoadingShoppingCart) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedShoppingCart) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                    state.products.length,
                    (index) => ShoppingCartItem(
                      shoppingProduct: state.products[index],
                      index: index,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                    ),
                    onPressed: () {
                      _shoppingCartBloc.add(const OnSaveShoppingCart());
                    },
                    child: const Text('Comprar'),
                  ),
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
