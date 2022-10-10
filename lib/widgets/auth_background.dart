import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  final bool logo;
  const AuthBackground({Key? key, required this.child, required this.logo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
           const _PurpleBox(),
         
          //  if(logo) const _HeaderIcon(),
           if(logo) const Center(
                          heightFactor:1 ,
                          child: _HeaderLogo()),
          child
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
     child: Container(
       width: double.infinity,
       margin: const EdgeInsets.only(top: 30),
       child: const Icon(Icons.person_pin,color: Colors.white,size: 110,),

     ));
  }
}

class _HeaderLogo extends StatelessWidget {
  const _HeaderLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 110,
        margin: const EdgeInsets.only(top: 30),
        child: const Image(image: AssetImage('assets/logo.png')),
      ),
      );
  }
}

class _PurpleBox extends StatelessWidget {
  const _PurpleBox({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height*0.4,
      decoration: _pupleBackground(),
      child: Stack(
        children: const[
          Positioned(top: 90,left: 30, child: _Bubble()),
          Positioned(top: -40,left: -30, child: _Bubble()),
          Positioned(top: 10,right:-30, child: _Bubble()),
          Positioned(bottom: 10,right:60, child: _Bubble())
        ],
      ),
    );
  }

  BoxDecoration _pupleBackground() => const BoxDecoration(
    gradient: LinearGradient(colors: [
      Color.fromARGB(255, 32, 82, 128),
      Color.fromARGB(255, 66, 99, 131),
    ])
  );
}

class _Bubble extends StatelessWidget {
  const _Bubble({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: const Color.fromRGBO(255, 255, 255, 0.05)
      ),
    );
  }
}