import 'package:chat/models/models.dart';
import 'package:chat/routes/routes.dart';
import 'package:chat/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();//Asegurar que todo se inicialice normal
  await SliderModel.init();  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>AuthService()),
        ChangeNotifierProvider(create: (_)=>SocketService()),
        ChangeNotifierProvider(create: (_)=>ChatService()),
        ChangeNotifierProvider(create: (_)=>SliderModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat',
        initialRoute: 'loading',
        routes: appRoutes,
       
      ),
    );
  }
}