import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestao_de_imobiliaria_mobile/database/Models/imovel.dart';

class PropertyDetailScreen extends StatefulWidget  {
  final Imovel imovel;

  const PropertyDetailScreen({required this.imovel});

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
    if (_pageController.page! < (widget.imovel.images.length - 1)) {
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
        title: Text(widget.imovel.titulo),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  child: widget.imovel.images.isNotEmpty
                      ? PageView.builder(
                          controller: _pageController,
                          itemCount: widget.imovel.images.length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              widget.imovel.images[index],
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.imovel.titulo, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                       Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${widget.imovel.preco} MT',
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                              TextSpan(
                                text: '/mês',
                                style: TextStyle(
                                  color: Colors.grey,
                                  )
                              ),
                            ],
                          ),
                        ),
                    ]
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Color.fromRGBO(26, 147, 192, 1)),
                      Text('${widget.imovel.localizacao} - ${widget.imovel.provincia}', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),        
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Row(
                        children: [
                          Icon(Icons.bathtub, color: Color.fromRGBO(26, 147, 192, 1)),
                          SizedBox(width: 5),
                          Text('${widget.imovel.casaBanhos.toString()} Casas de Banho', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.bed, color: Color.fromRGBO(26, 147, 192, 1)),
                          SizedBox(width: 5),
                          Text('${widget.imovel.quartos.toString()} Quartos', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(Icons.square_foot, color: Color.fromRGBO(26, 147, 192, 1)),
                          SizedBox(width: 5),
                          Text('${widget.imovel.metrosQuadrados.toString()} m²', style: TextStyle(color: Colors.grey)),
                        ]
                      )
                      ],
                    ),
                  SizedBox(height: 20),
                  Text('Descrição', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(widget.imovel.descricao ?? 'Sem descrição disponivel', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  SizedBox(height: 20),
                  Text('Facilidades', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: widget.imovel.facilidades.map((item) {
                      return Chip(
                        label: Text(item),
                        shape: StadiumBorder(
                          side: BorderSide(color: const Color.fromRGBO(26, 147, 192, 1))
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Text('Proximidades', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: widget.imovel.proximidades.map((item) {
                      return Chip(
                        label: Text(item),
                        shape: StadiumBorder(
                          side: BorderSide(color: const Color.fromRGBO(26, 147, 192, 1))
                        )
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    height: 2,
                    thickness: 2,      
                    color: const Color.fromARGB(255, 167, 167, 167)
                  ),
                  SizedBox(height: 10),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '${widget.imovel.preco} MT',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        TextSpan(
                          text: '/mês',
                          style: TextStyle(
                            color: Colors.grey,
                            )
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('Pagamento de ${widget.imovel.mesesArrendamento.toString()} meses adiantados no início do contrato.'),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.calendar_month, color: Colors.black),
                            label: const Text('Agendar visita', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16, color: Colors.black)),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              side: BorderSide(color: Colors.black, width: 2),
                            ),
                          ),
                        ),
                        SizedBox(width: 10), 
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.message, color: Colors.white),
                            label: const Text('Mensagem', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                              ),
                              backgroundColor: const Color.fromRGBO(26, 147, 192, 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
