import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SliderModel with ChangeNotifier{

  double _currentPage=0;
  double get currentPage => _currentPage;
  bool _lic=false;
 
  
  static late SharedPreferences _pref;


  static Future init()async{
    _pref=await SharedPreferences.getInstance();
  }

  bool get lic =>_lic;

  void eliminarLic(){
    _pref.remove('lic');
  }

  set lic(bool value) {
    _lic=value;
    notifyListeners();
  }

  bool get licP{
    return _pref.getBool('lic')??false;
  }

  set licP(bool value){
    _pref.setBool('lic',true);
  }

  set currentPage(double value) {
    _currentPage = value;
    notifyListeners();
  }

 

}