class UserDm {
  final String id;
  final String name;
  final String email;
  final String? password;
  final String? phone;
  final int? avaterId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? token; // للـ login

  const UserDm({
    required this.id,
    required this.name,
    required this.email,
    this.password,
    this.phone,
    this.avaterId,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  /// factory من JSON object (زي register response)
  factory UserDm.fromJson(Map<String, dynamic> json) {
    return UserDm(
      id: json["_id"] ?? "",
      name: json["name"] ?? "",
      email: json["email"] ?? "",
      password: json["password"],
      phone: json["phone"],
      avaterId: json["avaterId"],
      createdAt: json["createdAt"] != null
          ? DateTime.tryParse(json["createdAt"])
          : null,
      updatedAt: json["updatedAt"] != null
          ? DateTime.tryParse(json["updatedAt"])
          : null,
    );
  }

  /// factory من token string (زي login response)
  factory UserDm.fromToken(
      String token, {
        required String email,
        String id = "",
        String name = "",
      }) {
    return UserDm(
      id: id,
      name: name,
      email: email,
      token: token,
    );
  }

  /// تحويل لـ JSON (لو احتجت تبعته للسيرفر أو تخزنه)
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "name": name,
      "email": email,
      "password": password,
      "phone": phone,
      "avaterId": avaterId,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "token": token,
    };
  }
}