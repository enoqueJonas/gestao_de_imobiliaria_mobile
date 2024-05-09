class Usuario {
  final String? id;
  final String nome;
  final String apelido;
  final String dataNascimento;
  final String contacto;
  final String email;
  final String password;

  const Usuario({
    this.id,
    required this.nome, 
    required this.apelido, 
    required this.dataNascimento, 
    required this.contacto,
    required this.email, 
    required this.password
  }
);
  
   Map<String, dynamic> toJson(){
    return {
      'Nome' : nome,
      'Apelido' : apelido,
      'DataNascimento' : dataNascimento,
      'Contacto' : contacto,
      'Email' : email,
      'Password' : password
    };
  }

}