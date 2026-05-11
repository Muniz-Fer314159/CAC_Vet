class Animal {
  int? id;
  String nome;
  String especie;
  String raca;
  int idade;
  String nomeDono;

  Animal({
    this.id,
    required this.nome,
    required this.especie,
    required this.raca,
    required this.idade,
    required this.nomeDono,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'especie': especie,
      'raca': raca,
      'idade': idade,
      'nome_dono': nomeDono,
    };
  }

  factory Animal.fromMap(Map<String, dynamic> map) {
    return Animal(
      id: map['id'] as int?,
      nome: map['nome']?.toString() ?? '',
      especie: map['especie']?.toString() ?? '',
      raca: map['raca']?.toString() ?? '',
      idade: (map['idade'] as num?)?.toInt() ?? 0,
      nomeDono: map['nome_dono']?.toString() ?? '',
    );
  }
}
