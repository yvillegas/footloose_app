import 'package:flutter/material.dart';
import 'package:footloose_app/domain/models/product.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
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
                  'http://192.168.0.12:3000/img/${product.imagenProducto}',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.nombreProducto,
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
                          'S/${product.precioProducto}',
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Marca: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          product.nombreMarca,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Modelo: ',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          product.nombreModelo,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider()
      ],
    );
  }
}
