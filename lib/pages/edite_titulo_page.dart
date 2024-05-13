import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/titulo.dart';
import 'package:flutter_aula_1/repositories/time_repository.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class EditeTituloPage extends StatefulWidget {
  Titulo titulo;
  EditeTituloPage({super.key, required this.titulo});

  @override
  State<EditeTituloPage> createState() => _EditeTituloPageState();
}

class _EditeTituloPageState extends State<EditeTituloPage> {

  final _campeonato = TextEditingController();
  final _ano = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    _ano.text = widget.titulo.ano;
    _campeonato.text = widget.titulo.campeonato;
  }

  editar(){
    Provider.of<TimesRepository>(
      context,
      listen: false)
      .editTitulo(
        titulo: widget.titulo,
        ano: _ano.text,
        campeonato: _campeonato.text,   
      );
      Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Título'),
        backgroundColor: Colors.deepOrangeAccent,
        actions: [IconButton(icon: const Icon(Icons.check), onPressed: editar)],
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
          ],
       ),
      ),
    );
  }
}