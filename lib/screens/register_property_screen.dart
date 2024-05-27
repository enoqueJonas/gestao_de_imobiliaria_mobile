// register_property_screen.dart

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestao_de_imobiliaria_mobile/database/Models/imovel.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/home_screen.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/widgets/custom_input_decoration.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/widgets/custom_input_icon_decoration.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/widgets/dropdown_button_widget.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/widgets/image_upload_widget.dart';
import 'package:gestao_de_imobiliaria_mobile/screens/widgets/multi_select_dialog_field_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class RegisterPropertyScreen extends StatefulWidget {
  @override
  _RegisterPropertyScreenState createState() => _RegisterPropertyScreenState();
}

class _RegisterPropertyScreenState extends State<RegisterPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isUploading = false;
  List<XFile>? _imageFileList = [];

  Imovel _imovel = Imovel(
    tipo: '',
    titulo: '',
    provincia: '',
    localizacao: '',
    descricao: '',
    quartos: 0,
    casaBanhos: 0,
    metrosQuadrados: 0,
    andar: 0,
    preco: 0,
    mesesArrendamento: 0,
    facilidades: [],
    proximidades: [],
    images: [],
  );

  List<String> _propertyTypes = [
    'Apartamento',
    'Geminada',
    'Vivenda',
    'Moradia',
    'Quinta'
  ];
  List<String> _provinces = [
    'Maputo',
    'Gaza',
    'Inhambane',
    'Sofala',
    'Manica',
    'Tete',
    'Zambézia',
    'Nampula',
    'Niassa',
    'Cabo Delgado'
  ];
  List<String> _facilities = ['Wi-Fi', 'Piscina', 'Academia', 'Estacionamento'];
  List<String> _proximities = [
    'Supermercado',
    'Hospital',
    'Transporte Público',
    'Escola'
  ];

  Future<void> _registerProperty() async {
    try {
      final User? user = FirebaseAuth.instance.currentUser;
      /*setState(() {
        _isUploading = true; // Set to true when starting upload
      });
      */

      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        _imovel.id = user!.uid;

        // Upload images to Firebase Storage and get image URLs
        List<String> imageUrls = await _uploadImagesToStorage();

        // Update the property object with image URLs
        _imovel.images = imageUrls;

        // Save the property in Firestore
        await FirebaseFirestore.instance
            .collection('user_imoveis')
            .add(_imovel.toJson());
        /*
        setState(() {
          _isUploading = false; // Set back to false when upload is complete
        });
        */

        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Registado com sucesso!'),
          backgroundColor: Colors.green,
        ));

        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    } on FirebaseException catch (e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro: ${e.toString()}'),
        backgroundColor: Colors.red,
      ));
    }
  }

  // Function to upload images to Firebase Storage
  Future<List<String>> _uploadImagesToStorage() async {
    List<String> imageUrls = [];

    for (XFile imageFile in _imageFileList!) {
      // Upload imageFile to Firebase Storage and get the download URL
      String imageUrl = await _uploadImageToStorage(imageFile);
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }

  Future<String> _uploadImageToStorage(XFile imageFile) async {
    File file = File(imageFile.path);
    // Upload imageFile to Firebase Storage and return the download URL
    String generateImageName = const Uuid().v4();
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_imovel_images')
        .child('$generateImageName.jpg');
    await storageRef.putFile(file);

    final imageUrl = storageRef.getDownloadURL();
    return imageUrl; // Placeholder URL
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Adicionar Imóvel'),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    DropdownButtonCombBox(
                      typeValue: 'Tipo de Propriedade',
                      values: _propertyTypes,
                      selectedValue: _imovel.tipo,
                      onChanged: (value) => setState(() {
                        _imovel.tipo = value!;
                      }),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Campo obrigatório.' : null,
                      decoration: customInputDecoration(hintText: 'Titulo'),
                      onSaved: (value) => _imovel.titulo,
                    ),
                    const SizedBox(height: 10),
                    DropdownButtonCombBox(
                      typeValue: 'Provincia',
                      values: _provinces,
                      selectedValue: _imovel.provincia,
                      onChanged: (value) => setState(() {
                        _imovel.provincia = value!;
                      }),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Campo obrigatório' : null,
                      decoration: customInputDecoration(
                          hintText: 'Bairro, Avenida ou Rua'),
                      onSaved: (value) => _imovel.localizacao,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Campo obrigatório' : null,
                      keyboardType: TextInputType.number,
                      decoration: customInputDecoration(hintText: "Preço"),
                      onSaved: (value) => _imovel.preco = int.tryParse(value!)!,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Campo obrigatório' : null,
                      keyboardType: TextInputType.number,
                      decoration: customInputDecoration(
                          hintText: 'Número de meses a ser adiantado'),
                      onSaved: (value) =>
                          _imovel.mesesArrendamento = int.tryParse(value!)!,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Informações básicas',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    ImageUploadWidget(
                      imageFileList: _imageFileList,
                      onImagesSelected: (images) {
                        setState(() {
                          _imageFileList = images;
                        });
                      },
                    ),
                    TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? 'Campo obrigatório' : null,
                        keyboardType: TextInputType.number,
                        decoration: customInputIconDecoration(
                            hintText: 'Casas de Banho',
                            prefixIcon: Icons.bathtub),
                        onSaved: (value) =>
                            _imovel.casaBanhos = int.tryParse(value!)!),
                    const SizedBox(height: 10),
                    TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? 'Campo obrigatório' : null,
                        keyboardType: TextInputType.number,
                        decoration: customInputIconDecoration(
                            hintText: 'Quartos',
                            prefixIcon: Icons.bed_outlined),
                        onSaved: (value) =>
                            _imovel.quartos = int.tryParse(value!)!),
                    const SizedBox(height: 10),
                    TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? 'Campo obrigatório' : null,
                        keyboardType: TextInputType.number,
                        decoration: customInputIconDecoration(
                            hintText: 'Metros quadrados',
                            prefixIcon: Icons.square_foot_outlined),
                        onSaved: (value) =>
                            _imovel.metrosQuadrados = int.tryParse(value!)!),
                    const SizedBox(height: 10),
                    TextFormField(
                        validator: (value) =>
                            value!.isEmpty ? 'Campo obrigatório' : null,
                        keyboardType: TextInputType.number,
                        decoration: customInputIconDecoration(
                            hintText: 'Andar',
                            prefixIcon: Icons.stairs_outlined),
                        onSaved: (value) =>
                            _imovel.andar = int.tryParse(value!)!),
                    const SizedBox(height: 10),
                    TextFormField(
                      validator: (value) =>
                          value!.isEmpty ? 'Campo obrigatório.' : null,
                      keyboardType: TextInputType.text,
                      decoration: customInputDecoration(
                          hintText: 'Descrições do imovel'),
                      onSaved: (value) => _imovel.descricao,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Facilidades',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    MultiSelectDialogFieldWidget(
                      items: _facilities,
                      title: 'Facilidades',
                      onConfirm: (values) {
                        setState(() {
                          _imovel.facilidades = values;
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Proximidades',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    MultiSelectDialogFieldWidget(
                      items: _proximities,
                      title: 'Proximidades',
                      onConfirm: (values) {
                        setState(() {
                          _imovel.proximidades = values;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _registerProperty,
                      child: Text('Registrar Imóvel'),
                    ),
                  ],
                ),
              ),
            ),
            /*
            if (_isUploading) // Show the loading indicator
              Center(
                child: CircularProgressIndicator(),
              ),
            */
          ],
        ));
  }
}
