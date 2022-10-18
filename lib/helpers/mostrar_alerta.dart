
import 'package:flutter/cupertino.dart';


mostrarAlerta(BuildContext context,String titulo,String subtitulo){


  showCupertinoDialog(
    context: context,
    builder: (_)=>CupertinoAlertDialog(
      title: Text(titulo),
      content: Text(subtitulo),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: ()=>Navigator.pop(context),
          child: const Text('Ok'))
      ],
    ));


  
  
}