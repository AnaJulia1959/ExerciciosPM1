import 'Alimentos.dart';
import 'Lista.dart';
import 'AlimentosDao.dart';
import 'package:flutter/material.dart';

class ListaAlimentos extends StatefulWidget {
  final List<Alimentos> alimentos;
  final Function(int) onRemove;
  final Function(Alimentos) onInsert;

  const ListaAlimentos({
    required this.alimentos,
    required this.onRemove,
    required this.onInsert,
    super.key,
  });

  @override
  State<ListaAlimentos> createState() => _ListaAlimentosState();
}

class _ListaAlimentosState extends State<ListaAlimentos> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _caloriasController = TextEditingController();
  final TextEditingController _proteinasController = TextEditingController();
  final TextEditingController _carboController = TextEditingController();
  final TextEditingController _gorduraController = TextEditingController();

  final AlimentosDao _alimentosDao = AlimentosDao(); // Instância do DAO

  @override
  void initState() {
    super.initState();
    _alimentosDao.open(); // Abre o banco de dados
  }

  void openModal(BuildContext scaffoldContext) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(30),
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: Column(
                children: [
                  TextField(
                    decoration:
                        const InputDecoration(label: Text("Nome do Alimento")),
                    controller: _nomeController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        label: Text("Calorias por 100 Gramas")),
                    controller: _caloriasController,
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        label: Text("Proteínas por 100 Gramas")),
                    controller: _proteinasController,
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        label: Text("Carboidratos por 100 Gramas")),
                    controller: _carboController,
                    keyboardType: TextInputType.number,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        label: Text("Gordura por 100 Gramas")),
                    controller: _gorduraController,
                    keyboardType: TextInputType.number,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text("Salvar"),
                    onPressed: () {
                      final String nome = _nomeController.text;
                      final double? calorias =
                          double.tryParse(_caloriasController.text);
                      final double? proteinas =
                          double.tryParse(_proteinasController.text);
                      final double? carbo =
                          double.tryParse(_carboController.text);
                      final double? gordura =
                          double.tryParse(_gorduraController.text);

                      if (nome.isNotEmpty &&
                          calorias != null &&
                          proteinas != null &&
                          carbo != null &&
                          gordura != null) {
                        widget.onInsert(Alimentos(
                            nome: nome,
                            calorias: calorias,
                            proteinas: proteinas,
                            carbo: carbo,
                            gordura: gordura));

                        clearControllers();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                            const SnackBar(
                                content:
                                    Text("Alimento adicionado com sucesso!")));
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(scaffoldContext).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Preencha os campos corretamente!")));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void clearControllers() {
    _nomeController.clear();
    _caloriasController.clear();
    _proteinasController.clear();
    _carboController.clear();
    _gorduraController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Lista de Alimentos",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: ListView.builder(
        itemCount: widget.alimentos.length,
        itemBuilder: (context, index) {
          return Listinha(
            nome: widget.alimentos[index].nome,
            calorias: widget.alimentos[index].calorias,
            proteinas: widget.alimentos[index].proteinas,
            carbo: widget.alimentos[index].carbo,
            gordura: widget.alimentos[index].gordura,
            onRemoved: () => widget.onRemove(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openModal(context); // Abre o modal para adicionar
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
