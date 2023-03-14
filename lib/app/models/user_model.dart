import 'dart:convert';

class User {
  final String id;
  final String name;
  final String password;
  final String email;
  final String address;
  final String type;
  final String token;

  User(
      {
        required this.id,
        required this.name,
        required this.password,
        required this.email,
        required this.address,
        required this.type,
        required this.token
      });

  factory User.getNewEmpty()
  {
   return User(
       id: '',
       name: '',
       password: '',
       email: '',
       address: '',
       type: '',
       token: '',
   );
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "password": password,
      "address": address,
      "type": type,
      "token": token,
      "email":email,
    };
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      id: json["_id"] ?? '',
      name: json["name"] ?? '',
      password: json["password"] ?? '',
      address: json["address"] ?? '',
      type: json["type"] ?? '',
      token: json["token"] ?? '',
      email: json["email"] ?? '',
    );
  }

  String toJson() => json.encode(toMap());
  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
