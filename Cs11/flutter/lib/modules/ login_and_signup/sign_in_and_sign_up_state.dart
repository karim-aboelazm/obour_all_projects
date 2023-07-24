part of 'sign_in_and_sign_up_cubit.dart';

@immutable
abstract class SignInAndSignUpState {}

class SignInAndSignUpInitial extends SignInAndSignUpState {}

class ToggleToLoginSuccess extends SignInAndSignUpState {}
class ToggleToLoginLoading extends SignInAndSignUpState {}
class ToggleToSignupSuccess extends SignInAndSignUpState {}
class ToggleToSignupLoading extends SignInAndSignUpState {}

class SignupWithEmailLoading extends SignInAndSignUpState {}
class SignupWithEmailSuccess extends SignInAndSignUpState {}
class SignupWithEmailError extends SignInAndSignUpState {}

class LoginLoading extends SignInAndSignUpState {}
class LoginSuccess extends SignInAndSignUpState {}
class LoginError extends SignInAndSignUpState {}

class GetTokenLoading extends SignInAndSignUpState {}
class GetTokenSuccess extends SignInAndSignUpState {}
class GetTokenError extends SignInAndSignUpState {}