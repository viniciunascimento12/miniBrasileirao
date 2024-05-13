import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_aula_1/models/time.dart";
import "package:flutter_aula_1/models/titulo.dart";
import "package:flutter_aula_1/pages/add_titulo_page.dart";
import "package:flutter_aula_1/pages/edite_titulo_page.dart";
import "package:flutter_aula_1/repositories/time_repository.dart";
import "package:flutter_aula_1/widgets/brasao.dart";
import "package:get/get.dart";
import "package:provider/provider.dart";

class Timepage extends StatefulWidget {
  Time time;
  Timepage({required Key key, required this.time});

  @override
  State<Timepage> createState() => _TimepageState();
}

class _TimepageState extends State<Timepage> {
   tituloPage(){
    Get.to(() => 
        AddTituloPage(time: widget.time));
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.time.nome),
          actions: [IconButton(icon:Icon(Icons.add),onPressed:tituloPage)],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.stacked_line_chart),
                text: 'Estastisticas',
              ),
              Tab(
                icon: Icon(Icons.emoji_events),
                text: 'Títulos',
              ),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(24),
                  child: Brasao(image: widget.time.brasao, width: 250),
                ),
                Text(
                  'Pontos: ' + widget.time.pontos.toString(),
                  style: TextStyle(fontSize: 21),
                )
              ],
            ),
            titulos(),
          ],
        ),
      ),
    );
  }

  Widget titulos() {
   final time = Provider.of<TimesRepository>(context)
        .times
        .firstWhere((t) => t.nome == widget.time.nome);
   final quantidade = time.titulos!.length;

    return quantidade == 0
        ? Container(
            child: Center(
              child: Text('Sem Títulos'),
            ),
          )
        : ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Icon(Icons.emoji_events),
                title: Text(time.titulos![index].campeonato),
                trailing: Text(time.titulos![index].ano),
                onTap: (){
                  Get.to(
                    EditeTituloPage(titulo:time.titulos![index]),
                    fullscreenDialog: true,
                  );
                },
              );
            },
            separatorBuilder: (_, __) => Divider(),
            itemCount: quantidade,
          );
  }
}
