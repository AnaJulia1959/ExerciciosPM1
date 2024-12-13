import 'ListCardWidget.dart';
import 'package:flutter/material.dart';
import 'Car.dart';
import 'database_helper.dart';

class listCars extends StatefulWidget {
  final List<Car> carros;
  final Function(int) onRemove;
  final Function(Car) onInsert;

  const listCars(
      {required this.carros,
      required this.onRemove,
      required this.onInsert,
      super.key});

  @override
  State<listCars> createState() => _listCarsState();
}

class _listCarsState extends State<listCars> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _kmController = TextEditingController();

  void openModal(BuildContext scaffoldContext) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFFE4E1), Color(0xFFFFC1C1)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    label: Text("Nome do Carro"),
                    labelStyle: TextStyle(color: Colors.pinkAccent),
                  ),
                  controller: _nomeController,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    label: Text("KMs por Litro"),
                    labelStyle: TextStyle(color: Colors.pinkAccent),
                  ),
                  controller: _kmController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Salvar",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    final String nome = _nomeController.text;
                    final double? km = double.tryParse(_kmController.text);

                    if (nome.isNotEmpty && km != null) {
                      widget.onInsert(Car(nome: nome, KM_perL: km));

                      _nomeController.clear();
                      _kmController.clear();

                      Navigator.pop(context);

                      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                          const SnackBar(
                              content: Text("Carro adicionado com sucesso!"),
                              backgroundColor: Colors.pinkAccent));
                    } else {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                          const SnackBar(
                              content: Text("Preencha os campos corretamente!"),
                              backgroundColor: Colors.redAccent));
                    }
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Lista de Carros",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE4E1), Color(0xFFFFC1C1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: widget.carros.length,
          itemBuilder: (context, index) {
            return listCard(
              nome: widget.carros[index].nome,
              km: widget.carros[index].KM_perL,
              onRemoved: () => widget.onRemove(index),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModal(context);
        },
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
