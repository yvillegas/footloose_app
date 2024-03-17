import 'dart:convert';

List<Model> modelFromJson(String str) => List<Model>.from(
      (json.decode(str) as List).map(
        (x) => Model.fromJson(x as Map<String, dynamic>),
      ),
    );

class Model {
  Model({
    required this.idModelo,
    required this.nombreModelo,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        idModelo: json['idModelo'] as int,
        nombreModelo: json['nombreModelo'] as String,
      );

  int idModelo;
  String nombreModelo;
}
