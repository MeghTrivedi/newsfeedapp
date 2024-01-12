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
