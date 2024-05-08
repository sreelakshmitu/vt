import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{

  @override
  List<Object?> get props =>[];
}

class LoginInitialState extends LoginState{}

class LoginLoadingState extends LoginState{}

class LoginAuthenticatedState extends LoginState{}

class LoginUnAuthenticatedState extends LoginState{
  
  final String errormessage;

  LoginUnAuthenticatedState({required this.errormessage});

}

class ValidationErrorState extends LoginState{

  final String errormessage;

  ValidationErrorState({required this.errormessage});


}

class UserRegistrationSuccessState extends LoginState{}

class UserRegistrationUnSuccessfulState extends LoginState{

  final String errormessage;

  UserRegistrationUnSuccessfulState({required this.errormessage});

}

class ObscureTextValueChangedState extends LoginState{

  final bool obscuretext;

  ObscureTextValueChangedState({required this.obscuretext});

}