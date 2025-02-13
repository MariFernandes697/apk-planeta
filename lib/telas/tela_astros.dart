import 'package:flutter/material.dart';
import 'package:myapp/modelos/astros.dart';
import 'package:myapp/controles/controle_astros.dart';

class TelaAstros extends StatefulWidget {
  final bool isIncluir;

  final Astros astros;
  final Function() onFormSubmitted;

  const TelaAstros({
    super.key,
    required this.onFormSubmitted,
    required this.astros,
    required this.isIncluir,
  });

  @override
  State<TelaAstros> createState() => _TelaAstrosState();
}

class _TelaAstrosState extends State<TelaAstros> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _tamanhoController = TextEditingController();
  final TextEditingController _caracteristicaController =
      TextEditingController();

  final ControleAstros _controleAstros = ControleAstros();
  late Astros _astros;

  @override
  void initState() {
    _astros = widget.astros;
    _tipoController.text = _astros.tipo;
    _nomeController.text = _astros.nome;
    _idadeController.text = _astros.idade.toString();
    _tamanhoController.text = _astros.tamanho.toString();
    _caracteristicaController.text = _astros.caracteristica ?? '';
    super.initState();
  }

  @override
  void dispose() {
    _tipoController.dispose();
    _nomeController.dispose();
    _idadeController.dispose();
    _tamanhoController.dispose();
    _caracteristicaController.dispose();
    super.dispose();
  }

  Future<void> _inserirAstros() async {
    await _controleAstros.inserirAstros(_astros);
  }

  Future<void> _alterarAstros() async {
    await _controleAstros.alterarAstros(_astros);
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (widget.isIncluir) {
        _inserirAstros();
      } else {
        _alterarAstros();
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Dados salvos com sucesso')));
      Navigator.of(context).pop();
      widget.onFormSubmitted();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Cadastrar',

          style: TextStyle(
            color: const Color.fromARGB(
              255,
              234,
              234,
              200,
            ), // Definindo a cor do texto
            fontSize: 20.0, // Tamanho da fonte
            fontWeight: FontWeight.bold, // Peso da fonte
          ),
        ),
        elevation: 2,
        //a propriedade elevation é usada para adicionar sombra à um widget,
        //dando a ele um efeito de profundidade).
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color.fromARGB(255, 42, 31, 139),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _tipoController,
                  decoration: InputDecoration(
                    labelText: 'Tipo',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 3) {
                      return 'Por favor, insira qual é o astro que deseja cadastrar(ex: Planeta, Estrela, Satelite';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    
                    _astros.tipo = value!;
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    labelText: 'Nome',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 3) {
                      return 'Por favor, informe o nome do  (3 ou mais caractéres)';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _astros.nome = value!;
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _idadeController,
                  decoration: InputDecoration(
                    labelText: 'Idade (em anos)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira a idade';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Insira um valor númerico válido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _astros.idade = double.parse(value!);
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _tamanhoController,
                  decoration: InputDecoration(
                    labelText: 'Tamanho (em km)',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Insira o tamanho';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Insira um valor númerico válido';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _astros.tamanho = double.parse(value!);
                  },
                ),
                SizedBox(height: 10.0),
                TextFormField(
                  controller: _caracteristicaController,
                  decoration: InputDecoration(
                    labelText: 'Caracteristica',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  onSaved: (value) {
                    _astros.caracteristica = value!;
                  },
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('Cancelar'),
                    ),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Salvar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
