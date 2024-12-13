import 'package:flutter/material.dart';
import 'package:fitapp/Alimentos.dart';
import 'package:fitapp/AlimentosDao.dart';
import 'package:fitapp/Calculadora.dart';
import 'package:fitapp/ListaAlimentos.dart';
import 'package:fitapp/ReceitasScreen.dart';

class Telainicial extends StatefulWidget {
  const Telainicial({super.key});

  @override
  State<Telainicial> createState() => _TelainicialState();
}

class _TelainicialState extends State<Telainicial> {
  int _indexSelecionado = 0;
  final PageController _pageController = PageController();
  final AlimentosDao _alimentosDao = AlimentosDao();
  List<Alimentos> _alimentos = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    await _alimentosDao.open();
    _alimentos = await _alimentosDao.selectAlimento();
    setState(() {});
  }

  void _delAlimentos(int index) async {
    await _alimentosDao.deleteAlimento(_alimentos[index]);
    setState(() {
      _alimentos.removeAt(index);
    });
  }

  void _insAlimentos(Alimentos alimento) async {
    await _alimentosDao.insertAlimentos(alimento);
    setState(() {
      _alimentos.add(alimento);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _indexSelecionado = index;
          });
        },
        children: [
          Calculadora(alimentos: _alimentos),
          ListaAlimentos(
            alimentos: _alimentos,
            onRemove: _delAlimentos,
            onInsert: _insAlimentos,
          ),
          ReceitasScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Cálculo',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Alimentos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.api),
            label: 'Receitas',
          ),
        ],
        currentIndex: _indexSelecionado,
        selectedItemColor: Colors.pinkAccent,
        onTap: (index) {
          setState(() {
            _indexSelecionado = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
      ),
      floatingActionButton: _indexSelecionado == 1
          ? FloatingActionButton(
              onPressed: () {
              },
              backgroundColor: Colors.pinkAccent,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}
