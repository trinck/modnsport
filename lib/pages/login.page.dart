import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modnsport/blocs/login/login.bloc.dart';
import '../blocs/login/login.event.dart';
import '../blocs/login/login.state.dart';
import '../utils/utils.dart' as utils;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();

}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  Icon? counterIconPass;
  Icon? counterIconEmail;




  @override
  Widget build(BuildContext context) {
 return Scaffold(
    body: Stack(fit: StackFit.expand,children: [Container(decoration:  const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/fitness.jpg"),fit: BoxFit.cover))),
      Container(decoration: const BoxDecoration(gradient: RadialGradient(colors: [Colors.transparent,Colors.black], radius:1.2 ))),
       Form(key: _formKey,
           child:BlocBuilder<LoginBloc,LoginState>(builder: (BuildContext context, state){
             if(state is InitLogin){
               return buildFormContainer(
                   listWidget: [
                     builderField(controller: textEditingControllerEmail,hint: "Email",validator: utils.Email().validator,counters: counterIconEmail, prefix: utils.Email().prefixEmail, filled: false),
                     const SizedBox(height: 5,),
                     builderField(controller: textEditingControllerPassword,hint: "Password", obscureText: true,validator: utils.Password().validator,counters: counterIconPass,prefix: utils.Password().prefixPass, filled: false),
                     const SizedBox(height: 8,),
                     buildSubmit(),
                     const SizedBox(height: 8,),
                     forgottenPasswordText(),
                     buildSigInText(),

                   ]
               );
             }

             if(state is UserAuthenticating){
               return const Center(child: CircularProgressIndicator(),);
             }

             if(state is UserAuthenticatingFailed){

               switch(state.errorMap["field"]){
                 case 'password':  return buildFormContainer(
                     listWidget: [
                       builderField(controller: textEditingControllerEmail,hint: "Email",validator: utils.Email().validator,counters: counterIconEmail, prefix:  utils.Email().prefixEmail,),
                       const SizedBox(height: 5,),
                       builderField(controller: textEditingControllerPassword,hint: "Password", error:state.errorMap["error"] ,validator: utils.Password().validator,counters: counterIconPass, prefix: utils.Password().prefixPass),
                       const SizedBox(height: 8,),
                       buildSubmit(),
                       const SizedBox(height: 8,),
                       forgottenPasswordText(),
                       buildSigInText(),
                     ]);


                 case "email":    return  buildFormContainer(
                     listWidget: [
                       builderField(controller: textEditingControllerEmail,hint: "Email", error:state.errorMap["error"] ,prefix:  utils.Email().prefixEmail,),
                       const SizedBox(height: 5,),
                       builderField(controller: textEditingControllerPassword,hint: "Password", prefix: utils.Password().prefixPass),
                       const SizedBox(height: 8,),
                       buildSubmit(),
                       const SizedBox(height: 8,),
                       forgottenPasswordText(),
                       buildSigInText(),
                     ]);

                 default : return buildFormContainer(
                     listWidget: [
                       builderField(controller: textEditingControllerEmail,hint: "Email",validator: utils.Email().validator,counters: counterIconEmail, prefix: utils.Email().prefixEmail ),
                       const SizedBox(height: 5,),
                       builderField(controller: textEditingControllerPassword,hint: "Password",validator: utils.Password().validator,counters: counterIconPass ,prefix: utils.Password().prefixPass),
                       const SizedBox(height: 8,),
                       buildSubmit(),
                       const SizedBox(height: 8,),
                       forgottenPasswordText(),
                       buildSigInText(),
                     ]);
               }}

             return const Center(child: CircularProgressIndicator(),);
           },)

       )
     ],),
  );



    /**/
  }









  Widget buildSubmit(){


  return   SizedBox(width: double.maxFinite,height: 45,
    child: OutlinedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)),onPressed:() {
        // Validate will return true if the form is valid, or false if
        // the form is invalid.
        if (_formKey.currentState!.validate()){
          context.read<LoginBloc>().add(AuthenticatingUser(email: textEditingControllerEmail.value.text, password: textEditingControllerPassword.value.text));
        }
      }, child: const Text('Connexion', style: TextStyle(color: Colors.white ),)),
  );

  }


  Widget buildSigInText(){

    return  InkWell(child: Text("Sig in?", style: TextStyle(color: Theme.of(context).primaryColor),),onTap:()=> Navigator.of(context).popAndPushNamed("sigin_demo"),);
  }
Widget forgottenPasswordText(){

    return  InkWell(child: Text("I forgotten my password?", style: TextStyle(color: Theme.of(context).primaryColor),),onTap:()=> null,);
  }



  Widget builderField({ToolbarOptions? toolbarOptions,String? helperText,IconButton? suffix,Icon? prefix,bool? filled,String? label,required TextEditingController controller, bool? obscureText,String? error, String? hint, String? Function(String? value)? validator,void Function(String value)? onChanged , Icon? counters }){

    Widget widget = TextFormField(

      onChanged: onChanged,enableSuggestions: true,style: const TextStyle(color: Colors.white,),
        obscureText: obscureText?? false,
        controller: controller,
        toolbarOptions: toolbarOptions,
        decoration:  InputDecoration(
          counter: counters,hintStyle: const TextStyle(color: Colors.white),
          errorText: error,
          hintText:  hint,
            filled: filled,
          prefixIcon: prefix,
          labelText: label,
          helperStyle: TextStyle(color: Theme.of(context).indicatorColor),
          suffixIcon: suffix,
          helperText: helperText,

          floatingLabelAlignment: FloatingLabelAlignment.start,
          border:const OutlineInputBorder()

        ),
        validator: validator
    ) ;

    return widget;
  }



 Widget buildFormContainer({required List<Widget> listWidget }){

  return Center(
    child: SingleChildScrollView(
       physics: const BouncingScrollPhysics(),
      child: Card(color: Colors.black12,
        elevation: 0,
        margin:  const EdgeInsets.symmetric(horizontal: 30.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
              children:listWidget
          ),
        ),
      ),
    ),
  );

  }
}







