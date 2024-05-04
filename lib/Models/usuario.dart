class Usuario {
  String Nome;
  String Apelido;
  String DataNascimento;
  String Contacto;
  String Email;
  String Password;

  Usuario(this.Nome, this.Apelido, this.DataNascimento, this.Contacto,
      this.Email, this.Password);
  
  Map<String, dynamic> toMap() {
    return {
      'nome': Nome,
      'apelido': Apelido,
      'dataNascimento': DataNascimento,
      'contacto': Contacto,
      'email': Email,
      'password': Password,
    };
  }

  Usuario.fromMap(Map<String, dynamic> map)
      : Nome = map['nome'],
        Apelido = map['apelido'],
        DataNascimento = map['dataNascimento'],
        Contacto = map['contacto'],
        Email = map['email'],
        Password = map['password'];
}
