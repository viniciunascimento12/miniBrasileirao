import 'package:flutter/material.dart';
import 'package:flutter_aula_1/controllers/theme_controller.dart';
import 'package:flutter_aula_1/models/time.dart';
import 'package:flutter_aula_1/pages/home_controller.dart';
import 'package:flutter_aula_1/pages/time_page.dart';
import 'package:flutter_aula_1/repositories/time_repository.dart';
import 'package:flutter_aula_1/widgets/brasao.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = ThemeCrontroller.to;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Times'),
          actions: [
              PopupMenuButton(
                icon: Icon(Icons.more_vert), 
                itemBuilder:(_) => [
                  PopupMenuItem(
                    child: ListTile(
                      leading: Obx(()=>controller.isDark.value
                      ?Icon(Icons.brightness_7)
                      :Icon(Icons.brightness_2)),
                    title: Obx(() => controller.isDark.value ? Text('Light') : Text('Dark')),
                    onTap: () => controller.changeTheme() ,
                    ),
                  )
                ] 
                ),
          ],
        ),
        body: Consumer<TimesRepository>(
          builder: (context,repositorio,child){    
            return ListView.separated(
            itemCount: repositorio.times.length,
            itemBuilder: (BuildContext contexto, int time) {
              final List<Time> tabela = repositorio.times;
              return ListTile(
                leading: Brasao(image: tabela[time].brasao, width: 40),
                title: Text(tabela[time].nome),
                subtitle: Text('Títulos:${tabela[time].titulos!.length}'),
                trailing: Text('Pontos: ${tabela[time].pontos}'),
                onTap: () {
                  Get.to(() => Timepage(
                          key: Key(tabela[time].nome),
                          time: tabela[time],
                        )
                    );
                },
              );
            },
            separatorBuilder: (_, __) => Divider(),
            padding: EdgeInsets.all(16),
            );
           },
        ),
      );
  }
}
