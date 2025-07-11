import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prescript/components/menu.dart';
import 'package:prescript/controller/alarmService.dart';
import 'package:prescript/controller/medicineService.dart';
import 'package:prescript/models/alarmModel.dart';
import 'package:prescript/models/medicineModel.dart';
import 'package:prescript/screen/addMedicine.dart';
import 'package:prescript/screen/medicineAlarm.dart';

class MedicinesScreen extends StatefulWidget {
  final User user;
  const MedicinesScreen({super.key, required this.user});

  @override
  State<MedicinesScreen> createState() => _MedicinesScreenState();
}

class _MedicinesScreenState extends State<MedicinesScreen> {
  final MedicineService medicineService = MedicineService();
  final AlarmService alarmService = AlarmService();
  bool isDesc = false;
  /* final MedicineModel _medicineModel = MedicineModel(
      id: "",
      medicineName: "",
      activeIngredient: "",
      laboratory: "",
      quantity: "");*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicamentos'),
        backgroundColor: Colors.pink,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isDesc = !isDesc;
              });
            },
            icon: Icon(Icons.sort_by_alpha_rounded),
          ),
        ],
      ),
      drawer: Menu(user: widget.user),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMedicine()),
          );
        },
      ),
      body: StreamBuilder(
        stream: medicineService.selectMedicine(isDesc),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData &&
                snapshot.data != null &&
                snapshot.data!.docs.isNotEmpty) {
              List<MedicineModel> medicineList = [];

              for (var doc in snapshot.data!.docs) {
                medicineList.add(MedicineModel.fromMap(doc.data()));
              }

              return ListView(
                children: List.generate(medicineList.length, (index) {
                  MedicineModel medicineModel = medicineList[index];
                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      //borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(medicineModel.medicineName),
                      subtitle: Text(medicineModel.laboratory),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddMedicine(medicine: medicineModel),
                          ),
                        );
                      },
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StreamBuilder(
                                    stream: alarmService.selectAlarm(
                                      medicineModel.id,
                                    ),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        AlarmModel alarmModel;
                                        if (snapshot.hasData &&
                                            snapshot.data != null &&
                                            snapshot.data!.docs.isNotEmpty) {
                                          alarmModel = AlarmModel.fromMap(
                                            snapshot.data!.docs[0].data(),
                                          );
                                          print(alarmModel);
                                          return AlarmMedicineScreen(
                                            medicine: medicineModel,
                                            alarm: alarmModel,
                                          );
                                        } else {
                                          print("Não tem alarme");
                                          return AlarmMedicineScreen(
                                            medicine: medicineModel,
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.alarm),
                          ),
                          IconButton(
                            onPressed: () {
                              SnackBar snackBar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "Deseja realmente remover o medicamento ${medicineModel.medicineName}?",
                                  style: TextStyle(color: Colors.white),
                                ),
                                action: SnackBarAction(
                                  label: "REMOVER",
                                  textColor: Colors.white,
                                  onPressed: () {
                                    medicineService.removeMedicine(
                                      idMedicine: medicineModel.id,
                                    );
                                  },
                                ),
                              );

                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(snackBar);
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              );
            } else {
              return Center(child: Text("Nenhum medicamento foi adicionado!"));
            }
          }
        },
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
