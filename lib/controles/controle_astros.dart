import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modelos/astros.dart';

class ControleAstros {
  static Database? _bd;

  Future<Database> get bd async {
    if (_bd != null) return _bd!;
    _bd = await _initBD('astros.db');
    return _bd!;
  }

  Future<Database> _initBD(String localArquivo) async
  //O Future indica que esta função realiza uma operação assíncrona e retornará uma instância do banco de dados.(Atualizar e recarregar)
  {
    final caminhoBD = await getDatabasesPath();
    //getDatabasesPath é uma função chamada para obter o caminho onde os bancos de dados são armazenados.
    final caminho = join(caminhoBD, localArquivo);
    return await openDatabase(caminho, version: 1, onCreate: _criarBD);
    // openDatabase é chamado quando o banco de dados é criado pela primeira vez.
  }

  Future<void> _criarBD(Database db, int version) async {
    const sql = '''
      CREATE TABLE IF NOT EXISTS astros(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tipo TEXT NOT NULL,
        nome TEXT NOT NULL,
        idade REAL NOT NULL,
        tamanho REAL NOT NULL,
        caracteristica TEXT,
      )
    ''';
    await db.execute(sql);
  }

  Future<List<Astros>> lerAstros() async {
    final db = await bd;
    final resultado = await db.query('astros');
    return resultado.map((map) => Astros.fromMap(map)).toList();
    //lista.map((map) => Astros.fromMap(map)): Mapeia cada elemento da lista de mapas para um objeto Astros.
    //A função Astros.fromMap(map) é usada para criar um objeto Astros a partir de um mapa.
  }

  Future<int> inserirAstros(Astros astros) async {
    final db = await bd;
    return db.insert('astros', astros.toMap());

    //db.insert('astros', astros.toMap()): Chama o método insert na instância do banco de dados (db) para inserir um novo registro na tabela astros.
    //A tabela astros é especificada pelo primeiro argumento 'astros'.
    //astros.toMap(): Converte o objeto astros em um mapa (Map<String, dynamic>) utilizando o método toMap().
    //Esse mapa representa os dados do astro que serão inseridos na tabela.
  }

  Future<int> alterarAstros(Astros astros) async {
    final db = await bd;
    return db.update(
      'astros',
      astros.toMap(),
      where: 'id = ?',
      whereArgs: [astros.id],
    );
  }

  Future<int> excluirAstros(int id) async {
    final db = await bd;
    return await db.delete('astros', where: 'id = ?', whereArgs: [id]);
  }
}
