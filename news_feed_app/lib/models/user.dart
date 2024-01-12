class User {
  final String uid;
  final String email;
  final String? name;
  final String? userCountry;
  final List<dynamic>? categories;

  User(
      {required this.uid,
      required this.email,
      this.name,
      this.userCountry,
      this.categories});

  // make a from JSON to User object
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      userCountry: json['userCountry'],
      categories: json['categories'],
    );
  }

  // Make into JSON object
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'name': name,
        'userCountry': userCountry,
        'categories': categories,
      };
}
