import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestao_de_imobiliaria_mobile/home/app_bar_widget.dart';
import 'package:gestao_de_imobiliaria_mobile/home/category_widget.dart';
import 'package:gestao_de_imobiliaria_mobile/home/imove_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const AppBarWidget(),

          //Pesquisar
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15
            ),
            child: Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey)
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.black),
                    Container(
                      height: 50,
                      width: 300,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(
                          horizontal: 15
                        ),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Pesquisar por uma localização',
                            border: InputBorder.none
                          ),
                        ),
                      ),
                    ),
                    Icon(Icons.filter_list),
                  ],
                ),
              )
            ),
          ),

          //Categoria
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Text(
              'Categoria',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),
            )
          ),

          const CategoryWidget(),

          const ImovelItemWidget(),
          const ImovelItemWidget(),
        ],
      )
    );
  }
}

