import 'package:flutter/material.dart';

// All constant arrays, including colors, fonts, sizes, constant string (names), etc must be defined here.
List<String> fonts = [
  'IranNastaliq',
  'Jaleh',
  'Naskh',
  'Nil',
  'Pashtu',
  'Shabnam'
];
List<Color> colors = [
  Colors.black,
  Colors.white,
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.orange,
  Colors.grey,
  Colors.indigoAccent,
  Colors.purple,
  Colors.teal
];
List<MaterialColor> appbarColors = [
  Colors.blue,
  Colors.red,
  Colors.green,
  Colors.orange,
  Colors.grey,
  Colors.purple,
  Colors.teal
];

List<String> wallpapers = [
  'assets/wallpapers/0.jpg',
  'assets/wallpapers/1.jpg',
  'assets/wallpapers/2.png',
  'assets/wallpapers/3.jpg',
  'assets/wallpapers/4.jpg',
  'assets/wallpapers/5.jpg',
  'assets/wallpapers/6.jpg',
  'assets/wallpapers/7.jpg',
  'assets/wallpapers/8.jpg',
  'assets/wallpapers/9.jpg',
];

/// 0 for circular, 1 for less circular, 2 for rectangular, 3 for hexagonal.
List<ShapeBorder> appBarShapeList = [
  RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(30),
    ),
  ),
  RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(15),
    ),
  ),
  RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(0),
    ),
  ),
  BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
];

List<OutlinedBorder> appBarShapeListBtn = [

  RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(30),
    ),
  ),
  RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(15),
    ),
  ),
  RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(0),
    ),
  ),
  BeveledRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
];
