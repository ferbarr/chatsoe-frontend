import 'package:flutter/material.dart';

class BotonForm extends StatelessWidget {
 final String text;
 final dynamic fn;

   const BotonForm({super.key, required this.text, required this.fn,});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 2,
              primary: Colors.blue,
              shape: const StadiumBorder(),
            ),
            onPressed: fn,//Recibe funcion
             child: Container(
              width: double.infinity,
              height: 50,
              child: Center(
                child: Text(text,style: TextStyle(color: Colors.white,fontSize: 17),),
              ),
             ));
  }
}