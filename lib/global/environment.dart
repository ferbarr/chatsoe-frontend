

import 'dart:io';

class Environment{
  static String apiUrl=Platform.isAndroid 
  ?'http://10.0.2.2:3000/chatsoe'
  :'http://localhost:3000/chatsoe';

  static String socketUrl=Platform.isAndroid 
  ?'http://10.0.2.2:3000'
  :'http://localhost:3000';


}