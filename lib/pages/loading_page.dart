// ignore_for_file: use_build_context_synchronously
import 'package:chat/models/models.dart';
import 'package:chat/pages/pages.dart';
import 'package:chat/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
   
  const LoadingPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: checkLoginState(context),
          builder: (context,snapshot){
              return  Center(
               
                child: Column(
                  children: [
                    const SizedBox(height: 100,),
                    const Image(
                      width: 200,
                      height: 200,
                      image: AssetImage('assets/logo.png')),
                      const SizedBox(height: 10,),
                    Container(
                      width: 100,
                      child: const LinearProgressIndicator(
                      
                      ),
                    )
                  ],
                )
              );
            },
        
        ),
      ),
    );
  }

  Future checkLoginState(BuildContext context)async{
    final authService=Provider.of<AuthService>(context,listen: false);
    final socketService=Provider.of<SocketService>(context,listen: false);
    final sliderService=Provider.of<SliderModel>(context,listen: false);
    final autenticado=await authService.isLoggedIn();

    final licTrue=sliderService.licP;
    if(licTrue){
      if(autenticado){
        socketService.connect();
        Navigator.pushReplacement(context,
        PageRouteBuilder(pageBuilder: (_,__,___)=>const UsuariosPage(),
        transitionDuration: const Duration(milliseconds: 0)
       ));
      }else{
        Navigator.pushReplacement(context,
        PageRouteBuilder(pageBuilder: (_,__,___)=>const LoginPage(),
        transitionDuration: const Duration(milliseconds: 0)
        ));
      }
    }else{
      Navigator.pushReplacement(context,
        PageRouteBuilder(pageBuilder: (_,__,___)=>const SlideShowPage(),
        transitionDuration: const Duration(milliseconds: 0)
        ));

    }
  }
}