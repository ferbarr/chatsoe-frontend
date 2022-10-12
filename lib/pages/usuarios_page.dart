import 'package:chat/models/models.dart';
import 'package:chat/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
   
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarioService=UsuariosService();
  late SocketService socketService;
  final RefreshController _refreshController=RefreshController(initialRefresh: false);//Guardar controlador del push refresh
  List<Usuario> usuarios=[];

  @override
  void initState() {
    _cargarUsuarios();

  socketService=Provider.of<SocketService>(context,listen: false);
    
  socketService.socket.on('update-estado', (data)=>{_cargarUsuarios()} );


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authService=Provider.of<AuthService>(context);
    final socketService=Provider.of<SocketService>(context);
    final usuario=authService.usuario;
    return  Scaffold(
      
      appBar: AppBar(
        leading: Container(
            margin: const EdgeInsets.only(right: 10),
            child: 
             Icon(Icons.offline_bolt,color:(socketService.serverStatus==ServerStatus.Online)
            ?Colors.green
            :Colors.red
            )
            ),
            
            
          
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title:  GestureDetector(
          onTap: ()=>Navigator.pushNamed(context, 'profile'),
          child: Text(usuario.name,
            style: const TextStyle(color: Colors.black54),),
        ),
        elevation: 1,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(icon:const Icon(Icons.logout_outlined,) , onPressed: () { 
          socketService.disconnect();
          AuthService.deleteToken();
          Navigator.pushReplacementNamed(context, 'login');
         },)
          
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
      onTap: (){
        final chatService=Provider.of<ChatService>(context,listen: false);
        chatService.usuaroPara=usuario;
        Navigator.pushNamed(context, 'chat');
        
        },
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
    
    usuarios=await usuarioService.getUsuarios();
    setState(() { });
    _refreshController.refreshCompleted();//Cambiamos estado de controlador


  }

}