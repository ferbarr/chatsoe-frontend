// ignore_for_file: avoid_unnecessary_containers

import 'package:chat/widgets/boton_form.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
   
  const RegisterPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: SafeArea(//Salvar area
        child: Container(
          height: MediaQuery.of(context).size.height*0.9,//Obtener el 90% del alto de la pantalla
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                
                const Logo(text:'Registro',),
                _Form(),
                const Pie(ruta: 'login',),
                const Text('Aviso de privacidad',style: TextStyle(fontWeight: FontWeight.w300),)
              ],
            ),
          ),
        ),
      )
    );
  }
}


// Formulario 
class _Form extends StatefulWidget {
  _Form({Key? key}) : super(key: key);

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  // Instanciar controladores, para obtener valors del input
  final emailCtrl=TextEditingController();
  final passCtrl=TextEditingController();
  final nameCtrl=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top:10),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children:    <Widget>[
          CustomInput(icon: Icons.perm_identity, 
          placeholder: 'Nombre', 
          textController: nameCtrl,
          keyboardType: TextInputType.text,
          ),

          CustomInput(icon: Icons.mail_outline, 
          placeholder: 'Correo electronico', 
          textController: emailCtrl,
          keyboardType: TextInputType.emailAddress,
          ),

          CustomInput(icon: Icons.lock_outline, 
          placeholder: 'Contraseña',
          isPassword: true, 
          textController: passCtrl,
          ),

            BotonForm(fn: (){
              print(emailCtrl.text);
              print(passCtrl.text);
              return 4;
           }, text: 'Registrar',)
         
       
         
          
        ],
      ),
    );
  }
}


class Pie extends StatelessWidget {
  final String ruta;
  const Pie({Key? key, required this.ruta}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children:  <Widget>[
          
          GestureDetector(
            child: Text('¿Ya tienes una cuenta?',
                      style: TextStyle(
                            color:Colors.blue.shade600,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
            onTap: (){
              Navigator.pushReplacementNamed(context, ruta);
            },
                      
                )

        ],
      ),
    );
  }
}
