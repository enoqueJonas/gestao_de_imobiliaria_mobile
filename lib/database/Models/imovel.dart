import 'package:cloud_firestore/cloud_firestore.dart';

class Imovel {
  String? id;
  String tipo;
  String titulo;
  String provincia;
  String localizacao;
  String descricao;
  int quartos;
  int casaBanhos;
  int metrosQuadrados;
  int andar;
  int preco;
  int mesesArrendamento;
  List<String> facilidades;
  List<String> proximidades;
  List<String> images;
  Timestamp? dataCriacao; 

  Imovel({
    this.id,
    required this.tipo,
    required this.titulo,
    required this.provincia,
    required this.localizacao,
    required this.descricao,
    required this.quartos,
    required this.casaBanhos,
    required this.metrosQuadrados,
    required this.andar,
    required this.preco,
    required this.mesesArrendamento,
    required this.facilidades,
    required this.proximidades,
    required this.images
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'tipo': tipo,
      'titulo': titulo,
      'provincia': provincia,
      'localizacao': localizacao,
      'descricao': descricao,
      'quartos': quartos,
      'casaBanhos': casaBanhos,
      'metrosQuadrados': metrosQuadrados,
      'andar': andar,
      'preco': preco,
      'mesesArrendamento': mesesArrendamento,
      'facilidades': facilidades,
      'proximidades': proximidades,
      'images': images,
      'dataCriacao': Timestamp.now()
    };
  }

  factory Imovel.fromJson(Map<String, dynamic> map) {
    return Imovel(
      id: map['id'],
      tipo: map['tipo'],
      titulo: map['titulo'],
      provincia: map['provincia'],
      localizacao: map['localizacao'],
      descricao: map['descricao'],
      quartos: map['quartos'],
      casaBanhos: map['casaBanhos'],
      metrosQuadrados: map['metrosQuadrados'],
      andar: map['andar'],
      preco: map['preco'],
      mesesArrendamento: map['mesesArrendamento'],
      facilidades: List<String>.from(map['facilidades']),
      proximidades: List<String>.from(map['proximidades']),
      images: List<String>.from(map['images']),
    );
  }
}
