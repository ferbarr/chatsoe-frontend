import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage({super.key, required this.texto, required this.uid, required this.animationController});
 

  @override
  Widget build(BuildContext context) {
    return FadeTransition(//Agregar transiciones
      opacity: animationController,
      child: SizeTransition(//Transicion al cambiar tamaño
        sizeFactor: CurvedAnimation(parent: animationController,curve: Curves.easeOut),
        child: Container(
          child: uid=='123'
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
      child: Container(
        margin: const EdgeInsets.only(bottom: 5,left: 50,right: 5),
        decoration:  BoxDecoration(
          color: const Color(0xff4D9EF6),
          borderRadius: BorderRadius.circular(20)
        ),
        padding: const EdgeInsets.all(8.0),
        child: Text(texto,style: const TextStyle(color: Colors.white),),
      ),

    );
  }

  Widget _notMyMessage() {
    return Align(//Alinear widget
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5,left: 5,right: 50),
        decoration:  BoxDecoration(
          color: const Color(0xffE4E5E8),
          borderRadius: BorderRadius.circular(20)
        ),
        padding: const EdgeInsets.all(8.0),
        child: Text(texto,style: const TextStyle(color: Colors.black87),),
      ),

    );
  }
  
  
}