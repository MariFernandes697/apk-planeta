class Astros {
  int? id;
  String tipo;
  String nome;
  double idade;
  double tamanho;
  String? caracteristica;

  Astros({
    this.id,
    required this.tipo,
    required this.nome,
    required this.idade,
    required this.tamanho,
    this.caracteristica,
  });

   //Construtor vazio.
  Astros.vazio()
    : tipo = '',
      nome = '',
      idade = 0,
      tamanho = 0.0,
      caracteristica = '';

  factory Astros.fromMap(Map<String, dynamic> map)
  //Essa função traz a informação que está em formato de 'mapString' para o formato binário na memória do computador.
  {
    return Astros(
      id: map['id'],
      tipo: map['tipo'],
      nome: map['nome'],
      idade: map['idade'],
      tamanho: map['tamanho'],
      caracteristica: map['caracteristica'],
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'tipo': tipo,
      'nome': nome,
      'idade': idade,
      'tamanho': tamanho,
      'caracteristica': caracteristica,
    };
  }
}
