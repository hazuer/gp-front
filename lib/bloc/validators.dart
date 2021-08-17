import 'dart:async';

class Validators{

  final validateEmail=StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){

      String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp   = new RegExp(pattern); 

      if(regExp.hasMatch(email)){
        sink.add(email);
        
      }else{
        sink.addError('Por favor ingresa un correo electrónico válido');
      }
      
    }
  );


  
  final validateName=StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink){

      if(name.length >= 3){
        sink.add(name);
      }else{
        sink.addError('Introduzca un nombre correcto');
      }

    }
  );

  final validateLastname = StreamTransformer<String, String>.fromHandlers(
    handleData: (lastname, sink){

      if(lastname.length >= 3){
        sink.add(lastname);
      }else{
        sink.addError('Introduzca un apellido correcto');
      }

    }

  );
  

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){

      if(password.length >= 8){
        sink.add(password);
      }else{
        sink.addError('Debe contener al menos 8 caracteres');
      }

    }

  );

  


}
