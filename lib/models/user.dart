class User {
  String username;
  String email;
  String password;
  String address;
  User(
      {required this.username,
      required this.email,
      required this.password,
      required this.address});

  factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        email: json["email"],
        password: json["password"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "password": password,
        "address": address,
      };
}
