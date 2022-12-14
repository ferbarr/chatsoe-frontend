import 'package:chat/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({super.key, required this.texto, required this.uid, required this.animationController});
 

  @override
  Widget build(BuildContext context) {
    final authService=Provider.of<AuthService>(context);
    return FadeTransition(//Agregar transiciones
      opacity: animationController,
      child: SizeTransition(//Transicion al cambiar tamaño
        sizeFactor: CurvedAnimation(parent: animationController,curve: Curves.easeOut),
        child: Container(
          child: uid==authService.usuario.uid
          ?_myMessage()
          :_notMyMessage()
          ,
        ),
      ),
    );
  }
  
  Widget _myMessage() {
    return Align(//Alinear widget
      alignment: Alignment.centerRight,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5,left: 100,right: 5),
            decoration:  BoxDecoration(
              color: const Color.fromRGBO(37,80,121,1),
              borderRadius: BorderRadius.circular(20)
            ),
            padding: const EdgeInsets.all(8.0),
            child: Text(texto,style: const TextStyle(color: Colors.white,fontSize: 15.5),),
          ),
          
        ],
      ),

    );
  }

  Widget _notMyMessage() {
    return Align(//Alinear widget
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5,left: 5,right: 50),
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        padding: const EdgeInsets.all(8.0),
        child: Text(texto,style: const TextStyle(color: Colors.black87),),
      ),

    );
  }
  
  
}