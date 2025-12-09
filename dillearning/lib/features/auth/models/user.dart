class User {
  final int id;
  final String name;
  final String email;
  final String accessToken;
  final String tokenType;
  final DateTime expiresAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.accessToken,
    required this.tokenType,
    required this.expiresAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['user_id'],
      name: json['name'],
      email: json['email'],
      accessToken: json['access_token'],
      tokenType: json['token_type'],
      expiresAt: json.containsKey('expires_at')
          ? DateTime.parse(json['expires_at'])
          : DateTime.now().add(const Duration(minutes: 30)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': id,
      'name': name,
      'email': email,
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_at': expiresAt.toIso8601String(),
    };
  }
}
