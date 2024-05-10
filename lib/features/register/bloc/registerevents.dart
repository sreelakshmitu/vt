abstract class RegisterEvent{}

class RegisterUserButtonClickedEvent extends RegisterEvent{
  
  final String username , password , confirmpassword;

  RegisterUserButtonClickedEvent({required this.username, required this.password, required this.confirmpassword});
}


class ToggleObscurePasswordEvent extends RegisterEvent{}

class ConfirmToggleObscureEvent extends RegisterEvent{}