class UserModel {
  final String? token;
  final User? user;

  UserModel({this.token, this.user});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'token': token,
    if (user != null) 'user': user!.toJson(),
  };

  UserModel copyWith({String? token, User? user}) {
    return UserModel(
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }
}

class User {
  final int? id;
  final String? name;
  final String? mobile;

  User({this.id, this.name, this.mobile});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'mobile': mobile,
  };

  User copyWith({int? id, String? name, String? mobile}) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
    );
  }
}
