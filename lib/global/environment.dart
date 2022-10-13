

import 'dart:io';

class Environment{
  static String apiUrl=Platform.isAndroid 
  ?'https://chatsoe.herokuapp.com/chatsoe'
  :'https://chatsoe.herokuapp.com/chatsoe';

  static String socketUrl=Platform.isAndroid 
  ?'https://chatsoe.herokuapp.com'
  :'https://chatsoe.herokuapp.com';
}



// import 'dart:io';

// class Environment{
//   static String apiUrl=Platform.isAndroid 
//   ?'http://10.0.2.2:3000/chatsoe'
//   :'http://localhost:3000/chatsoe';

//   static String socketUrl=Platform.isAndroid 
//   ?'http://10.0.2.2:3000'
//   :'http://localhost:3000';


// }