// ignore_for_file: avoid_unnecessary_containers, use_build_context_synchronously

import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/boton_form.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
   
  const LoginPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      body: Center(
        child: SafeArea(//Salvar area
          child: Container(
            height: MediaQuery.of(context).size.height*0.9,//Obtener el 90% del alto de la pantalla
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Logo(text: '',),
                  _Form(),
                  const Pie(ruta: 'register',),
                ],
              ),
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
  @override
  Widget build(BuildContext context) {
    final authService=Provider.of<AuthService>(context);
    return Container(
   
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children:    <Widget>[
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

            BotonForm(fn:authService.autenticando
            ?null
            : ()async{
              FocusScope.of(context).unfocus();//Quitar el foco donde se encuentre
             final loginOk= await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());
          
             if(loginOk==true){

              Navigator.pushReplacementNamed(context, 'usuarios');

             }else{
              mostrarAlerta(context,'Datos incorrectos',loginOk['msg']);
             }
             
             }
         
            , text: 'Ingresar',)
         
       
         
          
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
          const SizedBox(height: 5,),
          GestureDetector(
            child: Text('Crear una cuenta',
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
