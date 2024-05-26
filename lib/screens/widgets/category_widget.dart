import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:  
      Row(
            children: [
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 30,
                          ),
                          backgroundColor: const Color.fromRGBO(26, 147, 192, 1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                      child: const Text('Tudo',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: OutlinedButton.icon(
                      icon: const Icon(Icons.holiday_village, color: const Color.fromRGBO(26, 147, 192, 1)),
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 35,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      label: const Text('Arrendar',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)))),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: OutlinedButton.icon(
                      icon: const Icon(Icons.shopping_bag_outlined, color: const Color.fromRGBO(26, 147, 192, 1)),
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 35,
                        ),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      label: const Text('Comprar',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 16)))),
            ],
          ));
    
  }
}
