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
    required this.idMarca,
    required this.idModelo,
    required this.idColor,
    required this.idTalla,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        idProducto: json['idProducto'] as int,
        nombreProducto: json['nombreProducto'] as String,
        imagenProducto: json['imagenProducto'] as String,
        precioProducto: double.parse(json['precioProducto'] as String),
        nombreMarca: json['nombreMarca'] as String,
        nombreModelo: json['nombreModelo'] as String,
        nombreTalla: json['nombreTalla'] as String,
        nombreColor: json['nombreColor'] as String,
        idMarca: json['idMarca'] as int,
        idModelo: json['idModelo'] as int,
        idColor: json['idColor'] as int,
        idTalla: json['idTalla'] as int,
      );

  int idProducto;
  String nombreProducto;
  String imagenProducto;
  double precioProducto;
  String nombreMarca;
  String nombreModelo;
  String nombreTalla;
  String nombreColor;
  int idMarca;
  int idModelo;
  int idColor;
  int idTalla;
}
