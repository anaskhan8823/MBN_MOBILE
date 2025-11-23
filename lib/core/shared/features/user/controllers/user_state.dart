part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class LoadingUser extends UserState {}

final class SuccessUser extends UserState {}

final class Error extends UserState {}
