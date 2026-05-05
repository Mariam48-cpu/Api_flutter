class TokenModel {
  String? accessToken;
  String? refreshToken;

  TokenModel({this.accessToken, this.refreshToken});

  TokenModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
  }


}