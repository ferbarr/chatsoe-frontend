import 'dart:convert';
import 'dart:io';
import 'package:chat/global/environment.dart';
import 'package:chat/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService extends ChangeNotifier{

  late Usuario usuario;
  
  bool _autenticando=false;
  GlobalKey<FormState>loginKey=GlobalKey<FormState>();
  GlobalKey<FormState>registerKey=GlobalKey<FormState>();
  GlobalKey<FormState>updateKey=GlobalKey<FormState>();
  String email='';
  String password='';
  String name='';
  String phone='';
  File? newPictureFile;
 
  bool lic=true;


  final _storage=const FlutterSecureStorage();

  bool isValidLogin(){//Validar el formulario login
   
    return loginKey.currentState?.validate()??false;
  }

 bool isValidUpdate(){//Validar el formulario login
   
    return updateKey.currentState?.validate()??false;
  }

  bool isValidRegister(){//Validar el formulario register
   
    return registerKey.currentState?.validate()??false;
  }

 updateUsuario(dynamic id ,String photo,String name,String phone,String email,String? password)async{
    String? token = await AuthService.getToken();
    autenticando=true;
    final data={  
      '_id':id, 
      'photo':photo,
      'name':name,
      'email':email,
      'phone':phone,
      'password':password,
     

    };

    final uri=Uri.parse('${Environment.apiUrl}/user/update');

    final resp=await http.put(uri,
      body:jsonEncode(data),
      headers:{
        'Content-Type':'application/json',
        'x-token':token.toString()
    });
     
    if(resp.statusCode==200){
      final loginResponse= loginResponseFromJson(resp.body);
      usuario=loginResponse.usuario;
      autenticando=false;
      return true;
    }else{
      final respBody=jsonDecode(resp.body);
      autenticando=false;
      return respBody;
    }
  }
  
  static Future<String?>getToken()async{
    const storage= FlutterSecureStorage();
    final token=await storage.read(key: 'token');
    return token;
  }

  void showImage(String path){
  if(path!=''){
    usuario.photo=path;
    newPictureFile=File.fromUri(Uri(path: path));
    notifyListeners();
  }
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


 Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;
    autenticando = true;
    notifyListeners();
    // Preparamos la url
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dafdqsakr/image/upload?upload_preset=dup4yrrc');
    // Indicamos comose trabajara
    final imageUploadRequest = http.MultipartRequest('POST', url);
    // Agregamos el paramtro a la url con su valor
    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);
    // Agregamos el archivo a la request
    imageUploadRequest.files.add(file);
    // Ejecutamos la peticion
    final streamResponse = await imageUploadRequest.send();
    // Obtenemmos los datos de la respuesta
    final resp = await http.Response.fromStream(streamResponse);

    print(resp.body);
    // Verificamos que no hay errores
    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
    }
    newPictureFile = null;
    final decodeData = json.decode(resp.body);
    return decodeData['secure_url'];
  }





}