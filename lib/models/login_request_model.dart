class LoginRequestModel {
  late final String? email;

  LoginRequestModel({required this.email});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['email'] = email;
    return data;
  }
}
