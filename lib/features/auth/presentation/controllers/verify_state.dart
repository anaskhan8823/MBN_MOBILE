part of 'verify_cubit.dart';

abstract class VerifyStates {}

class VerifyInit extends VerifyStates {}

class VerifyLoading extends VerifyStates {}
class UpdateObscurePassword extends VerifyStates {}
class ErrorVerifyState extends VerifyStates {
  final List<Errors> listOfError;
  ErrorVerifyState({required this.listOfError});
}
class VerifySuccess extends VerifyStates {}class UpdateIndicator extends VerifyStates {}