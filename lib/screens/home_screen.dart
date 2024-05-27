import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/register_property_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/login_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/widgets/category_widget.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/widgets/imove_item_widget.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/widgets/property_list_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  void _navigateToRegisterProperty(BuildContext context) {
    if (user != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => RegisterPropertyScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Faça login para adicionar imovel.'),
        ),
      );

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

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
        drawer: Drawer(
          backgroundColor: const Color.fromRGBO(26, 147, 192, 1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 25.0, top: 50.0, bottom: 25.0),
                    child: ListTile(
                      title: Text(
                        "KAYA",
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      title: Text(
                        '${user != null ? user!.email : 'Home' }',
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
                      onTap: () => _navigateToRegisterProperty(context),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: TextButton(
                        onPressed: () {},
                        child: Text("Perfil",
                            style: TextStyle(color: Colors.white)),
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
                  title: TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();

                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: Text("Sair", style: TextStyle(color: Colors.white)),
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
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.black),
                        Container(
                          height: 50,
                          width: 300,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Pesquisar por uma localização',
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),

            //Categoria
            const Padding(
                padding: EdgeInsets.only(top: 20, left: 20),
                child: Text(
                  'Categoria',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),

            const CategoryWidget(),

            //const ImovelItemWidget(),
            //const ImovelItemWidget(),
            PropertyListWidget(),
          ],
        ));
  }
}
