import 'package:maintenance_admin/domain/models/cleaners_response.dart';

abstract class EmployeesState{}

class EmployeesLoadingState extends EmployeesState{}

class EmployeesLoadedState extends EmployeesState{
  final List<CleanersResponse> response;
  EmployeesLoadedState(this.response);
}

class EmployeesErrorState extends EmployeesState{
  final String error;
  EmployeesErrorState(this.error);
}
