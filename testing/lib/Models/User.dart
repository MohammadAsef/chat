class UserModel {
  String id;
  String userName;

  UserModel({
    this.id,
    this.userName,
  });

  static UserModel fromJson(Map json) => UserModel(
        id: json['email'],
        userName: json["username"],
      );

  Map tojson() {
    return {
      'email': id,
      'username': userName,
    };
  }
}
