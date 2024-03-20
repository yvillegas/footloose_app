import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footloose_app/core/variables.dart';
import 'package:footloose_app/domain/models/shopping_cart.dart';
import 'package:footloose_app/presentation/blocs/shopping_cart/shopping_cart_bloc.dart';

class ShoppingCartItem extends StatefulWidget {
  const ShoppingCartItem({
    super.key,
    required this.shoppingProduct,
    required this.index,
  });

  final ShoppingCartProduct shoppingProduct;
  final int index;

  @override
  State<ShoppingCartItem> createState() => _ShoppingCartItemState();
}

class _ShoppingCartItemState extends State<ShoppingCartItem> {
  late ShoppingCartBloc _shoppingCartBloc;

  @override
  void initState() {
    super.initState();
    _shoppingCartBloc = context.read<ShoppingCartBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Row(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image.network(
              '${Variables.baseImageURL}/${widget.shoppingProduct.product.imagenProducto}',
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.shoppingProduct.product.nombreProducto,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      'Precio: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'S/${widget.shoppingProduct.product.precioProducto}',
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Cantidad: ',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.shoppingProduct.total.toString(),
                    )
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              _shoppingCartBloc.add(OnRemoveProduct(index: widget.index));
            },
            icon: const Icon(
              Icons.delete_outline_outlined,
              size: 30,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
