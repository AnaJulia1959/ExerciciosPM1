import 'package:flutter/material.dart';
import 'package:login/botao.dart';

class Sucesso extends StatelessWidget {
  final String nomeUsuario;

  const Sucesso({super.key, required this.nomeUsuario});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sucesso",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Logado com sucesso!"),
          backgroundColor: const Color.fromARGB(255, 255, 182, 193),
        ),
        body: Column(
          children: [
            Text("Bem-vindo, $nomeUsuario!"),
          ],
        ),
      ),
    );
  }
}
