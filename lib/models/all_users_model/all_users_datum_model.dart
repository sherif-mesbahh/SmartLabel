class AllUsersDatumModel {
  String? firstName;
  String? lastName;
  String? email;
  List<String>? roles;

  AllUsersDatumModel({this.firstName, this.lastName, this.email, this.roles});

  factory AllUsersDatumModel.fromJson(Map<String, dynamic> json) =>
      AllUsersDatumModel(
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        email: json['email'] as String?,
        roles: (json['roles'] as List?)?.map((e) => e.toString()).toList(),
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'roles': roles,
      };
}
