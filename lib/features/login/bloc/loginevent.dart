import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{
  
  @override

  List<Object?> get props => [];
}

class ToggleObscureTextEvent extends LoginEvent{}

class ValidateFieldEvent extends LoginEvent{
  final String username;
  final String password;

  ValidateFieldEvent({required this.username, required this.password});
}

class UserRegistrationButtonClickedEvent extends LoginEvent{

  final String username;
  final String password;

  UserRegistrationButtonClickedEvent({required this.username, required this.password});
  
}

class LoginButtonClickedEvent extends LoginEvent{
  final String username;
  final String password;

  LoginButtonClickedEvent({required this.username, required this.password});
 
   @override
   
   List<Object?> get props => [username,password];


}

