import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/authenticationstate/authstate.bloc.dart';
import '../blocs/authenticationstate/authstate.event.dart';
import '../blocs/demo/demo.bloc.dart';
import '../blocs/demo/demo.event.dart';
import '../blocs/sigin/sigin.bloc.dart';
import '../blocs/sigin/sigin.event.dart';
import '../blocs/sigin/sigin.state.dart';
import '../pages/profil.page.dart';

class Email{


  Icon? prefixEmail = const Icon(Icons.email,color:  Colors.orange,);

 String? validator(String? value){

    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    return null;
  }

}


class Password{

  Icon? prefixPass = const Icon(Icons.key,color:  Colors.orange,);
   void Function(void Function())? setState;

 String? validator(String? value)
 {

    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }


 void onChanged(String value){


 }

}


class DateUtil{



 static String sinceSequences(int sinceEpoc){

    DateTime dateNow = DateTime.now();
    DateTime fromSinceEpoc = DateTime.fromMillisecondsSinceEpoch(sinceEpoc);
    Duration diff = dateNow.difference(fromSinceEpoc);

    int years = diff.inDays ~/ 365 ;
    int months = diff.inDays ~/ 30 - (years * 12);
    int days = diff.inDays - (years * 365) - (months * 30);
    int hours = diff.inHours - (years * 365 * 24) - (days * 24);
    int minutes = diff.inMinutes - (days * 24 * 60) - (hours * 60);
    int seconds = diff.inSeconds - (days * 24 * 60 * 60) - (hours * 60 * 60) - (minutes * 60);

    String sequence = "${years>0? "$years ${_plural(years,"year")}" :"" }${(months>0 && years<=0)? "$months ${_plural(months,"month")}" : "" }${(years<=0 && months<=0 && days>0 )? "$days ${_plural(days,"day")}": ""}${(years<=0 && months<=0 && days<=0 && hours>0)? "$hours ${_plural(hours, "hour")}":"" }${(years<=0 && months<=0 && days<=0 && hours<=0 && minutes>0)?"$minutes ${_plural(minutes, "minute")}" : ""}${(years<=0 && months<=0 && days<=0 && hours<=0 && minutes<=0 && seconds>0)?"$seconds ${_plural(seconds, "second")}" : ""}";

    return sequence.isNotEmpty? "$sequence ago": "";
  }

static String _plural(int number, String word)
  {
    return "$word${number>1?"s":""}";
  }

}


class PageTransitionUtils {

  static PageRouteBuilder slideTransitionUtils({required Widget child, Duration? duration, Curve? curveTarget, Tween<Offset>? tweenTarget}){

    return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
      return child ;
    },transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Tween<Offset> tween = tweenTarget?? Tween<Offset>(begin: const Offset(0, 0.98),end: Offset.zero);
      Curve curve = curveTarget?? Curves.decelerate;
      CurvedAnimation curvedAnimation = CurvedAnimation(parent: animation, curve: curve);
      Animation<Offset> animationOffset = tween.animate(curvedAnimation);
      return SlideTransition(position: animationOffset, child: child);
    },transitionDuration: duration?? const Duration(milliseconds: 300),opaque: true);
  }


  static PageRouteBuilder scaleTransitionUtils({required Widget child, Duration? duration, Curve? curveTarget, Tween<double>? tweenTarget}){

    return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
      return child ;
    },transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Tween<double> tween = tweenTarget?? Tween<double>(begin: 0,end:1);
      Curve curve = curveTarget?? Curves.decelerate;
      CurvedAnimation curvedAnimation = CurvedAnimation(parent: animation, curve: curve);
      Animation<double> animationOffset = tween.animate(curvedAnimation);
      return ScaleTransition(scale: animationOffset,
      child: child);
    },transitionDuration: duration?? const Duration(milliseconds: 300),opaque: true);
  }

  static PageRouteBuilder sizeTransitionUtils({required Widget child, Duration? duration, Curve? curveTarget, Tween<double>? tweenTarget}){

    return PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
      return child ;
    },transitionsBuilder: (context, animation, secondaryAnimation, child) {
      Tween<double> tween = tweenTarget?? Tween<double>(begin: 0,end:1);
      Curve curve = curveTarget?? Curves.decelerate;
      CurvedAnimation curvedAnimation = CurvedAnimation(parent: animation, curve: curve);
      Animation<double> animationOffset = tween.animate(curvedAnimation);
      return SizeTransition( sizeFactor: animationOffset,axis: Axis.vertical,
      child: child,);
    },transitionDuration: duration?? const Duration(milliseconds: 300),opaque: true);
  }
}

class AuthCheckingUtils{
  
 static checkValidationEmail(BuildContext context){
    FirebaseAuth.instance.userChanges().listen((event) async {

      if(event != null && event.emailVerified){
        if(context.read<SigInBloc>().state is UserEmailChecking){
          context.read<SigInBloc>().add(VerifiedEmail(user: event)) ;
          context.read<AuthStateBloc>().add(AuthenticatedEvent(user: event));
          context.read<DemoBloc>().add(GetDemo());
        }



      }else if(event != null ){

        try {
          //when app restarted on create user email check
          if(context.read<SigInBloc>().state is InitSigIn){
            context.read<SigInBloc>().add(EmailChecking(email: event.email));
          }
          await Future.delayed(const Duration(seconds: 5));
          await FirebaseAuth.instance.currentUser?.reload();
        } on Exception catch (e) {
          //do something here for resolve this error
        }
      }
    });

  }

 static checkAuth(BuildContext context){
    FirebaseAuth.instance.authStateChanges().listen((event) {

      if(event != null ){
        context.read<AuthStateBloc>().add(AuthenticatedEvent(user: event));
      }else if(event == null) {
        context.read<AuthStateBloc>().add(NotAuthenticatedEvent());
        // context.read<SigInBloc>().add(InitializeSigIn()) ;
        // context.read<LoginBloc>().add(InitializeLogin());
      }else if(!event.emailVerified) {
        //do something to block access without valid email verification
      }

    });

  }
}