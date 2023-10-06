import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maintenance_admin/domain/repository/assigned_job_repo.dart';
import 'package:maintenance_admin/domain/models/assigned_response_model.dart';
import 'package:maintenance_admin/providers/assigned_jobs/assigned_jobs_states.dart';

class CompletedJobCubit extends Cubit<AssignedJobState>{
  CompletedJobCubit(): super(AssignedJobLoadingState());
  final storage = const FlutterSecureStorage();
  AssignedRepo assignedJobsRepo = AssignedRepo();

  void completedJobs() async{
    try{
      emit(AssignedJobLoadingState());
      String? token = await storage.read(key: "accessToken");
      List<AssignedJobResponse> assignedJobs = await assignedJobsRepo.completedJobs(token!);
      emit(AssignedJobLoadedState(assignedJobs));
    }on DioException catch(ex){
      if(ex.type == DioExceptionType.badResponse) {
        emit(AssignedJobErrorState("Something went wrong"));
      }else if(ex.type == DioExceptionType.unknown||ex.type == DioExceptionType.connectionError||ex.type == DioExceptionType.connectionTimeout){
        emit(AssignedJobErrorState("Can't connect to server!"));
      }else{
        emit(AssignedJobErrorState(ex.type.toString()));
      }
    }
  }

}