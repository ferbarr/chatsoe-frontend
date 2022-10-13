import 'package:chat/global/environment.dart';
import 'package:chat/services/services.dart';
import 'package:http/http.dart' as http;
import 'package:chat/models/models.dart';

class UsuariosService{
  
   


   getUsuarios()async{
    try {
     final uri=Uri.parse('${Environment.apiUrl}/user/get-users');
     String? token = await AuthService.getToken();

     final resp=await http.get(uri,
      headers:{
        'Content-Type':'application/json',
        'x-token':token.toString()
      });

      final usuariosResponse=usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
      
    }
  }

    

}