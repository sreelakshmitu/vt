import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vegtech/config/colors/colors.dart';
import 'package:vegtech/textmessages.dart';
import '../bloc/registerbloc.dart';
import '../bloc/registerevents.dart';
import '../bloc/registerstate.dart';


class RegisterUser extends StatefulWidget {
  const RegisterUser({super.key});

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final TextEditingController usernameController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController confirmpasswordController=TextEditingController();
  final FocusNode usernamefocusnode=FocusNode();
  final FocusNode passwordfocusnode=FocusNode();
  final FocusNode confirmpasswordfocusnode=FocusNode();
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  final RegisterBloc registerbloc=RegisterBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc:registerbloc,
      listener: (context, state)=>{
        if(state is RegisterUserSuccessState){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>const RegisterUser()))
        }
       },
      builder: (context, state) {
       switch(state.runtimeType){
        case RegisterUserUnSuccessfulState:
        final unregstate=state as RegisterUserUnSuccessfulState;
        return _buildLoginForm(context,unregstate.errormessage,true,true);
        case ValidationErrorState:
        final validerrorstate=state as ValidationErrorState;
        return _buildLoginForm(context,validerrorstate.errormessage,true,true);
        case ConfirmToggleObscureValueChangedState:
        final confirmtogglestate=state as ConfirmToggleObscureValueChangedState;
        return _buildLoginForm(context, '', true, confirmtogglestate.obscure);
        case ToggleObscureValueChangedState:
        final togglestate=state as ToggleObscureValueChangedState;
        return _buildLoginForm(context, '', togglestate.isobscure,true);
        default:
        return _buildLoginForm(context,'',true,true);
       }
      },
      );
  }
  Widget _buildLoginForm(BuildContext context, String errorMessage , bool isobscure , bool confirmobscure) {
  
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
                  const Text(TextMessages.registernewuser,style: TextStyle(color: primaryColor,fontWeight:FontWeight.bold,fontSize:24)),
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
                        registerbloc.add(ToggleObscurePasswordEvent());
                      },
                   ),
                  border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color:secondaryColor)
                  ),
                 ),
                  ),
                  const SizedBox(height:20),
                  TextFormField(
                   controller: confirmpasswordController,
                   focusNode: confirmpasswordfocusnode,
                   obscureText:confirmobscure,
                   decoration: InputDecoration(
                   hintText: TextMessages.forgotpassword,
                   hintStyle: const TextStyle(color: Colors.black,fontSize: 16),
                   suffixIcon: IconButton(
                      icon: Icon(confirmobscure ? Icons.visibility_off: Icons.visibility),
                      onPressed: () {
                        registerbloc.add(ConfirmToggleObscureEvent());
                      },
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
                       
                       registerbloc.add(RegisterUserButtonClickedEvent(username: usernameController.text, password: passwordController.text,confirmpassword: confirmpasswordController.text));
                      
                      },
                    child: const Text(TextMessages.register,style:TextStyle(color:Colors.white,fontSize: 16)),
                  ),
                  const SizedBox(height: 20),
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