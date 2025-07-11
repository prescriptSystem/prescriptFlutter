import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prescript/common/mySnackBar.dart';
import 'package:prescript/controller/autenthicationService.dart';
import 'package:prescript/screen/login.dart';
import 'package:prescript/validators/email_validator.dart';
import 'package:prescript/validators/password_validator.dart';

void main() {
  runApp(AddUser());
}

class AddUser extends StatelessWidget {
  const AddUser({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddUserScreen(),
    );
  }
}

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameUserController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailValidate = EmailValidator();
  final _passwordValidate = PasswordValidator();

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
                        'Cadastrar',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Campo de Nome
                      TextFormField(
                        controller: _nameUserController,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        //validator: validateEmail,
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
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        validator: _passwordValidate.validate,
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
                      // Campo de Confirmação de Senha
                      TextField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          labelText: 'Confirma Senha',
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.lock),
                          /*suffixIcon: IconButton(
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
                          ),*/
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Botão de Login
                      Container(
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Aqui você pode adicionar a lógica de login
                                clickBtnEnter();
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 50),
                                backgroundColor: Colors.pink,

                                //primary: Colors.blue,
                              ),
                              child: Text(
                                'Cadastrar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            Spacer(flex: 5),
                            ElevatedButton(
                              onPressed: () {
                                // Aqui você pode adicionar a lógica de login
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size(150, 50),
                                backgroundColor: Colors.pink,

                                //primary: Colors.blue,
                              ),
                              child: Text(
                                'Voltar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
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
          .addUser(
            name: _nameUserController.text,
            email: _emailController.text,
            password: _passwordController.text,
          )
          .then((String? message) {
            if (message != null) {
              showSnackBar(context: context, text: message);
            } else {
              _nameUserController.clear();
              _emailController.clear();
              _passwordController.clear();
              _confirmPasswordController.clear();
              /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );*/

              showSnackBar(
                context: context,
                text: "Cadastro efetuado com sucesso",
                isErro: false,
              );
            }
          });
    } else {
      print("Form inválido");
    }
  }
}
