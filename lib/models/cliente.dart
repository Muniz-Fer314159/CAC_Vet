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
        id: map['id'],
        nome: map['nome'],
        telefone: map['telefone'],
        email: map['email'],
        endereco: map['endereco'],
        cpf: map['cpf'],
   );
  }
}