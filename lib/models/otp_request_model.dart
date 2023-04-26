class OtpRequestModel {
  late final String? otpId;
  late final int? otp;

  OtpRequestModel({required this.otpId,required this.otp});

  OtpRequestModel.fromJson(Map<String, dynamic> json) {
    otpId = json['otpId'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['otpId'] = otpId;
    data['otp'] = otp;
    return data;
  }
}
