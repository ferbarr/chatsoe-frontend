import 'package:flutter/material.dart';

class TerminosPage extends StatelessWidget {
   
  const TerminosPage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: const Text('Politica de privacidad'),
        centerTitle: true,

      ),
      body:  SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
             children:[
               const Text('Información legal de ChatSoe',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
               const SizedBox(height: 10,),
               const Text('En nuestra Política de privacidad ("Política de privacidad"), explicamos las prácticas que llevamos a cabo con los datos, incluida la información que tratamos para proporcionar nuestros Servicios.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Por ejemplo, en nuestra Política de privacidad hablamos sobre la información que recopilamos y qué implicaciones tiene para ti. También explicamos las medidas que tomamos para proteger tu privacidad, como diseñar nuestros Servicios de modo que no almacenemos los mensajes entregados y proporcionarte el control para elegir con quién te comunicas en nuestros Servicios.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Consulta también las Condiciones del servicio ("Condiciones") de Chatsoe, donde se describen las condiciones que rigen el uso de nuestros Servicios y el modo en el que los proveemos.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Actualización clave',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
               const SizedBox(height: 10,),
               const Text('En las Condiciones del servicio y la Política de privacidad actualizadas encontrarás lo siguiente:',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               Row(children: const[SizedBox(width: 10,),Text('•	Información adicional sobre cómo tratamos tus datos.'),],),
               const SizedBox(height: 10,),
               Row(children: const[SizedBox(width: 10,),Text('•	Mejor comunicación con los usuarios.'),],),
               const SizedBox(height: 10,),
               Row(children: const[SizedBox(width: 10,),Text('•	Facilitar la comunicación.'),],),
               const SizedBox(height: 10,),
               Row(children: const[SizedBox(width: 10,),Text('•	Información que comunicamos.'),],),
               const SizedBox(height: 10,),
               const Text('El tipo de información que recibimos y recopilamos depende de la forma en la que usas nuestros Servicios. Requerimos información determinada para proporcionar nuestros Servicios y si no la recopilamos, no podremos proveerlos. Por ejemplo, debes proporcionar tu correo electrónico para crear una cuenta con el fin de usar nuestros Servicios.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Si decides no proporcionar la información requerida para una función, no podrás utilizarla.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Información que proporcionas',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
               const SizedBox(height: 10,),
               const Text('Información de tu cuenta. Cuando creas una cuenta de chatsoe, debes proporcionar tu correo electrónico junto con cierta información básica (incluido un nombre de perfil de tu elección). Si no nos proporcionas esta información, no podrás crear una cuenta para usar nuestros Servicios. Puedes agregar otra información a tu cuenta, como la foto del perfil.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Tus mensajes. Durante la prestación ordinaria de nuestros Servicios, no conservamos tus mensajes, sino que se almacenan en tu dispositivo (no se guardan generalmente en nuestros servidores). Una vez que se entregan tus mensajes, se eliminan de nuestros servidores. En los siguientes ejemplos, se describen situaciones en las que podemos almacenar tus mensajes hasta que se entreguen:',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Mensajes no entregados. Si un mensaje no se puede entregar de inmediato (por ejemplo, si el destinatario no tiene conexión a Internet), lo conservamos de forma cifrada en nuestros servidores durante un plazo máximo de 30 días mientras intentamos entregarlo. Si el mensaje no se entrega después de 30 días, lo eliminamos.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Soporte técnico y otros tipos de comunicación. Cuando nos contactas para solicitar soporte técnico o te comunicas con nosotros de otro modo, es posible que nos proporciones información relacionada con el uso que haces de nuestros Servicios, incluidas las copias de tus mensajes, cualquier otra información que consideres de ayuda y tu información de contacto (como una dirección de correo electrónico). Por ejemplo, puedes enviarnos un correo electrónico con información relacionada con el rendimiento de la aplicación u otros problemas que tengas.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Información de terceros',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
               const SizedBox(height: 10,),
               const Text('Información que otros proporcionan sobre ti. Recibimos información sobre ti de otros usuarios. Por ejemplo, cuando otros usuarios que conoces usan nuestros Servicios, pueden proporcionar tu número de teléfono, nombre y correo), así como tú puedes proporcionar la de ellos. También es posible que te envíen mensajes a ti, a los grupos a los que pertenezcas o que te llamen. Requerimos a estos usuarios que tengan derechos legítimos para recopilar, usar y compartir tu información antes de proporcionarnos cualquier tipo de dato.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Proveedores de servicios de terceros. Trabajamos con proveedores de servicios de terceros que nos ayuden a operar, proporcionar, mejorar, entender, personalizar, respaldar y promocionar nuestros Servicios.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Como usamos la información',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
               const SizedBox(height: 10,),
               const Text('Usamos la información que tenemos (sujeta a las elecciones que hagas y la legislación aplicable) para operar, proporcionar, mejorar, entender, personalizar, respaldar y promocionar nuestros Servicios. Así es como lo hacemos:',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Interacciones de la empresa. Permitimos que tú y los terceros puedan comunicarse e interactuar a través de nuestros Servicios.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Información que tú y nosotros compartimos',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
               const SizedBox(height: 10,),
               const Text('Tú compartes tu información mientras usas nuestros Servicios y te comunicas por medio de ellos, y nosotros la compartimos para operar, proporcionar, mejorar, entender, personalizar, respaldar y promocionar nuestros Servicios.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Enviar tu información a aquellos que eliges para comunicarte. Tú compartes tu información (incluidos mensajes) mientras usas nuestros Servicios y te comunicas por medio de ellos.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Información asociada a tu cuenta. Tu número de teléfono, nombre y foto del perfil, tu última conexión y las confirmaciones de lectura están a disposición de cualquiera que use nuestros Servicios.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Contáctanos',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Si tienes preguntas sobre nuestra Política de privacidad, o algún inconveniente al respecto, ponte en contacto con nosotros.',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('chatsoe@gmail.com',textAlign: TextAlign.justify,style: TextStyle(color: Colors.blue),),
               const SizedBox(height: 10,),
               const Text('+524561270091 ',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
               const Text('Calle Mango #49 fraccionamiento Malpais, Valle de Santiago, Guanajuato',textAlign: TextAlign.justify,),
               const SizedBox(height: 10,),
             ]

            ),
          ),
        ),
      ),
    );
  }
}