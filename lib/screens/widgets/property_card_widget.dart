// property_card_widget.dart

import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final int price;
  final int beds;
  final int bathrooms;
  final int squareMeters;
  final int mesesArrendamento;
  final VoidCallback onTap;

  const PropertyCard({
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.price,
    required this.beds,
    required this.bathrooms,
    required this.squareMeters,
    required this.mesesArrendamento,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(location, style: TextStyle(fontSize: 16, color: Colors.grey)),
                Text('\$${price.toString()}', style: TextStyle(fontSize: 18, color: Colors.green)),
                Row(
                  children: [
                    Icon(Icons.bed, color: Colors.grey),
                    Text(beds.toString()),
                    SizedBox(width: 10),
                    Icon(Icons.bathtub, color: Colors.grey),
                    Text(bathrooms.toString()),
                    SizedBox(width: 10),
                    Icon(Icons.square_foot, color: Colors.grey),
                    Text('${squareMeters.toString()} m²'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
