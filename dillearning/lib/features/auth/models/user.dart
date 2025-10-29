class User {
  final int id;
  final String name;
  final String email;
  final String accessToken;
  final String tokenType;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.accessToken,
    required this.tokenType,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_id'],
      name: json['name'],
      email: json['email'],
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'name': name,
      'email': email,
      'access_token': accessToken,
      'token_type': tokenType,
    };
  }
}
