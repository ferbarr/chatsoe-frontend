import 'package:chat/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class SlideShowPage extends StatelessWidget {
     
  const SlideShowPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      body: Center(
         child: Column(
           children: const [
             Expanded(child: _Slides()),
             _Dots()
           ],
         )
      ),
    );
  }
}


class _Slides extends StatefulWidget {
  const _Slides({Key? key}) : super(key: key);

  @override
  State<_Slides> createState() => _SlidesState();
}

class _SlidesState extends State<_Slides> {
  final pageViewController=PageController();//Obtener info del PageView

  @override
  void initState() {
    pageViewController.addListener(() { //Escuchar cambios de paginas
      Provider.of<SliderModel>(context,listen: false).currentPage=pageViewController.page!;

    });
    super.initState();
  }

  @override
  void dispose() {//Eliminar fugaz de secuencias
    pageViewController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final valor;
    final sliderService=Provider.of<SliderModel>(context);
    return PageView(
      controller: pageViewController,

      children:   [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[
            
            Text('Bienvenido',style: 
            TextStyle(
              fontFamily: 'marker',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color:  Color.fromRGBO(37,80,121,1)
            
            ),),
            _Slide('assets/1.svg'),
            
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const[
            
            Text('Mantente siempre en contacto',style: 
            TextStyle(
              fontSize: 20,
              fontFamily: 'marker',
              fontWeight: FontWeight.bold,
              color:  Color.fromRGBO(37,80,121,1)
            
            ),),
            _Slide('assets/2.svg'),
            
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              const Text('Tu seguridad es importante',style: 
              TextStyle(
                fontFamily: 'marker',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color:  Color.fromRGBO(37,80,121,1)
              
              ),),
              const _Slide('assets/3.svg'),
              CheckboxListTile(
                value: sliderService.lic,
                subtitle: const Text('Lee los terminos de licencia y uso',textAlign: TextAlign.center,),
               
                onChanged: (value){
                  sliderService.lic=value!;
                },
                title:Row(
                  
                  mainAxisAlignment:MainAxisAlignment.center,
                  children: [
                    
                     const Text('Acepto terminos de '),
                     GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, 'terminos');
                      },
                      child: const Text('licencia y uso',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.blue),),
                     )
                  ],
                ),
                ),
                MaterialButton(
                onPressed:sliderService.lic
                ?(){
                  sliderService.licP=true;
                  Navigator.pushNamed(context, 'login');
                }
                :null,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: const Color.fromARGB(255, 48, 92, 132),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 70),
                  child: const Text('Continuar',style: TextStyle(color:Colors.white)),
              ),
              ),
                
             
              

              
            ],
          ),
        ),
      ],
    );
  }
}

class _Slide extends StatelessWidget {
  final String svg;
  const _Slide(this.svg);
  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: 500,
      height: height*0.5,
      padding: const EdgeInsets.all(10),
      child: SvgPicture.asset(svg),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          _Dot(0),
          _Dot(1),
          _Dot(2)
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int index;
  const _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final pageViewIndex=Provider.of<SliderModel>(context).currentPage;//Obtner valor
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 12,
      height: 12,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration:  BoxDecoration(
        color:  (pageViewIndex>=index-0.5&&pageViewIndex<index+0.5)
        ?const Color.fromRGBO(37,80,121,1)
        :Colors.grey,
        shape: BoxShape.circle
      ),
    );
  }
}







