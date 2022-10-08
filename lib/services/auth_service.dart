import 'dart:convert';
import 'package:chat/global/environment.dart';
import 'package:chat/models/login_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier{

  late Usuario usuario;
  bool _autenticando=false;
  bool _registrando=false;

  final _storage=const FlutterSecureStorage();
  
  static Future<String?>getToken()async{
    final _storage=const FlutterSecureStorage();
    final token=await _storage.read(key: 'token');
    return token;
  }

  static Future<void>deleteToken()async{
    const _storage= FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  bool get autenticando => _autenticando;

  set autenticando(bool value){
   _autenticando = value;
   notifyListeners();
 }

 bool get registrando => _registrando;

  set registrando(bool value){
   _registrando = value;
   notifyListeners();
 }

  Future login(String email, String password)async{
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

  Future register(String name,String email,String password,String phone,bool lic)async{
    registrando=true;
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
      registrando=false;
      return true;
    }else{
      final respBody=jsonDecode(resp.body);
      registrando=false;
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