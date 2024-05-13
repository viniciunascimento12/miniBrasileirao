import '../models/time.dart';
import '../models/titulo.dart';
import '../repositories/time_repository.dart';

class HomeController{
 TimesRepository tr = TimesRepository();
 List<Time> get tabela => tr.times;
  
  void homeController(){
    tr = TimesRepository();
  }
}