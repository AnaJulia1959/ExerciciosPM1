import 'package:flutter/material.dart';
import 'package:login/logado.dart';
import 'package:login/botao.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  bool _mostrarSenha = false;
  final String usuarioPadrao = "UsuarioTeste";
  final String senhaPadrao = "Flutter";

  final controladorUsuario = TextEditingController();
  final controladorSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text("Bem-vindo!"),
        backgroundColor: const Color.fromARGB(255, 255, 105, 180),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink, Colors.pinkAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      "https://cdn-icons-png.flaticon.com/512/5550/5550463.png"),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Faça Login",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: controladorUsuario,
                        decoration: const InputDecoration(
                          labelText: "Usuário",
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: controladorSenha,
                        decoration: InputDecoration(
                          labelText: "Senha",
                          prefixIcon: const Icon(Icons.lock),
                          border: const OutlineInputBorder(),
                          suffixIcon: GestureDetector(
                            child: Icon(
                              _mostrarSenha
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.pinkAccent,
                            ),
                            onTap: () {
                              setState(() {
                                _mostrarSenha = !_mostrarSenha;
                              });
                            },
                          ),
                        ),
                        obscureText: !_mostrarSenha,
                      ),
                      const SizedBox(height: 20),
                      Botao("Entrar", () {
                        String usuarioInformado = controladorUsuario.text;
                        String senhaInformada = controladorSenha.text;

                        if (usuarioInformado == usuarioPadrao &&
                            senhaInformada == senhaPadrao) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Sucesso(nomeUsuario: usuarioInformado);
                          }));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Usuário ou senha incorretos!"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
