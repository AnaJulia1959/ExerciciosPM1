import 'Alimentos.dart';
import 'package:flutter/material.dart';

class Calculadora extends StatefulWidget {
  final List<Alimentos> alimentos;

  const Calculadora({
    super.key,
    required this.alimentos,
  });

  @override
  State<Calculadora> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<Calculadora> {
  String? _alimentoSelecionado;
  double _gramosing = 100;
  double _caltotal = 0;
  double _prototal = 0;
  double _carbtotal = 0;
  double _gortotal = 0;

  final TextEditingController _ingeridoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _ingeridoController.text = _gramosing.toString();
  }

  void calcularCusto() {
    if (_alimentoSelecionado != null) {
      Alimentos alimentos = widget.alimentos
          .firstWhere((ali) => ali.nome == _alimentoSelecionado);

      double quantcal = alimentos.calorias / 100;
      double quantpro = alimentos.proteinas / 100;
      double quantcar = alimentos.carbo / 100;
      double quantgor = alimentos.gordura / 100;

      setState(() {
        _caltotal = quantcal * _gramosing;
        _prototal = quantpro * _gramosing;
        _carbtotal = quantcar * _gramosing;
        _gortotal = quantgor * _gramosing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.pinkAccent.shade100,
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.pink,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Quantidade Ingerida",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.pink,
                        ),
                      ),
                      Text(
                        "${_gramosing.toString()} g",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Escolha um Alimento",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.pink,
                ),
              ),
              SizedBox(
                width: 300,
                child: DropdownButton<String>(
                  isExpanded: true,
                  hint: const Text("Selecione um alimento"),
                  value: _alimentoSelecionado,
                  items: widget.alimentos.map((Alimentos alimentos) {
                    return DropdownMenuItem<String>(
                      value: alimentos.nome,
                      child: Text(alimentos.nome),
                    );
                  }).toList(),
                  onChanged: (String? novoAlimento) {
                    setState(() {
                      _alimentoSelecionado = novoAlimento;
                    });
                  },
                ),
              ),
              const SizedBox(height: 20),
              _alimentoSelecionado != null
                  ? Column(
                      children: [
                        Text(
                          "Defina a quantidade ingerida (gramas):",
                          style: TextStyle(color: Colors.pink),
                        ),
                        SizedBox(
                          width: 150,
                          child: TextField(
                            controller: _ingeridoController,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              setState(() {
                                _gramosing = double.tryParse(value) ?? 100;
                              });
                            },
                            decoration: const InputDecoration(
                              hintText: "Gramas",
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.pink),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
          const SizedBox(height: 20),
          _alimentoSelecionado != null
              ? Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      "Valores Nutricionais Totais:",
                      style: TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Calorias: ",
                            style: TextStyle(color: Colors.grey)),
                        Text(
                          "${_caltotal.toStringAsFixed(2)} kcal",
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    // Repetir para outros valores nutricionais...
                  ],
                )
              : Container(),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 60),
              backgroundColor: Colors.pinkAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              calcularCusto();
            },
            child: const Text(
              "Calcular",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
