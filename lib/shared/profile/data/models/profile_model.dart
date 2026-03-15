// ── Profile Model ─────────────────────────────────────────────────────────────
class ProfileModel {
  final int id;
  final String name;
  final String phone;
  final String? email;
  final String? avatar;

  ProfileModel({
    required this.id,
    required this.name,
    required this.phone,
    this.email,
    this.avatar,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    id: json['id'] as int,
    name: json['name'] as String,
    phone: json['phone'] as String,
    email: json['email'] as String?,
    avatar: json['avatar'] as String?,
  );

  Map<String, dynamic> toJson() => {'name': name, 'email': email};

  ProfileModel copyWith({String? name, String? email, String? avatar}) =>
      ProfileModel(
        id: id,
        name: name ?? this.name,
        phone: phone,
        email: email ?? this.email,
        avatar: avatar ?? this.avatar,
      );
}
