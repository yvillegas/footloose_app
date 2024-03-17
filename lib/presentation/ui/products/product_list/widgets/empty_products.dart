import 'package:flutter/material.dart';

class EmptyProducts extends StatelessWidget {
  const EmptyProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 100,
      ),
      child: const Text(
        '''No hay productos disponibles con los filtros seleccionados''',
        textAlign: TextAlign.center,
      ),
    );
  }
}
