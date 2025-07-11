import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prescript/screen/profile.dart';

import '../controller/autenthicationService.dart';
import '../screen/medicines.dart';

class Menu extends StatefulWidget {
  final User user;
  Menu({super.key, required this.user});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Cabeçalho do Menu (usuário)
          UserAccountsDrawerHeader(
            accountName: Text(
              (widget.user.displayName != null) ? widget.user.displayName! : "",
            ),
            accountEmail: Text(widget.user.email!),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/avata.png"),
            ),
            decoration: BoxDecoration(color: Colors.pink),
          ),
          // Itens do Menu
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Início'),
            onTap: () {
              // Navegação para a tela de início
              print('Navegar para Início');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(user: widget.user),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              // Navegação para as configurações
              print('Navegar para Configurações');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.medication),
            title: const Text('Medicamentos'),
            onTap: () {
              // Navegação para as configurações
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MedicinesScreen(user: widget.user),
                ),
              );
              //Navigator.pop(context);
            },
          ),

          /* ListTile(
              leading: const Icon(Icons.medication),
              title: const Text('Alarme'),
              onTap: () {
                // Navegação para as configurações
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
                //Navigator.pop(context);
              },
            ),*/
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              AuthenticationService _authenticationService =
                  AuthenticationService();
              // Lógica para sair logout
              _authenticationService.logout();

              /*Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));*/
            },
          ),
        ],
      ),
    );
  }
}
