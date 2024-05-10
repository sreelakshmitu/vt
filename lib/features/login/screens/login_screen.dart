import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegtech/config/colors/colors.dart';
import 'package:vegtech/features/home/screens/homescreen.dart';
import 'package:vegtech/features/login/bloc/loginbloc.dart';
import 'package:vegtech/features/login/bloc/loginevent.dart';
import 'package:vegtech/features/login/bloc/loginstate.dart';
import 'package:vegtech/features/register/screens/registerscreen.dart';
import 'package:vegtech/textmessages.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final FocusNode usernamefocusnode=FocusNode();
  final FocusNode passwordfocusnode=FocusNode();
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  final LoginBloc loginbloc=LoginBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc:loginbloc,
      listener: (context, state)=>{
        if(state is LoginAuthenticatedState){
          
          Navigator.push(context,MaterialPageRoute(builder: (context)=>const Home()))
        }
        else if(state is UserRegistrationClickedState){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const RegisterUser()))
        }
      },
      builder: (context, state) {
       switch(state.runtimeType){
        case LoginUnAuthenticatedState:
        final unauthstate=state as LoginUnAuthenticatedState;
        return _buildLoginForm(context,unauthstate.errormessage,true);
        case ValidationErrorState:
        final validerrorstate=state as ValidationErrorState;
        return _buildLoginForm(context,validerrorstate.errormessage,true);
        case ToggleObscureValueChangedState:
        final togglestate=state as ToggleObscureValueChangedState;
        return _buildLoginForm(context, '', togglestate.isobscure);
        default:
        return _buildLoginForm(context,'',true);
       }
      },
      );
  }
  Widget _buildLoginForm(BuildContext context, String errorMessage , bool isobscure) {
  
   return Scaffold(
        body:Center(
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
                  const Text(TextMessages.title,style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold,fontSize:24),),
                  const SizedBox(height:20),
                  const Text(TextMessages.login,style: TextStyle(color: primaryColor,fontWeight:FontWeight.bold,fontSize:24)),
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
                      hintText: TextMessages.username,
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
                   obscureText:isobscure,
                   decoration: InputDecoration(
                   hintText: TextMessages.password,
                   hintStyle: const TextStyle(color: Colors.black,fontSize: 16),
                   suffixIcon: IconButton(
                      icon: Icon(isobscure ? Icons.visibility_off: Icons.visibility),
                      onPressed: () {
                        loginbloc.add(ToggleObscureEvent());
                      },
                   ),
                  border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color:secondaryColor)
                  ),
                 ),
                  textInputAction: TextInputAction.done,
                  
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
                       
                       loginbloc.add(LoginButtonClickedEvent(username: usernameController.text, password: passwordController.text));
                      
                      },
                    child: const Text(TextMessages.login,style:TextStyle(color:Colors.white,fontSize: 16)),
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
                      loginbloc.add(RegisterButtonClickedEvent());
                    },
                    child: const Text(TextMessages.registernewuser,style:TextStyle(color:Colors.white,fontSize: 16)),
                  ),
                  const SizedBox(height:20),
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
        ),
      );
}
    
}