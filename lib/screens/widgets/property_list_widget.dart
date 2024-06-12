import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/property_details_screen.dart';
import 'property_card_widget.dart';
import 'package:gestao_de_imobiliaria_mobile/database/Models/imovel.dart';

class PropertyListWidget extends StatelessWidget {
  const PropertyListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('user_imoveis').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          print('Erro ao carregar dados fo firestore ${snapshot.error}');
          return const Center(
            child: Text('Erro ao carregar imoveis. Por favor tente novamente.'),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.home,
                  size: 50.0,
                  color: Colors.grey,
                ),
                SizedBox(height: 10),
                Text(
                  'Nenhum imóvel disponível ...',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        final imoveis = snapshot.data!.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return Imovel.fromJson(data);
        }).toList();

        return ListView.builder(
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
