class LoginDataModel {
  String? accessToken;
  String? refreshToken;

  LoginDataModel({this.accessToken, this.refreshToken});

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
        accessToken: json['accessToken'] as String?,
        refreshToken: json['refreshToken'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}
