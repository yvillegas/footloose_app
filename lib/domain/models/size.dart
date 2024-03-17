import 'dart:convert';

List<Size> sizeFromJson(String str) => List<Size>.from(
      (json.decode(str) as List).map(
        (x) => Size.fromJson(x as Map<String, dynamic>),
      ),
    );

class Size {
  Size({
    required this.idTalla,
    required this.nombreTalla,
  });

  factory Size.fromJson(Map<String, dynamic> json) => Size(
        idTalla: json['idTalla'] as int,
        nombreTalla: json['nombreTalla'] as String,
      );

  int idTalla;
  String nombreTalla;
}
