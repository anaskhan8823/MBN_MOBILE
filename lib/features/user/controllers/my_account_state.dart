part of 'my_account_cubit.dart';

class MyAccountState {}

final class MyAccountInitial extends MyAccountState {}
final class MyAccountLoading extends MyAccountState {}
final class UpdateObscurePassword extends MyAccountState {}
final class UpdateSwitch extends MyAccountState {}
final class ChangePlaceCountry extends MyAccountState {}
final class EditProfileInit extends MyAccountState {}
final class MyAccountSuccess extends MyAccountState {}
final class MyAccountFailure extends MyAccountState {
     final String errMsg;
     MyAccountFailure(this.errMsg);
}
