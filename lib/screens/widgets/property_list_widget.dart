// property_list_widget.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/property_details_screen.dart';
import 'property_card_widget.dart';
import 'package:gestao_de_imobiliaria_mobile/database/Models/imovel.dart';

class PropertyListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('user_imoveis').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final imoveis = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Imovel.fromJson(data);
        }).toList();

        if (imoveis.isEmpty) {
          return Center(child: Text('Nenhum imoveil disponivel'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: imoveis.length,
          itemBuilder: (context, index) {
            final imovel = imoveis[index];
            return PropertyCard(
              imageUrl: imovel.images.isNotEmpty ? imovel.images[0] : '',
              titulo: imovel.titulo,
              provincia: imovel.provincia,
              localizacao: imovel.localizacao,
              preco: imovel.preco,
              quartos: imovel.quartos,
              casasBanho: imovel.casaBanhos,
              metrosQuadrados: imovel.metrosQuadrados,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PropertyDetailScreen(imovel: imovel),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
