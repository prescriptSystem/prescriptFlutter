import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prescript/models/medicineModel.dart';

class MedicineService {
  String userId;

  MedicineService() : userId = FirebaseAuth.instance.currentUser!.uid;

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> addMedicine(MedicineModel medicineModel) async {
    try {
      await _firebaseFirestore
          .collection(userId)
          .doc(medicineModel.id)
          .set(medicineModel.toMap());
      return null;
    } on FirebaseException catch (e) {
      /*if (e.code == "email-already-in-use") {
        return "O usuário já está cadastrado!";
      } else {*/
      print(e);
      return "Erro ao salvar o medicamento!";
      //}
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> selectMedicine(bool isDesc) {
    return _firebaseFirestore
        .collection(userId)
        .orderBy("medicineName", descending: isDesc)
        .snapshots();
  }

  Future<String?> removeMedicine({required String idMedicine}) async {
    try {
      await _firebaseFirestore.collection(userId).doc(idMedicine).delete();
      return null;
    } on FirebaseException catch (e) {
      /*if (e.code == "email-already-in-use") {
        return "O usuário já está cadastrado!";
      } else {*/
      print(e);
      return "Erro ao remover o medicamento!";
      //}
    }
  }
}
