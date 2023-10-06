import 'package:dio/dio.dart';

abstract class LoginState{}

class LoginInitialState extends LoginState{}

class LoginLoadingState extends LoginState{}

class OtpVerifiedState extends LoginState{}

class OtpSentState extends LoginState{
  final Response response;
  OtpSentState(this.response);
}

class InvalidEmailState extends LoginState{
  final String errorMsg;
  InvalidEmailState(this.errorMsg);
}

class LoginErrorState extends LoginState{
  final String error;
  LoginErrorState(this.error);
}

