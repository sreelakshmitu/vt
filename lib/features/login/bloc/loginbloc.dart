import 'dart:async';
import '../../../textmessages.dart';
import 'package:bloc/bloc.dart';
import 'package:vegtech/features/login/bloc/loginevent.dart';
import 'package:vegtech/features/login/bloc/loginstate.dart';
import 'package:vegtech/features/login/repository/loginrepository.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginBloc extends Bloc<LoginEvent,LoginState>{

  bool _isObscure=true;
  

  LoginBloc():super(LoginInitialState()){
   on<LoginButtonClickedEvent>(loginbuttonclickedevent);
   on<ToggleObscureEvent>(toggleobscureevent);
   on<RegisterButtonClickedEvent>(registerbuttonclickedevent);
  }

  

  FutureOr<void> loginbuttonclickedevent(LoginButtonClickedEvent event, Emitter<LoginState> emit) async{

    if (event.username.isEmpty && event.password.isEmpty) {
        emit(ValidationErrorState(errormessage:TextMessages.emptyCredentials));
      } else if (event.username.isEmpty) {
        emit(ValidationErrorState(errormessage:TextMessages.emptyUsername));
      } else if (event.password.isEmpty) {
        emit(ValidationErrorState(errormessage:TextMessages.emptyPassword));
      } else if (event.password.length < 8) {
        emit(ValidationErrorState(errormessage:TextMessages.shortPassword));
      } else{
        emit(LoginLoadingState());
        bool success = await LoginRepo.login(event.username, event.password);
        if (success) {
        emit(LoginAuthenticatedState());
      } else {
        emit(LoginUnAuthenticatedState(errormessage:TextMessages.invalidCredentials));
      }
      }
    
  }

  FutureOr<void> toggleobscureevent(ToggleObscureEvent event, Emitter<LoginState> emit) {
    _isObscure=!_isObscure;
    emit(ToggleObscureValueChangedState(isobscure: _isObscure));
  }

  FutureOr<void> registerbuttonclickedevent(RegisterButtonClickedEvent event, Emitter<LoginState> emit) {
    emit(UserRegistrationClickedState());
  }
}


