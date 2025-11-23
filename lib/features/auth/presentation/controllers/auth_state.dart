
import 'package:dalil_2020_app/models/error_model.dart';

abstract class AuthStates {}

final class AuthInitial extends AuthStates {}
final class Success extends AuthStates {}
final class LoadingAuthState extends AuthStates {}
class ErrorState extends AuthStates {
  final List<Errors> listOfError;
  ErrorState({required this.listOfError});
}

final class UpdateObscurePassword extends AuthStates {}
final class AgreeToTermsInit extends AuthStates {}
final class AgreeToTermsSuccess extends AuthStates {}
final class ChangeUerTypeState extends AuthStates {}
final class EditProfileInit extends AuthStates {}
final class EditProfileLoading extends AuthStates {}
final class UpdateIndicator extends AuthStates {}
final class ChangePlaceCountry extends AuthStates {}


