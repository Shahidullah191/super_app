class UserModel {
  final int id;
  final String name;
  final String phone;
  final String? email;
  final String? avatar;
  final bool isVerified;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.avatar,
    this.isVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] as int,
    name: json['name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String?,
    avatar: json['avatar'] as String?,
    isVerified: json['is_verified'] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'email': email,
    'avatar': avatar,
    'is_verified': isVerified,
  };
}

class AuthResponseModel {
  final String token;
  final UserModel user;

  AuthResponseModel({required this.token, required this.user});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    return AuthResponseModel(
      token: data['token'] as String,
      user: UserModel.fromJson(data['user'] as Map<String, dynamic>),
    );
  }
}
