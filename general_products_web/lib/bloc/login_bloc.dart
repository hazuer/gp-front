
import 'dart:async';
import 'package:general_products_web/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators{

  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();


  Stream<String> get emailStream => _emailController.stream.transform(validateEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validatePassword);

  Stream<bool> get formLoginStream =>
     Rx.combineLatest2(emailStream, passwordStream, (e,p) => true);

  Stream<bool> get emailRecoverStream =>
     Rx.combineLatest2(emailStream, emailStream, (e,p) => true);

     

  
  // Insertar valores al stream
  Function (String) get changeEmail    =>_emailController.sink.add;
  Function (String) get changePassword =>_passwordController.sink.add;

  //Obtener el ultimo valor ingresado a los streams
  /*String get email   => _emailController.value;
  String get password => _passwordController.value; */

  dispose(){
    _emailController.close();
    _passwordController.close();
  }

  

}
