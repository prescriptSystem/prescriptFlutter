import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> addUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      await userCredential.user!.updateDisplayName(name);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "O usuário já está cadastrado!";
      } else {
        return "Erro desconhecido!";
      }
    }
  }

  Future<String?> loginUser(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return null;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      if (e.code == "email-already-in-use") {
        return "O usuário já está cadastrado!";
      } else if (e.message ==
          "The supplied auth credential is incorrect, malformed or has expired.") {
        return "Usuário não encontrado!";
      } else {
        return "Erro desconhecido!";
      }
    }
  }

  Future<void> logout() async {
    return _firebaseAuth.signOut();
  }
}
