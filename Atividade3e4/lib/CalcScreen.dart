import 'package:flutter/material.dart';
import 'Car.dart';
import 'Destiny.dart';

class CalcScreen extends StatefulWidget {
  final List<Car> carros;
  final List<Destiny> destinos;

  const CalcScreen({
    super.key,
    required this.carros,
    required this.destinos,
  });

  @override
  State<CalcScreen> createState() => _CalcScreenState();
}

class _CalcScreenState extends State<CalcScreen> {
  String? _carroSelecionado;
  String? _destinoSelecionado;
  double _custoComum = 0;
  double _custoDiesel = 0;

  double precoGasolinaComum = 5.50;
  double precoDiesel = 6.30;

  final TextEditingController _comumController = TextEditingController();
  final TextEditingController _dieselController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _comumController.text = precoGasolinaComum.toString();
    _dieselController.text = precoDiesel.toString();
  }

  void calcularCusto() {
    if (_carroSelecionado != null && _destinoSelecionado != null) {
      Car carro =
          widget.carros.firstWhere((car) => car.nome == _carroSelecionado);
      Destiny destino =
          widget.destinos.firstWhere((dest) => dest.nomeCidade == _destinoSelecionado);

      double litrosNecessarios = destino.KM / carro.KM_perL;

      setState(() {
        _custoComum = litrosNecessarios * precoGasolinaComum;
        _custoDiesel = litrosNecessarios * precoDiesel;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cálculo de Viagem",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selecione um carro e um destino para calcular os custos:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                isExpanded: true,
                hint: const Text("Selecione um carro"),
                value: _carroSelecionado,
                items: widget.carros.map((Car carro) {
                  return DropdownMenuItem<String>(
                    value: carro.nome,
                    child: Text(carro.nome),
                  );
                }).toList(),
                onChanged: (String? novoCarro) {
                  setState(() {
                    _carroSelecionado = novoCarro;
                  });
                },
              ),
              const SizedBox(height: 10),
              DropdownButton<String>(
                isExpanded: true,
                hint: const Text("Selecione um destino"),
                value: _destinoSelecionado,
                items: widget.destinos.map((Destiny destino) {
                  return DropdownMenuItem<String>(
                    value: destino.nomeCidade,
                    child: Text(destino.nomeCidade),
                  );
                }).toList(),
                onChanged: (String? novoDestino) {
                  setState(() {
                    _destinoSelecionado = novoDestino;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: calcularCusto,
                child: const Text(
                  "Calcular",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              if (_custoComum > 0 || _custoDiesel > 0)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Resultados:",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Custo com gasolina comum: R\$${_custoComum.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    Text(
                      "Custo com diesel: R\$${_custoDiesel.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}