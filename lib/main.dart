// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'telas/tela_astros.dart';
import 'controles/controle_astros.dart';
import 'modelos/astros.dart';
import 'telas/tela_mostrar_dados.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crud',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const MyHomePage(title: ''),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ControleAstros _controleAstros = ControleAstros();
  List<Astros> _astros = [];

  @override
  void initState() {
    super.initState();
    _atualizarAstros();
  }

  Future<void> _atualizarAstros() async {
    final resultado = await _controleAstros.lerAstros();
    setState(() {
      _astros = resultado;
    });
  }

  void _incluirAstros(BuildContext context)
  //Botão de inclusão de Cadastro
  //Quando uma função é declarada com o tipo de retorno void,significa que a função executa algum código,
  //Mas não fornece um resultado de volta para quem a chamou.
  {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => TelaAstros(
              isIncluir: true,
              astros: Astros.vazio(),
              onFormSubmitted: () {
                _atualizarAstros();
              },
            ),
      ),
    );
  }

  void _alterarAstros(BuildContext context, Astros astros) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => TelaAstros(
              isIncluir: false,
              astros: astros,
              onFormSubmitted: () {
                _atualizarAstros();
              },
            ),
      ),
    );
  }

  void _excluirAstros(int id) async {
    await _controleAstros.excluirAstros(id);
    _atualizarAstros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 51, 15, 105),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text('Astronomia Paraná', style: TextStyle(color: Colors.white)),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 17, 0, 55),
              ),
              child: Text(
                'Menu de Navegação',
                style: TextStyle(
                  color: const Color.fromARGB(255, 234, 234, 200),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            ListTile(
              title: Text('Planetas'),
              onTap: () {
                const Icon(Icons.add);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
            ),
          ],
        ),
      ),

      body: ListView.builder(
        itemCount: _astros.length,
        itemBuilder: (context, index) {
          final astros = _astros[index];
          return ListTile(
            title: Text(astros.nome),
            subtitle: Text(astros.tipo),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _alterarAstros(context, astros),
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _excluirAstros(astros.id!),
                ),
              ],
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _incluirAstros(context),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
