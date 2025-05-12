import 'package:flutter/material.dart';

class Person {
  final String name;
  // final int colorValue;

  Person({required this.name});
  // Person({required this.name, required this.colorValue});

  // Color get color => Color(colorValue);

  // Optional: for serialization
  // Map<String, dynamic> toJson() => {
  //       'name': name,
  //       'color': colorValue,
  //     };

  // factory Person.fromJson(Map<String, dynamic> json) => Person(
  //       name: json['name'],
  //       colorValue: json['color'],
  //     );
}
