import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maintenance_admin/domain/repository/employees_repo.dart';
import 'package:maintenance_admin/domain/models/cleaners_response.dart';
import 'package:maintenance_admin/providers/employees/employees_state.dart';

class EmployeesCubit extends Cubit<EmployeesState>{
  EmployeesCubit(): super(EmployeesLoadingState());
  final storage = const FlutterSecureStorage();
  EmployeesRepo employeesRepo = EmployeesRepo();

  void getEmp() async{
    try{
      emit(EmployeesLoadingState());
      String? token = await storage.read(key: "accessToken");
      List<CleanersResponse> cleaner = await employeesRepo.cleaners(token!);
      emit(EmployeesLoadedState(cleaner));
    }on DioException catch(ex){
      if(ex.type == DioExceptionType.badResponse) {
        emit(EmployeesErrorState("Something went wrong"));
      }else if(ex.type == DioExceptionType.unknown||ex.type == DioExceptionType.connectionError||ex.type == DioExceptionType.connectionTimeout){
        emit(EmployeesErrorState("Can't connect to server!"));
      }else{
        emit(EmployeesErrorState(ex.type.toString()));
      }
    }
  }

}