import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prescript/components/menu.dart';

class ProfileScreen extends StatefulWidget {
  final User user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil'), backgroundColor: Colors.pink),
      drawer: Menu(user: widget.user),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Foto do Perfil
              const Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("assets/images/avata.png"),
                ),
              ),
              const SizedBox(height: 20),
              // Nome do Usuário
              Center(
                child: Text(
                  widget.user.displayName != null
                      ? widget.user.displayName!
                      : "usuario",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // Detalhes do Perfil
              ProfileDetail(label: 'E-mail:', value: widget.user.email!),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget de Detalhe de Perfil
class ProfileDetail extends StatelessWidget {
  final String label;
  final String value;

  const ProfileDetail({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
