import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maintenance_admin/domain/repository/login_repo.dart';
import 'package:maintenance_admin/providers/login/login_states.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit(): super(LoginInitialState());
  final storage = const FlutterSecureStorage();
  LoginRepo loginRepo = LoginRepo();

  void login(String otp) async{
    try{
      emit(LoginLoadingState());
      Response response = await loginRepo.login(otp);
      emit(OtpSentState(response));
    }on DioException catch(ex){
      if(ex.response?.statusCode==401||ex.response?.statusCode==400){
        emit(InvalidEmailState(ex.response!.data["message"]));
      }else if(ex.type == DioExceptionType.badResponse) {
        emit(LoginErrorState("Something went wrong"));
      }else if(ex.type == DioExceptionType.unknown||ex.type == DioExceptionType.connectionError||ex.type == DioExceptionType.connectionTimeout){
        emit(LoginErrorState("Can't connect!"));
      }else{
        emit(LoginErrorState(ex.type.toString()));
      }
    }
  }

  void otp(String otpId,int otp) async{
    try{
      emit(LoginLoadingState());
      Response response=await loginRepo.otp(otpId,otp);
      await storage.write(key: 'accessToken', value: response.data["accessToken"]);
      await storage.write(key: 'refreshToken', value: response.data["refreshToken"]);
      emit(OtpVerifiedState());
    }on DioException catch(ex){
     if(ex.type == DioExceptionType.badResponse) {
        emit(LoginErrorState("Invalid OTP"));
      }else if(ex.type == DioExceptionType.unknown||ex.type == DioExceptionType.connectionError||ex.type == DioExceptionType.connectionTimeout){
        emit(LoginErrorState("Can't connect!"));
      }else{
        emit(LoginErrorState(ex.type.toString()));
      }
    }
  }

}