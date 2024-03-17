import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/presentation/blocs/shopping_cart/shopping_cart_bloc.dart';
import 'package:footloose_app/presentation/routes/app_routes.dart';

class ShoppingCartAction extends StatelessWidget {
  const ShoppingCartAction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShoppingCartBloc, ShoppingCartState>(
      builder: (context, state) {
        if (state is LoadedShoppingCart) {
          if (state.products.isNotEmpty) {
            return Stack(
              children: [
                Center(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.shoppingCart);
                    },
                    icon: const Icon(Icons.shopping_cart),
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    height: 15,
                    width: 15,
                    child: Text(
                      state.products.length.toString(),
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            );
          }
          return Container();
        }
        return Container();
      },
    );
  }
}
