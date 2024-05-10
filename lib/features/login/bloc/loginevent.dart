abstract class LoginEvent{}


class LoginButtonClickedEvent extends LoginEvent{

  final String username , password;

  LoginButtonClickedEvent({required this.username, required this.password});

}

class ToggleObscureEvent extends LoginEvent{}
