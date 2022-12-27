import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modnsport/blocs/sigin/sigin.bloc.dart';
import 'package:modnsport/blocs/sigin/sigin.event.dart';
import 'package:modnsport/blocs/sigin/sigin.state.dart';
import '../utils/utils.dart' as utils;

import '../blocs/authenticationstate/authstate.bloc.dart';
import '../blocs/authenticationstate/authstate.state.dart';
import '../blocs/demo/demo.bloc.dart';
import '../blocs/demo/demo.event.dart';
import 'demo.widget.dart';
import 'home.page.dart';

class SigIn extends StatefulWidget {
  const SigIn({Key? key}) : super(key: key);

  @override
  State<SigIn> createState() => _SigInState();

}

class _SigInState extends State<SigIn> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();
  Icon? counterIconPass;
  Icon? counterIconEmail;



  @override
  Widget build(BuildContext context) {

   return Scaffold(
      body: Stack(fit: StackFit.expand,children: [Container(decoration:  const BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/dumbbell.jpg"),fit: BoxFit.cover))),
        Container(decoration: const BoxDecoration(gradient: RadialGradient(colors: [Colors.transparent,Colors.black], radius:1.2 ))),
        Form(key: _formKey,
            child:BlocBuilder<SigInBloc,SigInState>(builder: (BuildContext context, state){
              if(state is InitSigIn){
                return buildFormContainer(
                    listWidget: [
                      builderField(controller: textEditingControllerEmail,hint: "Email",validator: utils.Email().validator,counters: counterIconEmail, prefix: utils.Email().prefixEmail, filled: false),
                      const SizedBox(height: 5,),
                      builderField(controller: textEditingControllerPassword,hint: "Password", obscureText: true,validator: utils.Password().validator,counters: counterIconPass,prefix: utils.Password().prefixPass, filled: false),
                      const SizedBox(height: 8,),
                      buildSubmit(),



                    ]
                );
              }

              if(state is UserCreating){
                return const Center(child: CircularProgressIndicator(),);
              }

              if(state is UserCreatingFailed){

                switch(state.errorMap["field"]){
                  case 'password':  return buildFormContainer(
                      listWidget: [
                        builderField(controller: textEditingControllerEmail,hint: "Email",validator: utils.Email().validator,counters: counterIconEmail, prefix:  utils.Email().prefixEmail,),
                        const SizedBox(height: 5,),
                        builderField(controller: textEditingControllerPassword,hint: "Password", error:state.errorMap["error"] ,validator: utils.Password().validator,counters: counterIconPass, prefix: utils.Password().prefixPass),
                        const SizedBox(height: 8,),
                        buildSubmit(),

                      ]);


                  case "email":    return  buildFormContainer(
                      listWidget: [
                        builderField(controller: textEditingControllerEmail,hint: "Email", error:state.errorMap["error"] ,prefix:  utils.Email().prefixEmail,),
                        const SizedBox(height: 5,),
                        builderField(controller: textEditingControllerPassword,hint: "Password", prefix: utils.Password().prefixPass),
                        const SizedBox(height: 8,),
                        buildSubmit(),


                      ]);

                  default : return buildFormContainer(
                      listWidget: [
                        builderField(controller: textEditingControllerEmail,hint: "Email",validator: utils.Email().validator,counters: counterIconEmail, prefix: utils.Email().prefixEmail ),
                        const SizedBox(height: 5,),
                        builderField(controller: textEditingControllerPassword,hint: "Password",validator: utils.Password().validator,counters: counterIconPass ,prefix: utils.Password().prefixPass),
                        const SizedBox(height: 8,),
                        buildSubmit(),
                        const SizedBox(height: 8,),
                        const Text("Error occurred, retry ",style: TextStyle(color: Colors.red),)

                      ]);
                }}

              if(state is UserEmailChecking){
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    Center(child: Text("An verification mail has been sent on address: ${(state).email}\n please check it, Look at spam if not visible "))
                  ],
                );
              }


              return const Center(child: CircularProgressIndicator(),);
            },)

        )
      ],),
    );


  }









  Widget buildSubmit(){

    return   SizedBox(width: double.maxFinite,height: 45,
      child: OutlinedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.orange)),onPressed:() {
        // Validate will return true if the form is valid, or false if
        // the form is invalid.
        if (_formKey.currentState!.validate()){
          context.read<SigInBloc>().add(CreatingUser(email: textEditingControllerEmail.value.text, password: textEditingControllerPassword.value.text));
        }
      }, child: const Text('Subscribe', style: TextStyle(color: Colors.white ),)),
    );
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
            padding: const EdgeInsets.only(left: 10,right: 10, bottom: 40),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Row(crossAxisAlignment: CrossAxisAlignment.start,children: [back()],),
                    Column(children: listWidget,)
                ]
            ),
          ),
        ),
      ),
    );

  }

 Widget back(){

    return IconButton(icon:  Icon(Icons.arrow_back,color: Theme.of(context).primaryColor), onPressed: () { Navigator.of(context).popAndPushNamed("landing"); },);
  }

  
}







