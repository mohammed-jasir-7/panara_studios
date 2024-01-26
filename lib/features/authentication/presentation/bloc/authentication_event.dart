part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}


class SignInEvent extends AuthenticationEvent{
  
}
class SignOutEvent extends AuthenticationEvent{

}
class InitalAuthenticationEvent extends AuthenticationEvent{

}