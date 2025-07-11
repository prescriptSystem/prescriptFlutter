import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prescript/common/mySnackBar.dart';
import 'package:prescript/controller/autenthicationService.dart';
import 'package:prescript/screen/addUser.dart';
import 'package:prescript/validators/email_validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailValidate = EmailValidator();
  bool _obscureText = true;

  final AuthenticationService _authenticationService = GetIt.instance();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Imagem no topo
          Container(
            height: 250,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/doctor1.png',
                ), // Coloque sua imagem aqui
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Caixa de Login
          Form(
            key: _formKey,
            child: Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Text(
                        'Entrar',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Campo de E-mail
                      TextFormField(
                        key: Key('email_key'),
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: _emailValidate.validate,
                      ),
                      const SizedBox(height: 20),
                      // Campo de Senha
                      TextField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Botão de Login
                      ElevatedButton(
                        onPressed: () {
                          // Aqui você pode adicionar a lógica de login
                          clickBtnEnter();
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.pink,

                          //primary: Colors.blue,
                        ),
                        child: Text(
                          'Entrar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Links de Esqueci a Senha e Cadastro
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              // Redireciona para a tela de redefinir senha
                              print('Esqueci a senha');
                            },
                            child: const Text(
                              'Esqueceu a senha?',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          const SizedBox(width: 10),
                          TextButton(
                            onPressed: () {
                              // Redireciona para a tela de cadastro
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddUser(),
                                ),
                              );
                            },
                            child: const Text(
                              'Cadastre-se',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  clickBtnEnter() {
    if (_formKey.currentState!.validate()) {
      _authenticationService
          .loginUser(
            email: _emailController.text,
            password: _passwordController.text,
          )
          .then((String? message) {
            if (message != null) {
              showSnackBar(context: context, text: message);
            } else {
              _emailController.clear();
              _passwordController.clear();

              /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );*/
            }
          });
    } else {
      print("Form inválido");
    }
  }
}
