import 'package:flutter/material.dart';

class InputDecorations{
  static InputDecoration authInputDecoration({required String hintText,required String labelText,required IconData prefixIcon}){
    return  InputDecoration(
                enabledBorder: const UnderlineInputBorder(//Border para cuando no tenga foco
                  borderSide: BorderSide(color: Color.fromARGB(255, 48, 92, 132),)               
                ),
                focusedBorder: const UnderlineInputBorder(//Borde para cuando tenga foco
                  borderSide: BorderSide(color: Color.fromARGB(255, 48, 92, 132),width: 2)
                ),
                hintText: hintText,
                labelText: labelText,
                labelStyle: const TextStyle(color: Colors.grey),
                prefixIcon: Icon(prefixIcon,color: const Color.fromARGB(255, 48, 92, 132),)
              );
  }
}