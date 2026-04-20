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
}