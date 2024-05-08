import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:vegtech/features/home/screens/homescreen.dart';
import 'package:vegtech/features/login/repository/loginrepository.dart';
import 'package:vegtech/features/register/screens/registerscreen.dart';
import 'loginevent.dart';
import 'loginstate.dart';


class LoginBloc extends Bloc<LoginEvent,LoginState>{

  bool _isObscure=true;

  BuildContext context;

  LoginBloc(this.context):super(LoginInitialState());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
  if (event is ValidateFieldEvent) {
    // Handle the validation logic here
    if (event.username.isEmpty && event.password.isEmpty) {
      yield ValidationErrorState(errormessage: '正しい資格情報を入力してください');
    } else if (event.username.isEmpty) {
      yield ValidationErrorState(errormessage: 'ユーザー名を空にすることはできません');
    } else if (event.password.isEmpty) {
      yield ValidationErrorState(errormessage: 'パスワードを空にすることはできません');
    } else if (event.password.length < 8) {
      yield ValidationErrorState(errormessage: 'パスワードは8文字以上である必要があります');
    }
  }
  if(event is UserRegistrationButtonClickedEvent){
   bool success=await LoginRepo.register(event.username,event.password);
   if(success){
    yield UserRegistrationSuccessState();
    Navigator.push(context,MaterialPageRoute(builder: (context) => const RegisterUser()),
);


   }else{
    yield UserRegistrationUnSuccessfulState(errormessage:'ユーザー登録に失敗しました。もう一度やり直してください。');
   }
  }

  if (event is LoginButtonClickedEvent) {
    yield LoginLoadingState();

    bool success = await LoginRepo.login(event.username, event.password);

    if (success) {
      yield LoginAuthenticatedState();
      Navigator.push(context,MaterialPageRoute(builder: (context) => const Home()));
    
    } else {
      yield LoginUnAuthenticatedState(errormessage: 'ユーザー名かパスワードが無効'); //change message login failed, invalidcredentials
    }
  }

  if (event is ToggleObscureTextEvent) {
    _isObscure = !_isObscure;
    yield ObscureTextValueChangedState(obscuretext: _isObscure);
  }
}
}