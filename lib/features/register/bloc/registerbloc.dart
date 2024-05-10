import 'dart:async';
import 'package:vegtech/features/register/bloc/registerevents.dart';
import 'package:vegtech/features/register/bloc/registerstate.dart';
import 'package:vegtech/features/register/repository/registerrepo.dart';
import '../../../textmessages.dart';
import 'package:bloc/bloc.dart';


class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{

  bool _isObscure=true;

  bool _confirmisObscure=true;

  RegisterBloc():super(RegisterInitialState()){
  on<RegisterUserButtonClickedEvent>(registerbuttonclickedevent);
  on<ToggleObscurePasswordEvent>(toggleobscureevent);
  on<ConfirmToggleObscureEvent>(confirmtoggleobscureevent);
  }

  FutureOr<void> registerbuttonclickedevent(RegisterUserButtonClickedEvent event, Emitter<RegisterState> emit) async{
    if (event.username.isEmpty && event.password.isEmpty) {
        emit(ValidationErrorState(errormessage:TextMessages.emptyCredentials));
      } else if (event.username.isEmpty) {
        emit(ValidationErrorState(errormessage:TextMessages.emptyUsername));
      } else if (event.password.isEmpty) {
        emit(ValidationErrorState(errormessage:TextMessages.emptyPassword));
      } else if (event.password.length < 8) {
        emit(ValidationErrorState(errormessage:TextMessages.shortPassword));
      } else{
          if(event.password==event.confirmpassword){
           
           bool success = await RegisterRepo.login(event.username, event.password);
           
           if (success) {
           
           emit(RegisterUserSuccessState());
      }    
           else {
           
           emit(RegisterUserUnSuccessfulState(errormessage:TextMessages.genericerror));
      }
          }
          else{
          
           emit(ValidationErrorState(errormessage:TextMessages.passwordmismatch));
          
          }
      }
  }

   FutureOr<void> toggleobscureevent(ToggleObscurePasswordEvent event, Emitter<RegisterState> emit) {
    
    _isObscure=!_isObscure;
    emit(ToggleObscureValueChangedState(isobscure: _isObscure));
  
  }

  FutureOr<void> confirmtoggleobscureevent(ConfirmToggleObscureEvent event, Emitter<RegisterState> emit) {
    
    _confirmisObscure=!_confirmisObscure;
    emit(ConfirmToggleObscureValueChangedState(obscure:_confirmisObscure));
  
  }
}