part of 'home_cubit.dart';

 class HomeState {}

final class HomeInitial extends HomeState {}
final class HomeSuccess extends HomeState {
  final dynamic list;
  HomeSuccess(this.list);
}
final class HomeProductiveSuccess extends HomeState {
  final ProfileProductiveFamiliesModel list;
  HomeProductiveSuccess(this.list);
}
final class HomeLoading extends HomeState {}
