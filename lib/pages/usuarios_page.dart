import 'package:chat/models/usuario.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
   
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final RefreshController _refreshController=RefreshController(initialRefresh: false);//Guardar controlador del push refresh
  final usuarios=[//Guardar los usuarios
    Usuario(online: true, email: 'Marisela@gmail.com', name: 'Marisela Aguilar Rodriguez', phone: '456', uid: '1', lic: true, photo: null),
    Usuario(online: false, email: 'Anabel@gmail.com', name: 'Anabel', phone: '456', uid: '2', lic: false, photo: null),
    Usuario(online: true, email: 'Daniel@gmail.com', name: 'Daniel Filoteo', phone: '456', uid: '3', lic: false, photo: null),
  ];
  @override
  Widget build(BuildContext context) {
    final authService=Provider.of<AuthService>(context);
    final usuario=authService.usuario;
    return  Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title:  Text(usuario.name,
          style: const TextStyle(color: Colors.black54),),
        elevation: 1,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle,color:Colors.blue[400]),
          )
        ],
      ),
      body: SmartRefresher(
        controller:_refreshController,//Asignar controlador
        enablePullDown: true,//permitir pull
        onRefresh: _cargarUsuarios,//Funcion
        header: WaterDropHeader(//Diseño del pull
          complete: Icon(Icons.check,color: Colors.blue[200],),//Cuando termine pull
          waterDropColor: Colors.blue,//Color del diseño
        ),
        child: _listViewUsuarios(),
        )
    );
  }

  ListView _listViewUsuarios() {//Metodo para crear ListView
    return ListView.separated(
      
      physics: const BouncingScrollPhysics(),//Rebote
      separatorBuilder: (_,i)=>const Divider(),//Separador
      itemCount: usuarios.length,//Iteracion
      itemBuilder: (_,i)=>_usuarioListTile(usuarios[i]),//Lo que construira
      );
  }

  ListTile _usuarioListTile(Usuario usuario) {//Metodo para ListTile y recibe info del usuario
    return ListTile(
      onTap: (){Navigator.pushNamed(context, 'chat');},
        title: Text(usuario.name,style: const TextStyle(fontSize: 16),),
        // subtitle: Text(usuario.email),
        leading: CircleAvatar(
          backgroundColor: Colors.blue[100],
          child: Text(usuario.name.substring(0,2)),
        ),
        trailing: Container(//Contenido a la derecha
          width:10,
          height: 10,
          decoration: BoxDecoration(
            color: usuario.online?Colors.green[300]:Colors.red[300],//Condicionar si esta en linea
            borderRadius: BorderRadius.circular(10)
          ),
        ),
      );
  }

  _cargarUsuarios()async{
    await Future.delayed(const Duration(milliseconds: 1000));//Temporizador de prueba
    usuarios.add(Usuario(online: true, email: 'Fernando@gmail.com', name: 'Fernando', phone: '456', uid: '1', lic: false, photo: null),);
    setState(() {
      
    });
    _refreshController.refreshCompleted();//Cambiamos estado de controlador


  }

}