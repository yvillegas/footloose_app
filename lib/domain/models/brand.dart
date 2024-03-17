import 'dart:convert';

List<Brand> brandFromJson(String str) => List<Brand>.from(
      (json.decode(str) as List).map(
        (x) => Brand.fromJson(x as Map<String, dynamic>),
      ),
    );

class Brand {
  Brand({
    required this.idMarca,
    required this.nombreMarca,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        idMarca: json['idMarca'] as int,
        nombreMarca: json['nombreMarca'] as String,
      );

  int idMarca;
  String nombreMarca;
}
