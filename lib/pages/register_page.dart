// ignore_for_file: use_build_context_synchronously

import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/services.dart';

import 'package:chat/ui/input_decoration.dart';
import 'package:chat/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
   
  const RegisterPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:const Color.fromARGB(255, 232, 232, 232),
      body: AuthBackground(
        logo: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 150,),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10,),
                    Text('Chatsoe',style: Theme.of(context).textTheme.headline4,),
                    const SizedBox(height: 30,),
                    const _LoginForm()
                  ],
                ),
              ),
              const SizedBox(height: 10,),
               TextButton(
                onPressed: ()=>Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(overlayColor: 
                MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                shape: MaterialStateProperty.all(const StadiumBorder())
                ),
                child: const Text('Ya tengo cuenta',style: TextStyle(fontSize: 18,color: Colors.black87),))

            ],
           
        
          ),
        ),
      )
    );
  }
}


class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService=Provider.of<AuthService>(context);
    final socketService=Provider.of<SocketService>(context);
    return Container(
      child: Form(
        key: authService.registerKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              onChanged: (value){
                authService.name=value;
              },
              validator: (value){
                return (value!='')?null:'Ingresa tu nombre';
              },
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(//Reutilizamos diseño
                hintText: 'Ingresa tu nombre', labelText: 'Nombre', prefixIcon: Icons.perm_identity)
            ),
            const SizedBox(height: 10,),
            TextFormField(
              onChanged: (value){
                authService.phone=value;
              },
              validator: (value){
                return (value!.length==10)?null:'Formato de teléfono inválido';
              },
              autocorrect: false,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(//Reutilizamos diseño
                hintText: 'Ingresa tu télefono', labelText: 'Télefono', prefixIcon: Icons.phone_outlined)
            ),
            const SizedBox(height: 10,),
            TextFormField(
              onChanged: (value){
                authService.email=value;
              },
              validator: (value){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp  = RegExp(pattern);
                return regExp.hasMatch(value??'')?null:'Formato de correo no válido';
              },
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(//Reutilizamos diseño
                hintText: 'Ingresa tu correo', labelText: 'Correo electrónico', prefixIcon: Icons.email_outlined)
            ),
            const SizedBox(height: 10,),
            TextFormField(
              onChanged: (value){
                authService.password=value;
              },
              validator: (value){
                return (value!.length>=8)?null:'Mínimo 8 caracteres';
              },
              obscureText: true,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(//Reutilizamos diseño
                hintText: 'Ingresa tu contraseña', labelText: 'Contraseña', prefixIcon: Icons.key_outlined)
            ),
            const SizedBox(height: 10,),
            MaterialButton(
              onPressed: 
              authService.autenticando
              ?null
              :
              ()async{
                if(authService.isValidRegister()){
                  FocusScope.of(context).unfocus();//Quitar el foco donde se encuentre
                 final registroOk= await authService.register();
                 if(registroOk==true){
                    socketService.connect();
                    Navigator.pushReplacementNamed(context, 'usuarios');
                 }else {
                    mostrarAlerta(context,'Datos incorrectos',registroOk['msg']);
                  }

                }                 
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: const Color.fromARGB(255, 48, 92, 132),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 70),
                child:  Text(authService.autenticando?'Espere...':'Registrar',style: TextStyle(color:Colors.white)),

              ),
              ),
          ],
        ),
      ),
    );
  }
}