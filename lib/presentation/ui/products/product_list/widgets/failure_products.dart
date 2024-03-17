import 'package:flutter/material.dart';

class FailureProducts extends StatelessWidget {
  const FailureProducts({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Hubo un error la cargar la información',
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: onPressed,
            child: const Text('Intentar de Nuevo'),
          ),
        ],
      ),
    );
  }
}
