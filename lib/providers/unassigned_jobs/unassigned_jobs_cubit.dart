import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:maintenance_admin/domain/repository/unassigned_job_repo.dart';
import 'package:maintenance_admin/domain/models/cleaners_response.dart';
import 'package:maintenance_admin/domain/models/unassigned_response_model.dart';
import 'package:maintenance_admin/providers/unassigned_jobs/unassigned_jobs_states.dart';

class UnassignedJobCubit extends Cubit<UnassignedJobState>{
  UnassignedJobCubit(): super(UnassignedJobLoadingState());
  final storage = const FlutterSecureStorage();
  UnassignedRepo unassignedJobsRepo = UnassignedRepo();

  void getUnassignedJobsAndCleaners() async{
    try{
      emit(UnassignedJobLoadingState());
      String? token = await storage.read(key: "accessToken");
      List<UnassignedJobsResponse> unassignedJobs = await unassignedJobsRepo.unassignedJobs(token!);
      List<CleanersResponse> cleaners = await unassignedJobsRepo.cleaners(token);
      emit(UnassignedJobLoadedState(unassignedJobs,cleaners));
    }on DioException catch(ex){
      if(ex.type == DioExceptionType.badResponse) {
        emit(UnassignedJobErrorState("Something went wrong"));
      }else if(ex.type == DioExceptionType.unknown||ex.type == DioExceptionType.connectionError||ex.type == DioExceptionType.connectionTimeout){
        emit(UnassignedJobErrorState("Can't connect to server!"));
      }else{
        emit(UnassignedJobErrorState(ex.type.toString()));
      }
    }
  }

  void confirmAndRefreshUnassignedJobs(int jobId,int staffId) async{
    print("------------------------------------");
    try{
      String? token = await storage.read(key: "accessToken");
      await unassignedJobsRepo.confirmJob(jobId, staffId,token!);
      List<UnassignedJobsResponse> unassignedJobs = await unassignedJobsRepo.unassignedJobs(token);
      List<CleanersResponse> cleaners = await unassignedJobsRepo.cleaners(token);
      emit(UnassignedJobLoadedState(unassignedJobs,cleaners));
    }on DioException catch(ex){
      if(ex.type == DioExceptionType.badResponse) {
        emit(UnassignedJobErrorState("Something went wrong"));
      }else if(ex.type == DioExceptionType.unknown||ex.type == DioExceptionType.connectionError||ex.type == DioExceptionType.connectionTimeout){
        emit(UnassignedJobErrorState("Can't connect to server!"));
      }else{
        emit(UnassignedJobErrorState(ex.type.toString()));
      }
    }
  }

}