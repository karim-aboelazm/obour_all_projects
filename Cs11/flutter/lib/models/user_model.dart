class UserModel {
  late String email;
  late String name;
  late String username;

  UserModel({
    required this.email,
    required this.name,
    required this.username,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json["email"],
      name: json["name"],
      username: json["username"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "email": this.email,
      "name": this.name,
      "username": this.username,
    };
  }

}
