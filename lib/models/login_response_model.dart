import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  late final String? otpId;

  LoginResponseModel({required this.otpId});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    otpId = json['otpId'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['otpId'] = otpId;
    return data;
  }
}
