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
        backgroundColor: const Color.fromARGB(255, 68, 114, 164),
        centerTitle: true,
        title: Text(usuario.name),
  
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

          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            
            child: Container(
              width: 150,
              height: 150,
     
              decoration: BoxDecoration(
                color: Colors.blue[100],
                shape: BoxShape.circle          
              ),
              child: 
              (usuario.photo!=null && usuario.photo!='')
              ?getImage(usuario.photo)
              :Center(child: Text(usuario.name.substring(0,2)),),
            ),
          ),
          
          Positioned(
            right: 1,                            
            child: IconButton(onPressed: ()async{
              final picker= ImagePicker();
              final XFile? selectedFile=await picker.pickImage(source: ImageSource.gallery);
              if(selectedFile==null){
          
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

      return FadeInImage(
        placeholder: const AssetImage('assets/loading-colors.gif'),
        image: NetworkImage(picture),
        fit: BoxFit.cover
        );
    }
    return Image.file(File(picture),fit: BoxFit.cover,  );
    

  }
}

class _LoginForm extends StatelessWidget {
  final usuario;
  final usuarioService=UsuariosService();
  
   _LoginForm({Key? key,required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String email=usuario.email;
    String? password;
    String name=usuario.name;
    String phone=usuario.phone;
    File? photo;

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
                name=value;
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
                phone=value;
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
                email=value;
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
                password=value;
              },
              validator: (value){
                if(value!=''){
                  return (value!.length>=8)?null:'Mínimo 8 caracteres';
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
                if(authService.isValidUpdate()){
                 FocusScope.of(context).unfocus();//Quitar el foco donde se encuentre
                 final String imageUrl=await authService.uploadImage()??'';
                final registroOk=await authService.updateUsuario(usuario.uid,imageUrl,name,phone,email,password);
                password='';
                if(registroOk!=true){
                  mostrarAlerta(context,'Ocurrio un error','Algo salio mal');
                }
                

                }                   
              },
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: const Color.fromARGB(255, 48, 92, 132),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 70),
                child:  Text(authService.autenticando?'Espere...':'Actualizar',style: const TextStyle(color:Colors.white)),

              ),
              ),
          ],
        ),
      ),
    );
  }
}


