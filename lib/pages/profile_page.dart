// ignore_for_file: use_build_context_synchronously
import 'dart:io';

import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/services.dart';

import 'package:chat/ui/input_decoration.dart';
import 'package:chat/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';



class ProfilePage extends StatelessWidget {

   const ProfilePage({Key? key}) : super(key: key);

   
  @override
  Widget build(BuildContext context) {
    final authService=Provider.of<AuthService>(context);
    final usuario=authService.usuario;
    return  Scaffold(
      backgroundColor:const Color.fromARGB(255, 232, 232, 232),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black), 
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body:Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
            
              CardContainer(
                child: Column(
                  children: [   
                    _Avatar(usuario: usuario, authService: authService,),
                    const SizedBox(height: 10,),
                    _LoginForm(usuario: usuario,)
                  ],
                ),
              ),

            ],
           
        
          ),
        ),
      )
    );
  }

 
}

class _Avatar extends StatelessWidget {
  final usuario;
  final authService;
  const _Avatar({
    Key? key,required this.usuario,required this.authService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
         children:[
          
          CircleAvatar(
             maxRadius: 60,
              backgroundColor: Colors.blue[100],
              child:
             (usuario.photo!=null)
              ?ClipOval(child: getImage(usuario.photo))
              :Text(usuario.name.substring(0,2)),
              ),
          Positioned(
            right: 1,                            
            child: IconButton(onPressed: ()async{
              final picker= ImagePicker();
              final XFile? selectedFile=await picker.pickImage(source: ImageSource.gallery,imageQuality: 100);
              if(selectedFile==null){
                print('No hay foto');
              }else{
                authService.showImage(selectedFile.path);
                                 
              }

            }, icon: const Icon(Icons.camera_alt_outlined,size: 40,color: Colors.black87,))),
         ] 
       );
  }
   getImage(String? picture){
    if(picture==null){
      return null;
    }
    if(picture.startsWith('http')){
      return NetworkImage(picture);
    }
    return Image.file(File(picture));
    

  }
}

class _LoginForm extends StatelessWidget {
  final usuario;
  const _LoginForm({Key? key,required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService=Provider.of<AuthService>(context);
    return Container(
      child: Form(
        key: authService.updateKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              initialValue: usuario.name,
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
            const SizedBox(height: 5,),
            TextFormField(
              initialValue: usuario.phone,
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
            const SizedBox(height: 5,),
            TextFormField(
              initialValue: usuario.email,
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
            const SizedBox(height: 5,),
            TextFormField(
              onChanged: (value){
                authService.password=value;
              },
              validator: (value){
                if(value!=''){
                  return (value!.length>=6)?null:'Mínimo 6 caracteres';
                }
              },
              obscureText: true,
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(//Reutilizamos diseño
                hintText: 'Ingresa tu contraseña', labelText: 'Contraseña', prefixIcon: Icons.key_outlined)
            ),
            const SizedBox(height: 5,),
            MaterialButton(
              onPressed: 
              authService.autenticando
              ?null
              :
              ()async{
                authService.isValidUpdate();
                // if(authService.isValidRegister()){
                //   FocusScope.of(context).unfocus();//Quitar el foco donde se encuentre
                //  final registroOk= await authService.register();
                //  if(registroOk==true){
                //     Navigator.pushReplacementNamed(context, 'usuarios');
                //  }else {
                //     mostrarAlerta(context,'Datos incorrectos',registroOk['msg']);
                //   }

                // }                 
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: const Color.fromARGB(255, 48, 92, 132),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 90),
                child:  Text(authService.autenticando?'Espere...':'Actualizar',style: const TextStyle(color:Colors.white)),

              ),
              ),
          ],
        ),
      ),
    );
  }
}


