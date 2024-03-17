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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
      ),
      body: BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
        builder: (context, state) {
          if (state is LoadedShoppingCart) {
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
                      Navigator.pop(context);
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
