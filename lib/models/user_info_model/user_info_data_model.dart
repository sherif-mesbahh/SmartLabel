class UserInfoDataModel {
  String? firstName;
  String? lastName;
  String? email;
  String? passwordHash;

  UserInfoDataModel({this.firstName, this.lastName, this.email, this.passwordHash});

  factory UserInfoDataModel.fromJson(Map<String, dynamic> json) => UserInfoDataModel(
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        email: json['email'] as String?,
        passwordHash: json['passwordHash'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'passwordHash': passwordHash,
      };
}
