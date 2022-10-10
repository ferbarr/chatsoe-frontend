import 'package:chat/global/environment.dart';
import 'package:chat/models/models.dart';
import 'package:chat/services/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService with ChangeNotifier{
  late Usuario usuaroPara;

  Future getChat(String usuarioID)async{
    final uri=Uri.parse('${Environment.apiUrl}/msg/get-msg/$usuarioID');
    String? token = await AuthService.getToken();
    final resp=await http.get(uri,
      headers: {
        'Content-Type':'application/json',
        'x-token':token.toString()
      }
    );

    final mensajesResp=mensajesResponseFromJson(resp.body);
    return mensajesResp.mensajes;

  }
}