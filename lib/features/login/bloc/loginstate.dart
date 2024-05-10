abstract class LoginState{}


class LoginInitialState extends LoginState{}

class LoginLoadingState extends LoginState{}


class LoginAuthenticatedState extends LoginState{}


class LoginUnAuthenticatedState extends LoginState{
  
  final String errormessage;

  LoginUnAuthenticatedState({required this.errormessage});

}

class ToggleObscureValueChangedState extends LoginState{

  final bool isobscure;

  ToggleObscureValueChangedState({required this.isobscure});
}

class ValidationErrorState extends LoginState{

  final String errormessage;

  ValidationErrorState({required this.errormessage});

}

class UserRegistrationClickedState extends LoginState{}

