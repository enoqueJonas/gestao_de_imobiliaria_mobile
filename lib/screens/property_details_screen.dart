import 'package:flutter/material.dart';
import 'package:gestao_de_imobiliaria_mobile/database/Models/imovel.dart';

class PropertyDetailScreen extends StatefulWidget  {
  final Imovel property;

  const PropertyDetailScreen({required this.property});

   @override
  _PropertyDetailScreenState createState() => _PropertyDetailScreenState();
}
  
class _PropertyDetailScreenState extends State<PropertyDetailScreen> {
   late PageController _pageController;

   @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _previousImage() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _nextImage() {
    if (_pageController.page! < (widget.property.images.length - 1)) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

    @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.property.titulo),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: widget.property.images.isNotEmpty
                      ? PageView.builder(
                          controller: _pageController,
                          itemCount: widget.property.images.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              widget.property.images[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            );
                          },
                        )
                      : Image.asset(
                          'assets/placeholder.png', // Provide a placeholder image in case there are no images
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                ),
                Positioned(
                  left: 10,
                  top: 80,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: _previousImage,
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 80,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.white),
                    onPressed: _nextImage,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.property.titulo, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text(widget.property.localizacao, style: TextStyle(fontSize: 20, color: Colors.grey)),
                  Text('\$${widget.property.preco}', style: TextStyle(fontSize: 22, color: Colors.green)),
                  SizedBox(height: 10),
                  Text('Beds: ${widget.property.quartos}'),
                  Text('Bathrooms: ${widget.property.casaBanhos}'),
                  Text('Size: ${widget.property.metrosQuadrados} m²'),
                  Text('Meses de Arrendamento: ${widget.property.mesesArrendamento}'),
                  SizedBox(height: 20),
                  Text('Description', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(widget.property.descricao ?? 'No description available', style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
