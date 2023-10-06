import 'package:maintenance_admin/domain/models/assigned_response_model.dart';

abstract class AssignedJobState{}

class AssignedJobLoadingState extends AssignedJobState{}

class AssignedJobLoadedState extends AssignedJobState{
  final List<AssignedJobResponse> response;
  AssignedJobLoadedState(this.response);
}

class AssignedJobErrorState extends AssignedJobState{
  final String error;
  AssignedJobErrorState(this.error);
}
