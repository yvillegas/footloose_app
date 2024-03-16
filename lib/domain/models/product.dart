import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(
      (json.decode(str) as List).map(
        (x) => Product.fromJson(
          x as Map<String, dynamic>,
        ),
      ),
    );

class Product {
  Product({
    required this.idProducto,
    required this.nombreProducto,
    required this.imagenProducto,
    required this.precioProducto,
    required this.nombreMarca,
    required this.nombreModelo,
    required this.nombreTalla,
    required this.nombreColor,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        idProducto: json['idProducto'] as int,
        nombreProducto: json['nombreProducto'] as String,
        imagenProducto: json['imagenProducto'] as String,
        precioProducto: json['precioProducto'] as String,
        nombreMarca: json['nombreMarca'] as String,
        nombreModelo: json['nombreModelo'] as String,
        nombreTalla: json['nombreTalla'] as String,
        nombreColor: json['nombreColor'] as String,
      );

  int idProducto;
  String nombreProducto;
  String imagenProducto;
  String precioProducto;
  String nombreMarca;
  String nombreModelo;
  String nombreTalla;
  String nombreColor;
}
