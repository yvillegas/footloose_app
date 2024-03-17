import 'package:footloose_app/domain/models/product.dart';

class ShoppingCartProduct {
  ShoppingCartProduct({
    required this.product,
    required this.total,
  });

  final Product product;
  final int total;
}
