

import 'package:chat/widgets/boton_form.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
   
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameCtrl=TextEditingController();
  final emailCtrl=TextEditingController();
  final passCtrl=TextEditingController();
  final numCtrl=TextEditingController();

   
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black), 
        elevation: 1,
        backgroundColor: Colors.white,
      ),
      body:Center(
        child: Container(
          
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: ListView(
           
            children:[
             
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:10),
                child: SingleChildScrollView(
                  child: Column(
                      children: [
                       
                       Container(
                        margin: const EdgeInsets.only(bottom: 10),
                         child: CircleAvatar(
                            maxRadius: 80,
                             backgroundColor: Colors.blue[200],
                            
                             child:  const Text('Fe')
                             ),
                       ),
                              
                        CustomInput(icon: Icons.perm_identity, 
                            placeholder: 'Nombre', 
                            textController: nameCtrl,
                            keyboardType: TextInputType.text,
                              ),
                        CustomInput(icon: Icons.phone_outlined,
                            placeholder: 'Número', 
                            textController: numCtrl,
                            keyboardType: TextInputType.number,
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
                      BotonForm(fn:(){
                        print(nameCtrl.text);
                        print(numCtrl.text);
                        print(emailCtrl.text);
                        print(passCtrl.text);
                      }, text: 'Actualizar',),
                      const SizedBox(height: 10,)
                  ]),
                ),
              )
            ]
          ),
        ),
      )
    );
  }

 
}



