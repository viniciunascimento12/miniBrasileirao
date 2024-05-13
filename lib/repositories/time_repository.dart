import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_aula_1/database/db.dart';
import 'package:flutter_aula_1/models/time.dart';
import 'package:flutter_aula_1/models/titulo.dart';

class TimesRepository extends ChangeNotifier {
  final List<Time> _times = [];                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  

  UnmodifiableListView<Time> get times =>UnmodifiableListView(_times);
  
  void addTitulo({required Time time,required Titulo titulo}) async {

    var db = await DB.get();
    int addTitulo = await db.insert('titulos',{
          'campeonato': titulo.campeonato,
          'ano': titulo.ano,
    });
    time.titulos!.add(titulo);
    notifyListeners();
  }

  void editTitulo({required Titulo titulo, required String ano, required String campeonato}) async{

    var db = await DB.get();
    await db.update('titulos',{
       'campeonato': campeonato,
       'ano': ano 
      }, where: 'id=?', whereArgs:[titulo.campeonato]
    );

    titulo.campeonato = campeonato;
    titulo.ano = ano;
    notifyListeners();
  }

  static setupTimes(){
      return [
      Time(nome: 'Fortaleza', brasao: 'https://upload.wikimedia.org/wikipedia/commons/9/9e/Escudo_do_Fortaleza_EC.png', pontos: 70,),
      Time(nome: 'Ceará', brasao: 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Cear%C3%A1_Sporting_Club_logo.svg/120px-Cear%C3%A1_Sporting_Club_logo.svg.png', pontos: 50, ),
      Time(nome: 'Flamengo', brasao: 'https://upload.wikimedia.org/wikipedia/commons/2/22/Logo_Flamengo_crest_1980-2018.png', pontos: 60,),
      Time(nome: 'Santos', brasao: 'https://upload.wikimedia.org/wikipedia/commons/1/15/Santos_Logo.png', pontos: 44,),
      Time(nome: 'Palemeiras', brasao: 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Palmeiras_logo.svg/640px-Palmeiras_logo.svg.png', pontos: 65,),
      Time(nome: 'Cruzeiro', brasao: 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Logo_Cruzeiro_1996.png/1200px-Logo_Cruzeiro_1996.png', pontos: 52,),
      ];
  }

  TimesRepository(){
    initRepository();
  }

  initRepository() async{
    var db = await DB.get();
    List times = await db.query('times');
          //Equivale ao db.rawQuery('SELECT * FPOM times');

    for(var time in times){
      _times.add(Time(
        nome: time['nome'],
        brasao: time['brasao'],
        pontos: time['pontos'],
        titulos: await getTitulos(time['nome'])
      ));
    }
    notifyListeners();
  }

  getTitulos(timeId) async{
    var db = await DB.get();
    var results =
      await db.query('titulos', where: 'time_id = ?', whereArgs:[timeId]);
      List<Titulo> titulos = [];
      for (var titulo in results){
        titulos.add(Titulo(
          campeonato: titulo['campeonatoo'],
          ano: titulo['ano'],
        ));
      }
    return titulos;
  }
}