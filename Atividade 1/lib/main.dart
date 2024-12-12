import 'package:flutter/material.dart';
import 'package:login/logado.dart';
import 'package:login/botao.dart';
import 'package:login/telaPrincipal.dart';

void main() {
  runApp(const AplicativoLogin());
}

class AplicativoLogin extends StatelessWidget {
  const AplicativoLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false, title: "Login", home: TelaPrincipal());
  }
}
