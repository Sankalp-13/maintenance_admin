import 'dart:convert';

OtpResponseModel otpResponseJson(String str) =>
    OtpResponseModel.fromJson(json.decode(str));

class OtpResponseModel {
  late final String? accessToken;
  late final String? refreshToken;

  OtpResponseModel({required this.accessToken,required this.refreshToken});

  OtpResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    return data;
  }
}
