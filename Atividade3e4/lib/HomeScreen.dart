import 'package:flutter/material.dart';
import 'CalcScreen.dart';
import 'Destiny.dart';
import 'ListCars.dart';
import 'ListDestiny.dart';
import 'Car.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _indexSelecionado = 0;

  final List<Car> _carros = [
    Car(nome: "Onix", KM_perL: 25.0),
    Car(nome: "Versa", KM_perL: 25.0),
  ];

  final List<Destiny> _destinos = [
    Destiny(nomeCidade: "Bagé", KM: 300),
    Destiny(nomeCidade: "Porto Alegre", KM: 500),
  ];

  void _itemSelecionado(int index) {
    setState(() {
      _indexSelecionado = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      CalcScreen(
        carros: _carros,
        destinos: _destinos,
      ),
      listCars(
        carros: _carros,
        onRemove: (index) => setState(() => _carros.removeAt(index)),
        onInsert: (car) => setState(() => _carros.add(car)),
      ),
      listDestiny(
        destinos: _destinos,
        onInsert: (destino) => setState(() => _destinos.add(destino)),
        onRemove: (index) => setState(() => _destinos.removeAt(index)),
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE4E1), Color(0xFFFFC1C1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: widgetOptions[_indexSelecionado],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Cálculo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: 'Carros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pin_drop),
            label: 'Destinos',
          ),
        ],
        currentIndex: _indexSelecionado,
        selectedItemColor: Colors.pinkAccent,
        onTap: _itemSelecionado,
      ),
    );
  }
}
