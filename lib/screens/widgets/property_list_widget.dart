// property_list_widget.dart

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

        final properties = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Imovel.fromJson(data);
        }).toList();

        if (properties.isEmpty) {
          return Center(child: Text('No properties found'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: properties.length,
          itemBuilder: (context, index) {
            final property = properties[index];
            return PropertyCard(
              imageUrl: property.images.isNotEmpty ? property.images[0] : '',
              title: property.titulo,
              location: property.localizacao,
              price: property.preco,
              beds: property.quartos,
              bathrooms: property.casaBanhos,
              squareMeters: property.metrosQuadrados,
              mesesArrendamento: property.mesesArrendamento
            );
          },
        );
      },
    );
  }
}