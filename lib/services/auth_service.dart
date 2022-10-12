import 'dart:convert';
import 'dart:io';
import 'package:chat/global/environment.dart';
import 'package:chat/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier{

  late Usuario usuario;
  File? newPictureFile;
  bool _autenticando=false;
  GlobalKey<FormState>loginKey=GlobalKey<FormState>();
  GlobalKey<FormState>registerKey=GlobalKey<FormState>();
  GlobalKey<FormState>updateKey=GlobalKey<FormState>();
  String email='';
  String password='';
  String name='';
  String phone='';
  bool lic=true;


  final _storage=const FlutterSecureStorage();

  bool isValidLogin(){//Validar el formulario login
   
    return loginKey.currentState?.validate()??false;
  }

  bool isValidRegister(){//Validar el formulario register
   
    return registerKey.currentState?.validate()??false;
  }

  bool isValidUpdate(){//Validar el formulario update
   
    return updateKey.currentState?.validate()??false;
  }
  
  static Future<String?>getToken()async{
    const storage= FlutterSecureStorage();
    final token=await storage.read(key: 'token');
    return token;
  }

  static Future<void>deleteToken()async{
    const storage= FlutterSecureStorage();
    await storage.delete(key: 'token');
  }

  bool get autenticando => _autenticando;

  set autenticando(bool value){
   _autenticando = value;
   notifyListeners();
 }

// void showImage(String path){
//   if(path!=''){
//     usuario.photo=path;
//     newPictureFile=File.fromUri(Uri(path: path));
//     notifyListeners();
//   }
// }

  Future login()async{
    autenticando=true;
    final data={
      'email':email,
      'password':password
    };

    final uri=Uri.parse('${Environment.apiUrl}/auth');

    final resp=await http.post(uri,
      body:jsonEncode(data),
      headers:{
        'Content-Type':'application/json'
    });
    
    if(resp.statusCode==200){
      
      final loginResponse= loginResponseFromJson(resp.body);
      
      usuario=loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      autenticando=false;
      return true;
    }else{
      final respBody=jsonDecode(resp.body);
      autenticando=false;
      return respBody;
    }

    


  }

  Future _guardarToken(String token)async{
    return await _storage.write(key: 'token', value: token);
  }

  Future logout()async{
    await _storage.delete(key: 'token');

  }

  Future register()async{
    autenticando=true;
    final data={
      'name':name,
      'email':email,
      'password':password,
      'phone':phone,
      'lic':lic
    };

    final uri=Uri.parse('${Environment.apiUrl}/auth/new');

    final resp=await http.post(uri,
      body:jsonEncode(data),
      headers:{
        'Content-Type':'application/json'
    });
     
    if(resp.statusCode==200){
      final loginResponse= loginResponseFromJson(resp.body);
      usuario=loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      autenticando=false;
      return true;
    }else{
      final respBody=jsonDecode(resp.body);
      autenticando=false;
      return respBody;
    }

  }

  Future isLoggedIn()async{
    final token=await _storage.read(key: 'token');
    final uri=Uri.parse('${Environment.apiUrl}/auth/renew');

    final resp=await http.get(uri,
      headers:{
        'Content-Type':'application/json',
        'x-token':token.toString()
    });
    
    if(resp.statusCode==200){
      final loginResponse= loginResponseFromJson(resp.body);
      usuario=loginResponse.usuario;
      await _guardarToken(loginResponse.token);
      return true;
    }else{
      logout();
      return false;
    }
  }

}