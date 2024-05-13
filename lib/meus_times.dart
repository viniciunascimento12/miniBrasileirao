import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/time.dart';
import 'package:flutter_aula_1/repositories/time_repository.dart';

class MeusTimes extends StatelessWidget {
  const MeusTimes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buidBody(),
    );
  }

  _buidBody() {
    TimesRepository tr = TimesRepository();
    List<Time> times = tr.times;
    return ListView(
        children: times.map((e) => Text(e.nome)).toList(),
    );
  }
}
