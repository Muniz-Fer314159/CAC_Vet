class Cliente {
  int? id;
  String nome;
  String telefone;
  String email;
  String endereco;
  String cpf;

  Cliente({
    this.id,
    required this.nome,
    required this.telefone,
    required this.email,
    required this.endereco,
    required this.cpf,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'email': email,
      'endereco': endereco,
      'cpf': cpf,
    };
  }

  factory Cliente.fromMap(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'] as int?,
      nome: map['nome']?.toString() ?? '',
      telefone: map['telefone']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      endereco: map['endereco']?.toString() ?? '',
      cpf: map['cpf']?.toString() ?? '',
    );
  }
}
