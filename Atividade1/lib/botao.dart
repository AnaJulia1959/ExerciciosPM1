import 'package:flutter/material.dart';

class Botao extends StatelessWidget {
  final String texto;
  final Function() acao;
  const Botao(this.texto, this.acao, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(
                    const Color.fromARGB(255, 255, 182, 193)),
                foregroundColor:
                    MaterialStatePropertyAll(const Color.fromARGB(255, 0, 0, 0))),
            onPressed: () {
              acao();
            },
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "$texto",
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
