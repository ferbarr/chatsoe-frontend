
import 'package:flutter/material.dart';


class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _drawerHeader(),
          ListTile(leading: const Icon(Icons.account_circle_outlined),title: const Text('Perfil'),onTap: (){
              Navigator.pushNamed(context, 'profile');
          },),
         
          ListTile(leading: const Icon(Icons.logout,),title: const Text('Salir'),onTap: (){
            Navigator.pushReplacementNamed(context, 'login');}),
          
        ],

      ),
    );
  }

  DrawerHeader _drawerHeader() {
    return   DrawerHeader(
          child: null,
          decoration:BoxDecoration(
            color: Color.fromRGBO(37,80,121,0.8),
          
            
          ) ,
          // child: Container(
          //   decoration: const BoxDecoration(
          //     // color: Colors.pink
          //     image: DecorationImage(
          //       image: AssetImage('assets/menu-img.jpg'),
          //       fit: BoxFit.cover
          //     )
          //   ),
          // )
          
          );
  }
}