class User {
  final String uid;
  final String email;
  final String? name;
  final String? userCountry;
  final List<String>? categories;

  User(
      {required this.uid,
      required this.email,
      this.name,
      this.userCountry,
      this.categories});

  // Make into JSON object
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'name': name,
        'userCountry': userCountry,
        'categories': categories,
      };
}
