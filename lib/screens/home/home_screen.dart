import 'package:flutter/material.dart';

import 'package:gestao_de_imobiliaria_mobile/screens/home/category_widget.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/home/imove_item_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: const Drawer(
        backgroundColor: const Color.fromRGBO(26, 147, 192, 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                 Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Adicionar imovel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 25.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Perfil",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 25.0, bottom: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                title: Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      body: ListView(
        children: [
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

