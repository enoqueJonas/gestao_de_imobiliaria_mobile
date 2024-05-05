import 'package:gestao_de_imobiliaria_mobile/Models/usuario.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  final databaseName = "imovel.db";
  String userTable =
      "CREATE TABLE usuarios(IdUsuario INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, apelido TEXT NOT NULL,dataNascimento DATE NOT NULL, contacto TEXT NOT NULL, email TEXT NOT NULL, password TEXT NOT NULL)";

  String imovelTable = "";

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);

    return openDatabase(path, version: 1, onCreate: (db, verion) async {
      await db.execute(userTable);
    });
  }

  //Metodos CRUD

  //criar usuario
  Future<int> CriarUsuario(Usuario usuario) async {
    final Database db = await initDB();
    return db.insert('usuarios', usuario.toMap());
  }

  //ler os usuarios
  Future<List<Usuario>> lerUsuarios() async {
    final Database db = await initDB();
    List<Map<String, Object?>> result = await db.query('usuarios');
    return result.map((e) => Usuario.fromMap(e)).toList();
  }

  //apagar Usuarios
  Future<int> apagarUsuarios(int id) async {
    final Database db = await initDB();
    return db.delete('usuarios', where: 'idUsuario = ?', whereArgs: [id]);
  }

//actualizar usuarios
  Future<int> actualizarUsuario(int id, Usuario usuario) async {
    final Database db = await initDB();
    return db.update('usuarios', usuario.toMap(),
        where: 'IdUsuario = ?', whereArgs: [id]);
  }

//-------------------------------------------------------------------------------------------------------------
  //metodo login
  Future<bool> login(Usuario usuario) async {
    final Database db = await initDB();

    var result = await db.rawQuery(
        "select * from usuarios where email = '${usuario.Email}' AND password = '${usuario.Password}'");
    if (result.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //metodo registar
  Future<int> registar(Usuario usuario) async {
    final Database db = await initDB();

    return db.insert('usuarios', usuario.toMap());
  }
}
