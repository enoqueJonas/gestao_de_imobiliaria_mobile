// image_upload_widget.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadWidget extends StatefulWidget {
  final List<XFile>? imageFileList;
  final Function(List<XFile>?)? onImagesSelected;

  const ImageUploadWidget({
    Key? key,
    this.imageFileList,
    this.onImagesSelected,
  }) : super(key: key);

  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  final ImagePicker _picker = ImagePicker();
  bool _isPickingImage = false;

  Future<void> _getImage() async {
    if (_isPickingImage) return;
    setState(() {
      _isPickingImage = true;
    });

    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          widget.imageFileList!.add(image);
          widget.onImagesSelected!(widget.imageFileList);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao selecionar imagem: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isPickingImage = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _getImage,
          child: Text('Adicionar Imagem'),
        ),
        SizedBox(height: 10),
        if (widget.imageFileList != null && widget.imageFileList!.isNotEmpty)
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.imageFileList!.length,
              itemBuilder: (context, index) {
                final XFile image = widget.imageFileList![index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Image.file(
                    File(image.path),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}
