import 'package:memotask/Models/streakModel.dart';

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? password;
  DateTime? createdAt;
  DateTime? lastLoginAt;
  Streak? streak;

  UserModel({
    this.uid,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.lastLoginAt,
    this.streak,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    createdAt = DateTime.parse(json['createdAt']);
    lastLoginAt = DateTime.parse(json['lastLoginAt']);
    streak = Streak.fromJson(json['streak']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['createdAt'] = createdAt!.toIso8601String();
    data['lastLoginAt'] = lastLoginAt!.toIso8601String();
    data['streak'] = streak!.toJson();

    return data;
  }

  @override
  String toString() {
    return 'UserModel{id:$uid name: $name, email: $email, password: $password, createdAt: $createdAt, lastLoginAt: $lastLoginAt, streak: ${streak.toString()}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModel &&
          uid == other.uid &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          password == other.password &&
          createdAt == other.createdAt &&
          lastLoginAt == other.lastLoginAt &&
          streak == other.streak;
}
