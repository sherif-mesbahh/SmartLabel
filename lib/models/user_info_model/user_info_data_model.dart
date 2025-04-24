class UserInfoDataModel {
  String? firstName;
  String? lastName;
  String? email;
  String? passwordHash;
  List<String>? roles;

  UserInfoDataModel({
    this.firstName,
    this.lastName,
    this.email,
    this.passwordHash,
    this.roles,
  });

  factory UserInfoDataModel.fromJson(Map<String, dynamic> json) =>
      UserInfoDataModel(
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        email: json['email'] as String?,
        passwordHash: json['passwordHash'] as String?,
        roles: (json['roles'] as List<dynamic>?)
            ?.map((role) => role.toString())
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'passwordHash': passwordHash,
        'roles': roles,
      };
}
