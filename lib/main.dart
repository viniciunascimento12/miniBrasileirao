import 'package:flutter/material.dart';
import 'package:flutter_aula_1/controllers/theme_controller.dart';
import 'package:flutter_aula_1/repositories/time_repository.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'pages/home_page.dart';

void main() {
  Get.lazyPut<ThemeCrontroller>(()=> ThemeCrontroller());
  
  runApp(ChangeNotifierProvider(
      create: (context)=>TimesRepository(),
      child: MeuApp(),
      )
  );
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ThemeCrontroller.to.loadThemeMode();

    return GetMaterialApp(
      theme: ThemeData(
          brightness: Brightness.light,
          visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.grey,
          dividerColor: Colors.black45,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
