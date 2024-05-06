import 'dart:io';

import 'package:gestao_de_imobiliaria_mobile/Models/usuario.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class MyDatabase {
  static final MyDatabase _myDatabase = MyDatabase._privateConstructor();
  static late Database _database;

  MyDatabase._privateConstructor() {
    initializeDatabase(); // Chamando o método de inicialização do banco de dados
  }

  factory MyDatabase() {
    return _myDatabase;
  }
  //variaveis
  final String tableName = 'usuarios';
  final String colunaNome = 'nome';
  final String colunaApelido = 'apelido';
  final String colunaDataNascimento = 'dataNascimento';
  final String colunaContacto = 'contacto';
  final String colunaEmail = 'email';
  final String colunaPassword = 'password';

  //init Databse
  initializeDatabase() async {
    try {
      // Recebe o path da base de dados
      Directory directory = await getApplicationDocumentsDirectory();

      // Path
      String path = directory.path;
      String tabelaUsuarioQuery =
          "CREATE TABLE usuarios(IdUsuario INTEGER PRIMARY KEY AUTOINCREMENT, $colunaNome TEXT NOT NULL, $colunaApelido TEXT NOT NULL,$colunaDataNascimento DATE NOT NULL, $colunaContacto TEXT NOT NULL, $colunaEmail TEXT NOT NULL, $colunaPassword TEXT NOT NULL)";

      // Criar base de dados
      _database =
          await openDatabase(path, version: 1, onCreate: (db, version) async {
        await db.execute(tabelaUsuarioQuery);
      });
    } catch (e) {
      // Captura de erro
      print('Erro ao inicializar o banco de dados: $e');
    }
  }

  //base de dados
  // final databaseName = "imovel.db";

  /* Future<Database> _database() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, verion) async {
      await db.execute(tabelaUsuarioQuery);
    });
  }*/

  //Metodos CRUD

  //criar usuario
  Future<int> CriarUsuario(Usuario usuario) async {
    int rowsInserted = await _database.insert(tableName, usuario.toMap());
    return rowsInserted;
  }

  //ler os usuarios
  Future<List<Map<String, Object?>>> lerUsuario() async {
    List<Map<String, Object?>> result =
        await _database.query(tableName, orderBy: colunaNome);
    return result;
  }

  /* Future<List<Usuario>> lerUsuarios() async {
    final Database db = await _database();
    List<Map<String, Object?>> result = await db.query('usuarios');
    return result.map((e) => Usuario.fromMap(e)).toList();
  }*/

  //apagar Usuarios
  Future<int> apagarUsuarios(int id) async {
    int rowsDeleted = await _database
        .delete(tableName, where: 'idUsuario = ?', whereArgs: [id]);
    return rowsDeleted;
    /*final Database db = await _database();
    return db.delete('usuarios', where: 'idUsuario = ?', whereArgs: [id]);*/
  }

//actualizar usuarios
  Future<int> actualizarUsuario(int id, Usuario usuario) async {
    int rowsUpdated = await _database.update(tableName, usuario.toMap(),
        where: 'IdUsuario = ?', whereArgs: [id]);
    return rowsUpdated;
    /*db.update('usuarios', usuario.toMap(),
        where: 'IdUsuario = ?', whereArgs: [id]);*/
  }

//-------------------------------------------------------------------------------------------------------------
  //metodo login
  Future<bool> login(Usuario usuario) async {
    List<Map<String, Object?>> result = await _database.query(
      tableName,
      where: '$colunaEmail = ? AND $colunaPassword = ?',
      whereArgs: [usuario.Email, usuario.Password],
    );

    return result.isNotEmpty;
  }

  //metodo registar
  Future<int> registar(Usuario usuario) async {
    int rowsInserted = await _database.insert(tableName, usuario.toMap());
    return rowsInserted;
  }
}
