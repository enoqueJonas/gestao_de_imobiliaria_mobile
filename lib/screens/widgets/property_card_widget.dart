// property_card_widget.dart

import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final String imageUrl;
  final String titulo;
  final String provincia;
  final String localizacao;
  String? descricao;
  final int preco;
  final int quartos;
  final int casasBanho;
  int? andar;
  final int metrosQuadrados;
  int? mesesArrendamento;
  final VoidCallback onTap;

  PropertyCard({
    required this.imageUrl,
    required this.titulo,
    required this.localizacao,
    required this.provincia,
    required this.preco,
    required this.quartos,
    required this.casasBanho,
    required this.metrosQuadrados,
    required this.onTap,
    this.mesesArrendamento,
    this.descricao,
    this.andar
  });

  @override
  Widget build(BuildContext context) {
    return InkWell (
    onTap: onTap,
    child: Card(
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(titulo, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Icon(Icons.location_on, color: Color.fromRGBO(26, 147, 192, 1)),
                    Text('${localizacao} - ${provincia}', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [                                    
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${preco.toString()} MT',
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                          TextSpan(
                            text: '/mês',
                            style: TextStyle(
                              color: Colors.grey,
                              )
                          ),
                        ],
                      ),
                    ),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Row(
                        children: [
                          Icon(Icons.bathtub, color: Color.fromRGBO(26, 147, 192, 1)),
                          SizedBox(width: 3),
                          Text('${casasBanho.toString()}', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(width: 10),
                      Row(
                        children: [
                          Icon(Icons.bed, color: Color.fromRGBO(26, 147, 192, 1)),
                          SizedBox(width: 3),
                          Text('${quartos.toString()}', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      SizedBox(width: 10),
                      Row(
                        children: [
                          Icon(Icons.square_foot, color: Color.fromRGBO(26, 147, 192, 1)),
                          SizedBox(width: 3),
                          Text('${metrosQuadrados.toString()}m²', style: TextStyle(color: Colors.grey)),
                        ]
                      )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
