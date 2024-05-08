class Usuario {
  int IdUsuario;
  String Nome;
  String Apelido;
  String DataNascimento;
  String Contacto;
  String Email;
  String Password;

  Usuario(this.IdUsuario, this.Nome, this.Apelido, this.DataNascimento,
      this.Contacto, this.Email, this.Password);

  Map<String, dynamic> toMap() {
    return {
      'idUsuario': IdUsuario,
      'nome': Nome,
      'apelido': Apelido,
      'dataNascimento': DataNascimento,
      'contacto': Contacto,
      'email': Email,
      'password': Password,
    };
  }

  Usuario.fromMap(Map<String, dynamic> map)
      : IdUsuario = map['idUsuario'],
        Nome = map['nome'],
        Apelido = map['apelido'],
        DataNascimento = map['dataNascimento'],
        Contacto = map['contacto'],
        Email = map['email'],
        Password = map['password'];
}
