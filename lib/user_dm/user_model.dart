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

  /// factory من JSON object (زي register response أو get profile)
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
      token: json["token"], // لو جاي مع الداتا
    );
  }

  /// factory مخصوص للـ login response
  factory UserDm.fromLoginJson(Map<String, dynamic> json, {String email = ""}) {
    return UserDm(
      id: "", // مش بييجي من login
      name: "", // مش بييجي من login
      email: email, // نمرره إحنا من الفورم أو من مكان التخزين
      token: json["data"], // التوكين
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

  UserDm copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? phone,
    int? avaterId,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? token,
  }) {
    return UserDm(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      avaterId: avaterId ?? this.avaterId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      token: token ?? this.token,
    );
  }
}