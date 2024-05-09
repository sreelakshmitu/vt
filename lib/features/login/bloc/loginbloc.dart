import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:vegtech/features/login/repository/loginrepository.dart';
import 'loginevent.dart';
import 'loginstate.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc():super(LoginInitialState()){
  on<ValidateFieldEvent>(validatefieldevent);
  on<UserRegistrationButtonClickedEvent>(userregistrationbuttonclickedevent);
  on<LoginButtonClickedEvent>(loginbuttonclickedevent);
  on<ToggleObscureTextEvent>(toggleobscuretextevent);
  }

  bool _isObscure = true;
  
  FutureOr<void> toggleobscuretextevent(ToggleObscureTextEvent event, Emitter<LoginState> emit) {
    _isObscure = !_isObscure;
      emit(ObscureTextValueChangedState(obscuretext: _isObscure));
  }
  
  FutureOr<void> loginbuttonclickedevent(LoginButtonClickedEvent event, Emitter<LoginState> emit) async{
    emit(LoginLoadingState());
      bool success = await LoginRepo.login(event.username, event.password);
      if (success) {
        emit(LoginAuthenticatedState());
      } else {
        emit(LoginUnAuthenticatedState(errormessage: 'ユーザー名かパスワードが無効'));
      }
  }

  FutureOr<void> validatefieldevent(ValidateFieldEvent event, Emitter<LoginState> emit) {
      
      if (event.username.isEmpty && event.password.isEmpty) {
        emit(ValidationErrorState(errormessage: '正しい資格情報を入力してください'));
      } else if (event.username.isEmpty) {
        emit(ValidationErrorState(errormessage: 'ユーザー名を空にすることはできません'));
      } else if (event.password.isEmpty) {
        emit(ValidationErrorState(errormessage: 'パスワードを空にすることはできません'));
      } else if (event.password.length < 8) {
        emit(ValidationErrorState(errormessage: 'パスワードは8文字以上である必要があります'));
      }
    }
  
  FutureOr<void> userregistrationbuttonclickedevent(UserRegistrationButtonClickedEvent event, Emitter<LoginState> emit)async{
     bool success = await LoginRepo.register(event.username, event.password);
      if (success) {
        emit(UserRegistrationSuccessState());
      } else {
        emit(UserRegistrationUnSuccessfulState(errormessage: 'ユーザー登録に失敗しました。もう一度やり直してください。'));
      }
  }
}

