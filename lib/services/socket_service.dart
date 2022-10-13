// ignore_for_file: constant_identifier_names

import 'package:chat/global/environment.dart';
import 'package:chat/services/auth_service.dart';

import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus {//Estados del server
  Online,
  Offline,
  Connecting
}


class SocketService with ChangeNotifier {

  ServerStatus _serverStatus = ServerStatus.Connecting;//Iniciar el estado del server
   IO.Socket? _socket;//Instanciar socket

  ServerStatus get serverStatus => _serverStatus;//Obtener estado del server
  
  IO.Socket? get socket => _socket;//Obtener socket
  Function get emit => _socket!.emit;//Obtener emits

  void connect() async {//Conectar al socket   

    final token=await AuthService.getToken();//Obtener token
    // Dart client
    _socket = IO.io( Environment.socketUrl , {//Configuracion del socket
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders':{//Send token en el header
        'x-token':token
      }
   
    });

    _socket?.on('connect', (_) {//Cuando se conecte
      _serverStatus = ServerStatus.Online;//Cambiar estado del server
      notifyListeners();
    });

    _socket?.on('disconnect', (_) {//Cuando se desconecte
      _serverStatus = ServerStatus.Offline;//Cambiar estado del server
      notifyListeners();
    });

  }


  void disconnect() {//Desconectar del socket
    _socket?.disconnect();
  }

}