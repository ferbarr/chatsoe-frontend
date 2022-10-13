// ignore_for_file: prefer_is_empty
import 'dart:io';
import 'package:chat/models/models.dart';
import 'package:chat/services/services.dart';
import 'package:chat/widgets/widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
   
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>with TickerProviderStateMixin{//Para alinear animaciones
  final _textController= TextEditingController();
  final _focusNode=FocusNode();
  bool _estaEscribiendo=false;
  late ChatService chatService;
  late SocketService socketService;
  late AuthService authService;
  final List<ChatMessage>_messages=[];//Lista de mensajes
  @override
  void initState() {
    super.initState();
    authService=Provider.of<AuthService>(context,listen: false);
    chatService=Provider.of<ChatService>(context,listen: false);
    socketService=Provider.of<SocketService>(context,listen: false);
    
    socketService.socket?.on('mensaje-personal', _escucharMensaje );
    _cargarHistorial(chatService.usuaroPara.uid!);
  }

  void _cargarHistorial(String usuarioID)async{
    List<Mensaje> chat=await chatService.getChat(usuarioID);
    final history=chat.map((m) =>
    ChatMessage(texto: m.mensaje,
    uid: m.from,
    animationController: AnimationController(vsync: this,duration: const Duration(microseconds: 0))..forward()
    ));

    setState(() {
      _messages.insertAll(0,history);
    });

  }
  
  void _escucharMensaje(dynamic data){
    ChatMessage message=ChatMessage(
      texto: data['mensaje'],
      uid: data['from'],
      animationController: AnimationController(vsync:this, duration: const Duration(milliseconds: 300)));
    setState(() {
      _messages.insert(0,message);
    });
    message.animationController.forward();//Ejecutar animacion
  
  }

  @override
  Widget build(BuildContext context) {
    final usuarioPara=chatService.usuaroPara;
    return  Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle:true,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Column(
          children: <Widget> [
            CircleAvatar(
              maxRadius: 20,
              backgroundColor: Colors.blue[100],
              backgroundImage: (usuarioPara.photo!=null && usuarioPara.photo!='')
              ?NetworkImage(usuarioPara.photo)
              :null,
              child: (usuarioPara.photo!=null && usuarioPara.photo!='')
              ?null
              :Text(usuarioPara.name.substring(0,2))
            ),
            const SizedBox(height: 3,),
             Text(usuarioPara.name,style: const TextStyle(color: Colors.black87,fontSize: 10),)

          ],
        ),
        actions: [
          IconButton(
            onPressed:()async{
              bool? res = await FlutterPhoneDirectCaller.callNumber(usuarioPara.phone);
            },
            icon: const Icon(Icons.phone_outlined,size: 30,color:Colors.green),
          ),
        ],
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
                onSubmitted:_estaEscribiendo
                 ?_handleSubmit
                 :null,
                onChanged: (String texto){//Recibe texto actual para bloquear boton
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
                  data: const IconThemeData(color: Color.fromRGBO(120,175,129,1)),
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
      texto: texto.trim(),
      uid: authService.usuario.uid!,
      animationController: AnimationController(vsync: this,duration: const Duration(milliseconds: 400)),
      
      );
    _messages.insert(0,newMessage);//Insertamos en la pos0
  
    _textController.clear();//Limpiamos
    _focusNode.requestFocus();//Cambiamos estado del foco
    newMessage.animationController.forward();//Agregar animacion a la instancia
    setState(() { _estaEscribiendo=false;});
    socketService.emit('mensaje-personal',{//Emitir evento al back
      'from':authService.usuario.uid,
      'to':chatService.usuaroPara.uid,
      'mensaje':texto
    });


  }
  @override
  void dispose() {


    for(ChatMessage message in _messages){
      message.animationController.dispose();//Limpiar las animaciones
    }
    socketService.socket?.off('mensaje-personal');
    super.dispose();
  }
}