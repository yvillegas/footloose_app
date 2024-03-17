import 'dart:convert';

List<Color> colorFromJson(String str) => List<Color>.from(
      (json.decode(str) as List).map(
        (x) => Color.fromJson(x as Map<String, dynamic>),
      ),
    );

class Color {
  Color({
    required this.idColor,
    required this.nombreColor,
  });

  factory Color.fromJson(Map<String, dynamic> json) => Color(
        idColor: json['idColor'] as int,
        nombreColor: json['nombreColor'] as String,
      );

  int idColor;
  String nombreColor;
}
