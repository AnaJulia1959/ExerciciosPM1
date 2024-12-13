import 'Destiny.dart';
import 'ListCardDestiny.dart';
import 'package:flutter/material.dart';

class listDestiny extends StatefulWidget {
  final List<Destiny> destinos;
  final Function(Destiny) onInsert;
  final Function(int) onRemove;

  const listDestiny(
      {required this.destinos,
      required this.onInsert,
      required this.onRemove,
      super.key});

  @override
  State<listDestiny> createState() => _listDestinyState();
}

class _listDestinyState extends State<listDestiny> {
  final TextEditingController _nomeCidadeControl = TextEditingController();
  final TextEditingController _KmCidadeControl = TextEditingController();

  void openModal(BuildContext scaffoldContext) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
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
                    label: Text("Nome da cidade"),
                    labelStyle: TextStyle(color: Colors.pinkAccent),
                  ),
                  controller: _nomeCidadeControl,
                ),
                const SizedBox(height: 10),
                TextField(
                  decoration: const InputDecoration(
                    label: Text("Distância (KM)"),
                    labelStyle: TextStyle(color: Colors.pinkAccent),
                  ),
                  controller: _KmCidadeControl,
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
                    final String nomeCidade = _nomeCidadeControl.text;
                    final double? km = double.tryParse(_KmCidadeControl.text);

                    if (nomeCidade.isNotEmpty && km != null) {
                      widget.onInsert(
                          Destiny(nomeCidade: nomeCidade, KM: km));

                      _KmCidadeControl.clear();
                      _nomeCidadeControl.clear();

                      Navigator.pop(context);

                      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                          const SnackBar(
                              content: Text("Destino adicionado com sucesso!"),
                              backgroundColor: Colors.pinkAccent));
                    } else {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                          const SnackBar(
                              content:
                                  Text("Preencha os campos corretamente!"),
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
          "Lista de Destinos",
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
          itemCount: widget.destinos.length,
          itemBuilder: (context, index) {
            return listCardDestiny(
              nome: widget.destinos[index].nomeCidade,
              km: widget.destinos[index].KM,
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
