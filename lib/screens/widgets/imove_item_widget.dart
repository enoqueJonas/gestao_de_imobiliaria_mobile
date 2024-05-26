import 'package:flutter/material.dart';

class ImovelItemWidget extends StatelessWidget {
  const ImovelItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: GestureDetector(
        onTap: () {},
        child: Card(
         color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  'images/house_1.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                child: Text(
                  'Apartamento T2',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Row(children: [
                SizedBox(width: 10),
                Icon(Icons.location_on_outlined, color: Color.fromRGBO(26, 147, 192, 1)),
                SizedBox(width: 2),
                Text(
                  'Bairro da SommersChild, Av. Marginal - Maputo',
                  style: TextStyle(color: Colors.grey),
                )
              ]),
              const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '22.000 MT/mes',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(Icons.bathtub_outlined, color: Color.fromRGBO(26, 147, 192, 1)),
                          Text(
                            ' 2',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.bed_outlined, color: Color.fromRGBO(26, 147, 192, 1)),
                          Text(
                            ' 2',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.apps_rounded, color: Color.fromRGBO(26, 147, 192, 1)),
                          Text(
                            ' 175 m2',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                          SizedBox(width: 3)
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
