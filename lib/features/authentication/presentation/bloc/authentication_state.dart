part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();  

  @override
  List<Object> get props => [];
}
class AuthenticationInitial extends AuthenticationState {}
class LoadingState extends AuthenticationState {}
class SignInstate extends AuthenticationState {}
class SignOutstate extends AuthenticationState {}
class ErrorState extends AuthenticationState {}
