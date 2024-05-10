abstract class RegisterState{}


class RegisterUserSuccessState extends RegisterState{}


class RegisterUserUnSuccessfulState extends RegisterState{
  
  final String errormessage;

  RegisterUserUnSuccessfulState({required this.errormessage});

}

class ValidationErrorState extends RegisterState{
   
   final String errormessage;

   ValidationErrorState({required this.errormessage});
}


class RegisterInitialState extends RegisterState{}

class ToggleObscureValueChangedState extends RegisterState{
  
  final bool isobscure;

  ToggleObscureValueChangedState({required this.isobscure});
}

class ConfirmToggleObscureValueChangedState extends RegisterState{
  
  final bool obscure;

  ConfirmToggleObscureValueChangedState({required this.obscure});


}