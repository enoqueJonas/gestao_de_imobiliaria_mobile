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
import 'package:gestao_de_imobiliaria_mobile/screens/widgets/show_snackbar_widget.dart';
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

  late TextEditingController _tituloController;
  late TextEditingController _localizacaoController;
  late TextEditingController _precoController;
  late TextEditingController _mesesArrendamentoController;
  late TextEditingController _casaBanhosController;
  late TextEditingController _quartosController;
  late TextEditingController _metrosQuadradosController;
  late TextEditingController _andarController;
  late TextEditingController _descricaoController;

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

  List<String> _tiposImoveis = [
    'Apartamento',
    'Geminada',
    'Vivenda',
    'Moradia',
    'Quinta'
  ];
  List<String> _provincias = [
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
  List<String> _facilidades = [
    'Wi-Fi', 
    'Piscina',  
    'Estacionamento', 
    'CCTV', 
    'Elevador', 
    'Guarda', 
    'Termno acumulador'
  ];
  List<String> _proximidades = [
    'Centros religiosos',
    'Escolas públicas',
    'Escolas privadas',
    'Esquadra da polica',
    'Ginasio',
    'Jardim',
    'Hospital',
    'Restuarante e Bar',
    'Paragem de autocarro',
    'Supermercado',
  ];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _tituloController = TextEditingController();
    _localizacaoController = TextEditingController();
    _precoController = TextEditingController();
    _mesesArrendamentoController = TextEditingController();
    _casaBanhosController = TextEditingController();
    _quartosController = TextEditingController();
    _metrosQuadradosController = TextEditingController();
    _andarController = TextEditingController();
    _descricaoController = TextEditingController();
  }

   @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _disposeControllers() {
    _tituloController.dispose();
    _localizacaoController.dispose();
    _precoController.dispose();
    _mesesArrendamentoController.dispose();
    _casaBanhosController.dispose();
    _quartosController.dispose();
    _metrosQuadradosController.dispose();
    _andarController.dispose();
    _descricaoController.dispose();
  }

  Future<void> _registerProperty() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        showErrorSnackbar(context, 'Utilizador não autenticado.');
        return;
      }

      _imovel.id = user.uid;
      setState(() => _isUploading = true);

      try {
        List<String> imageUrls = await _uploadImagesToStorage();
        _imovel.images = imageUrls;
        await FirebaseFirestore.instance
            .collection('user_imoveis')
            .add(_imovel.toJson());
        
        showSuccessSnackbar(context, 'Utilizador registado com sucesso.');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen())
        );
      } on FirebaseException catch (e) {
        showErrorSnackbar(context, 'Erro: ${e.message}');
      } finally {
        setState(() => _isUploading = false);
      }
    }
  }


  Future<List<String>> _uploadImagesToStorage() async {
    List<String> imageUrls = [];

    for (XFile imageFile in _imageFileList!) {
      String imageUrl = await _uploadImageToStorage(imageFile);
      imageUrls.add(imageUrl);
    }
    return imageUrls;
  }

  Future<String> _uploadImageToStorage(XFile imageFile) async {
    File file = File(imageFile.path);
    String generateImageName = const Uuid().v4();
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('user_imovel_images')
        .child('$generateImageName.jpg');
    await storageRef.putFile(file);

    final imageUrl = await storageRef.getDownloadURL();
    return imageUrl;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Imóvel'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              DropdownButtonCombBox(
                typeValue: 'Tipo de Propriedade',
                values: _tiposImoveis,
                selectedValue: _imovel.tipo,
                onChanged: (value) => setState(() {
                  _imovel.tipo = value!;
                }),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _tituloController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório.' : null,
                decoration: customInputDecoration(hintText: 'Titulo'),
                onSaved: (value) => _imovel.titulo = value!,
                
              ),
              const SizedBox(height: 10),
              DropdownButtonCombBox(
                typeValue: 'Provincia',
                values: _provincias,
                selectedValue: _imovel.provincia,
                onChanged: (value) => setState(() {
                  _imovel.provincia = value!;
                }),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _localizacaoController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                decoration: customInputDecoration(hintText: 'Bairro'),
                onSaved: (value) => _imovel.localizacao = value!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _precoController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                keyboardType: TextInputType.number,
                decoration: customInputDecoration(hintText: "Preço"),
                onSaved: (value) => _imovel.preco = int.tryParse(value!)!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _mesesArrendamentoController,
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
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                controller: _casaBanhosController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                keyboardType: TextInputType.number,
                decoration: customInputIconDecoration(
                    hintText: 'Casas de Banho', prefixIcon: Icons.bathtub),
                onSaved: (value) => _imovel.casaBanhos = int.tryParse(value!)!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _quartosController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                keyboardType: TextInputType.number,
                decoration: customInputIconDecoration(
                    hintText: 'Quartos', prefixIcon: Icons.bed_outlined),
                onSaved: (value) => _imovel.quartos = int.tryParse(value!)!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _metrosQuadradosController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                keyboardType: TextInputType.number,
                decoration: customInputIconDecoration(
                    hintText: 'Metros quadrados',
                    prefixIcon: Icons.square_foot_outlined),
                onSaved: (value) =>
                    _imovel.metrosQuadrados = int.tryParse(value!)!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _andarController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório' : null,
                keyboardType: TextInputType.number,
                decoration: customInputIconDecoration(
                    hintText: 'Andar', prefixIcon: Icons.stairs_outlined),
                onSaved: (value) => _imovel.andar = int.tryParse(value!)!,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descricaoController,
                validator: (value) =>
                    value!.isEmpty ? 'Campo obrigatório.' : null,
                keyboardType: TextInputType.text,
                decoration: customInputDecoration(hintText: 'Descrições do imovel'),
                onSaved: (value) => _imovel.descricao = value!,
              ),
              const SizedBox(height: 10),
              Text(
                'Facilidades',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              MultiSelectDialogFieldWidget(
                items: _facilidades,
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              MultiSelectDialogFieldWidget(
                items: _proximidades,
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
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: const Color.fromRGBO(26, 147, 192, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Text(
                  'Registrar Imóvel',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
