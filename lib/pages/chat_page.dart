// ignore_for_file: prefer_is_empty

import 'dart:io';

import 'package:chat/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
   
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>with TickerProviderStateMixin{//Para alinear animaciones
  final _textController= TextEditingController();
  final _focusNode=FocusNode();
  bool _estaEscribiendo=false;
  List<ChatMessage>_messages=[];//Lista de mensajes
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle:true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget> [
            CircleAvatar(
              maxRadius: 14,
              backgroundColor: Colors.blue[100],
              child: const Text('Fe',style: TextStyle(fontSize: 12),
              ),
            ),
            const SizedBox(height: 3,),
            const Text('Fernando Barrera',style: TextStyle(color: Colors.black87,fontSize: 10),)

          ],
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(//Widget expandible
              child: ListView.builder(
                reverse: true,//Scroll hacia arriba
                physics: const BouncingScrollPhysics(),
                itemCount: _messages.length,
                itemBuilder: (_,i)=>_messages[i]
                
                ),
            ),
            const Divider(height: 1,),
            Container(//Caja de texto
            color: Colors.white,
            child: _inputChat(),
            )
          ],
        ),
      ),
      );
    
  }

  Widget _inputChat(){
    return SafeArea(
      child: Container(
        margin:const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String texto){//Recibe texto actual
                  setState(() {
                    if(texto.trim().length>0){
                      _estaEscribiendo=true;
                    }else{
                      _estaEscribiendo=false;
                    }
                  });
                },
                decoration: const InputDecoration.collapsed(
                  hintText: 'Enviar mensaje',
                  ),
                focusNode: _focusNode,//Manipular el foco
              )
              ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Platform.isIOS//Se construira dependiendo de la plataforma
              ?CupertinoButton(
                onPressed: _estaEscribiendo
                    ?()=>_handleSubmit(_textController.text.trim())
                    :null,
                child: const Text('Enviar')
                )
              :Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[400]),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: const Icon(Icons.send),
                    onPressed:_estaEscribiendo
                    ?()=>_handleSubmit(_textController.text.trim())
                    :null ,
                  ),
                ),
              )
            )
          ],
        ),
      )
      );
  }

  _handleSubmit(String texto){//Manejar el submit
    if(texto.length==0)return;
    final newMessage= ChatMessage(
      texto: texto,
      uid: '123',
      animationController: AnimationController(vsync: this,duration: const Duration(milliseconds: 400)),
      
      );
    _messages.insert(0,newMessage);//Insertamos en la pos0
    print(texto);
    _textController.clear();//Limpiamos
    _focusNode.requestFocus();//Cambiamos estado del foco
    newMessage.animationController.forward();//Agregar animacion a la instancia
    setState(() {
      _estaEscribiendo=false;
    });

  }
  @override
  void dispose() {
    // TODO:Dejar de escuchar socoket

    for(ChatMessage message in _messages){
      message.animationController.dispose();//Limpiar las animaciones
    }
    
    super.dispose();
  }
}