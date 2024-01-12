import 'package:flutter/material.dart';

var listOfCountry = [
  {
    "name": "Canada",
    "code": "CA",
  },
  {
    "name": "United States",
    "code": "US",
  },
  {
    "name": "Mexico",
    "code": "MX",
  }
];

var listOfCategories = [
  "Business",
  "Entertainment",
  "General",
  "Health",
  "Science",
  "Sports",
  "Technology"
];

String getCountryCode(String countryName) {
  for (var country in listOfCountry) {
    if (country['name']!.toLowerCase() == countryName.toLowerCase()) {
      return country['code']!;
    }
  }
  return 'CA'; // Default to 'ca' if the country name is not found
}

Color colorGeneratorBasedOnIndex(int index) {
  final colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.purple,
  ].map((e) => e.withOpacity(0.5)).toList();

  return colors[index % colors.length];
}
