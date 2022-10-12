
import 'package:chat/pages/pages.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes={
  'usuarios':(_)=>const UsuariosPage(),
  'chat':(_)=>const ChatPage(),
  'login':(_)=>const LoginPage(),
  'register':(_)=> const RegisterPage(),
  'loading':(_)=>const LoadingPage(),
  'profile':(_)=> const ProfilePage(),
  'slide':(_)=>const SlideShowPage(),
  'terminos':(_)=>const TerminosPage()
};

