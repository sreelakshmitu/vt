import 'dart:async';
import '../../../errormessages.dart';
import 'package:bloc/bloc.dart';
import 'package:vegtech/features/login/bloc/loginevent.dart';
import 'package:vegtech/features/login/bloc/loginstate.dart';
import 'package:vegtech/features/login/repository/loginrepository.dart';



class LoginBloc extends Bloc<LoginEvent,LoginState>{

  bool _isObsure=true;

  LoginBloc():super(LoginInitialState()){
   on<LoginButtonClickedEvent>(loginbuttonclickedevent);
   on<ToggleObscureEvent>(toggleobscureevent);
  }

  

  FutureOr<void> loginbuttonclickedevent(LoginButtonClickedEvent event, Emitter<LoginState> emit) async{

    if (event.username.isEmpty && event.password.isEmpty) {
        emit(ValidationErrorState(errormessage:ErrorMessages.emptyCredentials));
      } else if (event.username.isEmpty) {
        emit(ValidationErrorState(errormessage:ErrorMessages.emptyUsername));
      } else if (event.password.isEmpty) {
        emit(ValidationErrorState(errormessage:ErrorMessages.emptyPassword));
      } else if (event.password.length < 8) {
        emit(ValidationErrorState(errormessage:ErrorMessages.shortPassword));
      } else{
        emit(LoginLoadingState());
        bool success = await LoginRepo.login(event.username, event.password);
        if (success) {
        emit(LoginAuthenticatedState());
      } else {
        emit(LoginUnAuthenticatedState(errormessage:ErrorMessages.invalidCredentials));
      }
      }
    
  }

  FutureOr<void> toggleobscureevent(ToggleObscureEvent event, Emitter<LoginState> emit) {
    _isObsure=!_isObsure;
    emit(ToggleObscureValueChangedState(isobscure: _isObsure));
  }
}


