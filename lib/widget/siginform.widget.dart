import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modnsport/blocs/sigin/sigin.bloc.dart';
import 'package:modnsport/blocs/sigin/sigin.event.dart';
import 'package:modnsport/blocs/sigin/sigin.state.dart';

class SiginForm extends StatefulWidget {
  SiginForm({Key? key}) : super(key: key);

  @override
  State<SiginForm> createState() => _SiginFormState();

}

class _SiginFormState extends State<SiginForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Form(key: _formKey,
        child:BlocBuilder<SigInBloc,SigInState>(builder: (BuildContext context, state){
               if(state is InitSigIn){
                return Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                                builderEmail(controllerEmail: textEditingControllerEmail),
                                 builderPassword(controllerPassword: textEditingControllerPassword),
                                  buildSubmit()
                     ]);
               }

               if(state is UserCreating){
                 return const Center(child: CircularProgressIndicator(),);
               }

               if(state is UserCreatingFailed){
                 var error = state;
                 switch(error.errorMap["field"]){
                   case 'password':  return Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         builderEmail(controllerEmail: textEditingControllerEmail),
                         builderPasswordError(controllerPassword: textEditingControllerPassword),
                         buildSubmit()
                       ]);


                   case "email":    return  Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         builderEmailError(controllerEmail: textEditingControllerEmail),
                         builderPassword(controllerPassword: textEditingControllerPassword),
                         buildSubmit()
                       ]);

                   default : return Center(child: Text('ERROR: ${error.errorMap["error"]}',style: TextStyle(fontSize: 20,color: Colors.red)),);
                 }}

               return Center(child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text('email : ${(state as UserCreated).user!.email}'),
                   Text('verified : ${(state).user!.emailVerified}')
                 ],
               ),);
        },)

      )

    );
  }









 Widget buildSubmit(){

    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child:  ElevatedButton(
        onPressed: () {
          // Validate will return true if the form is valid, or false if
          // the form is invalid.
          if (_formKey.currentState!.validate()) {
            context.read<SigInBloc>().add(CreatingUser(email: textEditingControllerEmail.value.text, password: textEditingControllerPassword.value.text));
          }
        },
        child: const Text('Subscribe'),
      ),
    );
 }



  Widget builderEmail({required TextEditingController controllerEmail}){

    Widget widget = TextFormField(
        controller: controllerEmail,
        decoration: const InputDecoration(
          hintText: 'Email',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please enter email text';
          }
          return null;
        }) ;

    return widget;
  }




  Widget builderEmailError({required TextEditingController controllerEmail}){

    Widget widget = TextFormField(
        controller: controllerEmail,
        decoration: const InputDecoration(
          hintText: 'Email',
          errorText: "email-already-in-use"
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please enter email text';
          }
          return null;
        }) ;

    return widget;
  }


  Widget builderPassword({required TextEditingController controllerPassword}){

    Widget widget = TextFormField(
        controller: controllerPassword,
        obscureText: false,
        decoration: const InputDecoration(
          hintText: 'Password',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please enter password text';
          }
          return null;
        }) ;

    return widget;
  }




  Widget builderPasswordError({required TextEditingController controllerPassword}){

    Widget widget = TextFormField(
        controller: controllerPassword,
        obscureText: false,
        decoration: const InputDecoration(
          errorText: "The password provided is too weak",
          hintText: 'Password',
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Please enter password text';
          }
          return null;
        }) ;

    return widget;
  }
}







