import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegtech/config/theme/colors.dart';
import 'package:vegtech/features/home/screens/homescreen.dart';
import 'package:vegtech/features/login/bloc/loginevent.dart';
import 'package:vegtech/features/login/bloc/loginstate.dart';
import '../bloc/loginbloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode usernamefocusnode=FocusNode();
  final FocusNode passwordfocusnode=FocusNode();
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  
  
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isObscure=true;
    
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(context),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            if (state is LoginLoadingState) {
              return const Center(
              child: CircularProgressIndicator(),
             );
      } else if (state is LoginUnAuthenticatedState) {
             return _buildLoginForm(context, state.errormessage, true);
      } else if (state is LoginAuthenticatedState) {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const Home()));
             return const SizedBox(); 
      } else if (state is ObscureTextValueChangedState) {
             isObscure = state.obscuretext;
             return _buildLoginForm(context, '', isObscure);
      } else {
             return _buildLoginForm(context, '', isObscure);
      }
      },

        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, String errorMessage,bool isObscure) {
    bool validateFields() {
  final username = usernameController.text;
  final password = passwordController.text;

  if (username.isEmpty && password.isEmpty) {
    BlocProvider.of<LoginBloc>(context).add(ValidateFieldEvent(
      username: '',
      password: '',
    ));
    return false;
  } else if (username.isEmpty) {
    BlocProvider.of<LoginBloc>(context).add(ValidateFieldEvent(
      username: '',
      password: password,
    ));
    return false;
  } else if (password.isEmpty) {
    BlocProvider.of<LoginBloc>(context).add(ValidateFieldEvent(
      username: username,
      password: '',
    ));
    return false;
  } else if (password.length < 8) {
    BlocProvider.of<LoginBloc>(context).add(ValidateFieldEvent(
      username: username,
      password: password,
    ));
    return false;
  }

  return true;
}

  return Center(
    child: Container(
        constraints: const BoxConstraints(maxWidth:400),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key:_formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text('名前',style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize:24),),
                const SizedBox(height:20),
                const Text('ログイン',style: TextStyle(color: primaryColor,fontWeight:FontWeight.bold,fontSize:24)),
                const SizedBox(height:20),
                TextFormField(
                  controller: usernameController,
                  focusNode: usernamefocusnode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (String value){
                    usernamefocusnode.unfocus();
                    FocusScope.of(context).requestFocus(passwordfocusnode);
                  },
                  decoration: InputDecoration(
                    hintText: 'ユーザー名',
                    hintStyle: const TextStyle(color:Colors.black,fontSize: 16),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color:secondaryColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color:secondaryColor.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(8),
                      ) 
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                 controller: passwordController,
                 focusNode: passwordfocusnode,
                 obscureText: true,
                 decoration: InputDecoration(
                 hintText: 'パスワード',
                 hintStyle: const TextStyle(color: Colors.black,fontSize: 16),
                 suffixIcon: IconButton(
                 onPressed: () {
                 BlocProvider.of<LoginBloc>(context).add(ToggleObscureTextEvent());
                 }, 
                  icon: isObscure? const Icon(Icons.visibility_off) : const Icon(Icons.visibility)
                ),
                border:OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color:secondaryColor)
                ),
               ),
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  style: ButtonStyle(
                      shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                       RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                       )
                      ),
                      minimumSize: MaterialStateProperty.all(const Size(200.0,50.0)),
                      backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                    ), 
                  onPressed: () {
                    if(validateFields()){
                    BlocProvider.of<LoginBloc>(context).add(LoginButtonClickedEvent(
                      username: usernameController.text,
                      password: passwordController.text,
                    ));
                    }
                  },
                  child: const Text('ログイン',style:TextStyle(color:Colors.white,fontSize: 16)),
                ),
                const SizedBox(height:20),
                ElevatedButton(
                  style: ButtonStyle(
                      shape:MaterialStateProperty.all<RoundedRectangleBorder>(
                       RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                       )
                      ),
                      minimumSize: MaterialStateProperty.all(const Size(200.0,50.0)),
                      backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                    ), 
                  onPressed: () {
                    if(validateFields()){
                    BlocProvider.of<LoginBloc>(context).add(LoginButtonClickedEvent(
                      username: usernameController.text,
                      password: passwordController.text,
                    ));
                    }
                  },
                  child: const Text('新しいユーザーを作成する',style:TextStyle(color:Colors.white,fontSize: 16)),
                ),
                if (errorMessage.isNotEmpty)
                  Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
      ),
  );
  }
}