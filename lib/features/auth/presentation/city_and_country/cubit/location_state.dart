part of 'location_cubit.dart';

class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class ChangePlace extends LocationState {}

class LocationSuccess extends LocationState {}

class ErrorStates extends LocationState {
  final List<Errors> listOfError;
  ErrorStates({required this.listOfError});
}

class LocationError extends LocationState {
  final String? message;
  LocationError({this.message});
}
