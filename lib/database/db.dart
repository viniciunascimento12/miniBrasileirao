import 'package:flutter_aula_1/models/time.dart';
import 'package:flutter_aula_1/repositories/time_repository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DB{

    DB._();
    static final DB instance = DB._();
    static Database? _database;

    Future<Database> get database async{
      return _database ??= await initDatabase();
    }

    static get() async{
        return await DB.instance.database;
    }

    initDatabase() async {
        return await openDatabase(
        join(await getDatabasesPath(),'dados.db'),
        version: 1,
        onCreate: (db,versao) async{
          await db.execute(times);
          await db.execute(titulos);
          await setupTimes(db);
        },
      );
    }

    setupTimes(db){
        for (Time time in TimesRepository.setupTimes()){
          db.insert('times',{
            'nome':time.nome,
            'brasao':time.brasao,
            'pontos':time.pontos
          });
        }
    }

   String get times => '''
        CREATE TABLE times(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nome TEXT,
          pontos INTEGER,
          brasao TEXT
        );
    ''';

    String get titulos => '''
        CREATE TABLE titulos(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          campeonato TEXT,
          ano TEXT
        );
    ''';

}