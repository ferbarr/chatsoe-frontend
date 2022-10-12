import 'package:chat/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  
  @override
  Widget build(BuildContext context) {
    final socketService=Provider.of<SocketService>(context);
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _drawerHeader(),
          ListTile(leading: const Icon(Icons.account_circle_outlined),title: const Text('Perfil'),onTap: (){
              Navigator.pushNamed(context, 'profile');
            
          },),
         
          ListTile(leading: const Icon(Icons.logout,),title: const Text('Salir'),onTap: (){
            socketService.disconnect();
            AuthService.deleteToken();
            Navigator.pushReplacementNamed(context, 'login');}),
          
        ],

      ),
    );
  }

  DrawerHeader _drawerHeader() {
    return   const DrawerHeader(
          child: null,
          decoration:BoxDecoration(
            color: Color.fromRGBO(37,80,121,0.8),
          ) ,          
          );
  }
}




























// import 'package:chat/services/services.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';


// class SideMenu extends StatefulWidget {
//   const SideMenu({Key? key}) : super(key: key);

//   @override
//   State<SideMenu> createState() => _SideMenuState();
// }

// class _SideMenuState extends State<SideMenu> {
  
//   @override
//   Widget build(BuildContext context) {
//     final socketService=Provider.of<SocketService>(context);

//     return Drawer(
//       child: Container(
//         decoration: _fondoDegradado(),
//         child: ListView(
//           children:  [
//             _header(),
//             ListTile(
//               leading: const Icon(Icons.account_circle_outlined,color: Colors.white,size: 35,),
//               title: const Text('Perfil',style: TextStyle(color: Colors.white,fontSize: 20),),
//               onTap: (){Navigator.pushNamed(context, 'profile');}),
//             ListTile(
//               leading: const Icon(Icons.logout,color: Colors.white,size: 30,),
//               title: const Text('Salir',style: TextStyle(color: Colors.white,fontSize: 20)),
//               onTap: (){
//                   socketService.disconnect();
//                   AuthService.deleteToken();
//                   Navigator.pushReplacementNamed(context, 'login');}),

//           ],
//         ),
//       ),
//     );
   
//   }

//   DrawerHeader _header() {
//     // ignore: prefer_const_constructors
//     return DrawerHeader(
//             child: const Center(
//               child: Text('Utsoe',style: TextStyle(fontSize: 55,fontWeight: FontWeight.bold),),
//             ));
//   }
//    BoxDecoration _fondoDegradado() => const BoxDecoration(
//     gradient: LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [
//         Color.fromARGB(255, 66, 99, 131),
//       Color.fromARGB(255, 32, 82, 128),
      

      
//     ])
//   );

 
// }

