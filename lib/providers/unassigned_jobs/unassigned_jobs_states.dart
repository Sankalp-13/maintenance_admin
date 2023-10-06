import 'package:maintenance_admin/domain/models/cleaners_response.dart';
import 'package:maintenance_admin/domain/models/unassigned_response_model.dart';

abstract class UnassignedJobState{}

class UnassignedJobInitialState extends UnassignedJobState{}

class UnassignedJobLoadingState extends UnassignedJobState{}

class UnassignedJobLoadedState extends UnassignedJobState{
  final List<UnassignedJobsResponse> response;
  final List<CleanersResponse> cleaners;
  UnassignedJobLoadedState(this.response, this.cleaners);
}

class UnassignedJobConfirmedState extends UnassignedJobState{
  final List<UnassignedJobsResponse> response;
  UnassignedJobConfirmedState(this.response);
}

class UnassignedJobErrorState extends UnassignedJobState{
  final String error;
  UnassignedJobErrorState(this.error);
}

