// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/time.dart';
import "package:flutter_aula_1/models/titulo.dart";
import 'package:flutter_aula_1/repositories/time_repository.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddTituloPage extends StatefulWidget {
  late Time time;

  AddTituloPage({super.key, required this.time});

  @override
  State<AddTituloPage> createState() => _AddTituloPageState();
}

class _AddTituloPageState extends State<AddTituloPage> {

  final _campeonato = TextEditingController();
  final _ano = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  save(){
    Provider.of<TimesRepository>(context, listen: false).addTitulo(
      time: widget.time,
      titulo: Titulo(ano: _ano.text,
        campeonato: _campeonato.text,
        ),
    );
    Get.back();
    Get.snackbar('Sucesso!',
    'Titulo cadastrado', 
    backgroundColor: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Títulos'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(24),
              child: TextFormField(
                controller: _ano,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ano',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o título';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: TextFormField(
                controller: _campeonato,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Campeonato',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe qual o campeonato';
                  }
                  return null;
                },
              ),
            ),
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.all(25),
              child: ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate()){
                    save();
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(6),
                      child: Text('Salvar', style: TextStyle(fontSize: 20)),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
