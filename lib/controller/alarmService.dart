import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prescript/models/alarmModel.dart';

class AlarmService {
  String userId;

  AlarmService() : userId = FirebaseAuth.instance.currentUser!.uid;

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> addAlarm(String idMedicine, AlarmModel alarmModel) async {
    try {
      await _firebaseFirestore
          .collection(userId)
          .doc(idMedicine)
          .collection("alarm")
          .doc(alarmModel.id)
          .set(alarmModel.toMap());

      return null;
    } on FirebaseException catch (e) {
      /*if (e.code == "email-already-in-use") {
        return "O usuário já está cadastrado!";
      } else {*/
      print(e);
      return "Erro ao salvar o alarme!";
      //}
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> selectAlarm(String idMedicine) {
    return _firebaseFirestore
        .collection(userId)
        .doc(idMedicine)
        .collection("alarm")
        .snapshots();
  }
}
