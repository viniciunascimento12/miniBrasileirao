import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/titulo.dart';

class Time{
  String nome;
  String brasao;
  int pontos;
  List<Titulo>? titulos = [];

  Time({required this.nome, required this.brasao, required this.pontos, this.titulos});
}