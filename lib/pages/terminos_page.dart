import 'package:flutter/material.dart';

class TerminosPage extends StatelessWidget {
   
  const TerminosPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Terminos de licencia'),
        centerTitle: true,

      ),
      body: const Center(
         child: Text('TerminosPage'),
      ),
    );
  }
}