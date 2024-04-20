import 'package:flutter/material.dart';

class TestStripeModel {
  TestStripeModel({
    required this.name,
    required this.colorList,
    this.SelectedColor,
    this.selectedValue,
  });

  String name;
  List<ColorModel> colorList;
  Color? SelectedColor;
  double? selectedValue;
}

class ColorModel {
  const ColorModel({
    required this.color,
    required this.value,
  });

  final Color color;
  final double value;
}

List<TestStripeModel> stripeList = [
  TestStripeModel(
    name: 'Total Hardness (ppm)',
    colorList: [
      ColorModel(
        color: Colors.purple.shade50,
        value: 0,
      ),
      ColorModel(
        color: Colors.purple.shade100,
        value: 110,
      ),
      ColorModel(
        color: Colors.purple.shade300,
        value: 250,
      ),
      ColorModel(
        color: Colors.purple.shade800,
        value: 500,
      ),
      ColorModel(
        color: Colors.purple.shade900,
        value: 1000,
      ),
    ],
  ),
  TestStripeModel(
    name: 'Total Chlorine (ppm)',
    colorList: [
      ColorModel(
        color: Colors.yellowAccent,
        value: 0,
      ),
      ColorModel(
        color: Colors.yellowAccent.shade100,
        value: 1,
      ),
      ColorModel(
        color: Colors.greenAccent.shade200,
        value: 3,
      ),
      ColorModel(
        color: Colors.green.shade800,
        value: 5,
      ),
      ColorModel(
        color: Colors.green.shade900,
        value: 10,
      ),
    ],
  ),
  TestStripeModel(
    name: 'Free Chlorine (ppm)',
    colorList: [
      ColorModel(
        color: Colors.yellow.shade300,
        value: 6.2,
      ),
      ColorModel(
        color: Colors.brown.shade100,
        value: 6.8,
      ),
      ColorModel(
        color: Colors.purpleAccent.shade100,
        value: 7.2,
      ),
      ColorModel(
        color: Colors.deepPurple.shade800,
        value: 7.8,
      ),
      ColorModel(
        color: Colors.deepPurple.shade900,
        value: 8.4,
      ),
    ],
  ),
  TestStripeModel(
    name: 'Free Chlorine (ppm)',
    colorList: [
      ColorModel(
        color: Colors.yellow.shade300,
        value: 6.2,
      ),
      ColorModel(
        color: Colors.brown.shade100,
        value: 6.8,
      ),
      ColorModel(
        color: Colors.purpleAccent.shade100,
        value: 7.2,
      ),
      ColorModel(
        color: Colors.deepPurple.shade800,
        value: 7.8,
      ),
      ColorModel(
        color: Colors.deepPurple.shade900,
        value: 8.4,
      ),
    ],
  ),
  TestStripeModel(
    name: 'Total Alkalinity (ppm)',
    colorList: [
      ColorModel(
        color: Colors.green.shade50,
        value: 0,
      ),
      ColorModel(
        color: Colors.green.shade300,
        value: 40,
      ),
      ColorModel(
        color: Colors.green.shade600,
        value: 120,
      ),
      ColorModel(
        color: Colors.green.shade800,
        value: 180,
      ),
      const ColorModel(
        color: Colors.green,
        value: 240,
      ),
    ],
  ),
  TestStripeModel(
    name: 'Cyanuric Acid (ppm)',
    colorList: [
      ColorModel(
        color: Colors.brown.shade50,
        value: 0,
      ),
      ColorModel(
        color: Colors.brown.shade800,
        value: 50,
      ),
      ColorModel(
        color: Colors.red.shade500,
        value: 100,
      ),
      ColorModel(
        color: Colors.red.shade800,
        value: 150,
      ),
      ColorModel(
        color: Colors.deepPurple.shade900,
        value: 300,
      ),
    ],
  ),
];
