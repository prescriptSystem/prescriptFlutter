import 'package:day_picker/day_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:prescript/common/mySnackBar.dart';
import 'package:prescript/controller/alarmService.dart';
import 'package:prescript/controller/notification_logic.dart';
import 'package:prescript/models/alarmModel.dart';
import 'package:prescript/models/medicineModel.dart';
import 'dart:ui' as ui;

class AlarmMedicineScreen extends StatefulWidget {
  final MedicineModel medicine;
  final AlarmModel? alarm;
  const AlarmMedicineScreen({super.key, required this.medicine, this.alarm});

  @override
  State<AlarmMedicineScreen> createState() => _AlarmMedicineState();
}

class _AlarmMedicineState extends State<AlarmMedicineScreen> {
  //late FixedExtentScrollController _hourController;
  //late FixedExtentScrollController _minuteController;

  final List<DayInWeek> _days = [
    DayInWeek("S", dayKey: "segunda"),
    DayInWeek("T", dayKey: "terca"),
    DayInWeek("Q", dayKey: "quarta"),
    DayInWeek("Q", dayKey: "quinta"),
    DayInWeek("S", dayKey: "sexta"),
    DayInWeek("S", dayKey: "sabado"),
    DayInWeek("D", dayKey: "domingo"),
  ];

  bool _segundaController = false;
  bool _tercaController = false;
  bool _quartaController = false;
  bool _quintaController = false;
  bool _sextaController = false;
  bool _sabadoController = false;
  bool _domingoController = false;

  TimeOfDay? time;

  bool alarmEnable = true;

  bool isLoading = false;

  AlarmService _alarmService = AlarmService();

  User? user;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    if (widget.alarm != null) {
      if (widget.alarm!.segunda) {
        _days[0] = DayInWeek("S", dayKey: "segunda", isSelected: true);
      }

      if (widget.alarm!.terca) {
        _days[1] = DayInWeek("T", dayKey: "terca", isSelected: true);
      }

      if (widget.alarm!.quarta) {
        _days[2] = DayInWeek("Q", dayKey: "quarta", isSelected: true);
      }

      if (widget.alarm!.quinta) {
        _days[3] = DayInWeek("Q", dayKey: "quinta", isSelected: true);
      }

      if (widget.alarm!.sexta) {
        _days[4] = DayInWeek("S", dayKey: "sexta", isSelected: true);
      }

      if (widget.alarm!.sabado) {
        _days[5] = DayInWeek("S", dayKey: "sabado", isSelected: true);
      }

      if (widget.alarm!.domingo) {
        _days[6] = DayInWeek("d", dayKey: "domingo", isSelected: true);
      }

      alarmEnable = true;

      time = TimeOfDay(
        hour: widget.alarm!.hourOfDay,
        minute: widget.alarm!.minuteOfDay,
      );
    } else {
      alarmEnable = false;
      time = TimeOfDay(hour: 0, minute: 0);
    }
    super.initState();

    user = FirebaseAuth.instance.currentUser;
    NotificationLogic.init(context, user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    //final customWidgetKey = new GlobalKey<SelectWeekDaysState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Alarme de Medicamento",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.medicine.medicineName,
              style: TextStyle(
                color: Colors.pink,
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectWeekDays(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              days: _days,
              boxDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  // 10% of the width, so there are ten blinds.
                  colors: [
                    const Color.fromARGB(255, 233, 30, 99),
                    const Color.fromARGB(255, 251, 117, 157),
                  ], // whitish to gray
                  tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
              onSelect: (values) {
                if (values.contains("segunda")) {
                  _segundaController = true;
                } else {
                  _segundaController = false;
                }

                if (values.contains("terca")) {
                  _tercaController = true;
                } else {
                  _tercaController = false;
                }

                if (values.contains("quarta")) {
                  _quartaController = true;
                } else {
                  _quartaController = false;
                }

                if (values.contains("quinta")) {
                  _quintaController = true;
                } else {
                  _quintaController = false;
                }

                if (values.contains("sexta")) {
                  _sextaController = true;
                } else {
                  _sextaController = false;
                }

                if (values.contains("sabado")) {
                  _sabadoController = true;
                } else {
                  _sabadoController = false;
                }

                if (values.contains("domingo")) {
                  _domingoController = true;
                } else {
                  _domingoController = false;
                }

                print(values);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Colors.pink,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text(
                      "Hora selecionada",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      time == null
                          ? "${widget.alarm!.hourOfDay} : ${widget.alarm!.minuteOfDay}"
                          : "${time!.hour} : ${time!.minute}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              child: const Text(
                'Selecione a hora',
                style: TextStyle(color: Colors.pink),
              ),
              onPressed: () async {
                time = await showTimePicker(
                  context: context,
                  initialTime: widget.alarm == null
                      ? TimeOfDay.now()
                      : TimeOfDay(
                          hour: widget.alarm!.hourOfDay,
                          minute: widget.alarm!.minuteOfDay,
                        ),
                  initialEntryMode: TimePickerEntryMode.dialOnly,
                  orientation: Orientation.portrait,
                  cancelText: "Cancelar",
                  helpText: "Seleciona a hora",
                  builder: (BuildContext context, Widget? child) {
                    // We just wrap these environmental changes around the
                    // child in this builder so that we can apply the
                    // options selected above. In regular usage, this is
                    // rarely necessary, because the default values are
                    // usually used as-is.
                    return Theme(
                      data: Theme.of(context).copyWith(
                        //materialTapTargetSize: ,
                      ),
                      child: Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: MediaQuery(
                          data: MediaQuery.of(
                            context,
                          ).copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        ),
                      ),
                    );
                  },
                );
                print(time.toString());
                setState(() {
                  time = time;
                });
              },
            ),
          ),
          Switch(
            // This bool value toggles the switch.
            value: alarmEnable,
            //hoverColor: Colors.pink,
            //focusColor: Colors.pink,
            //colo
            thumbColor: WidgetStatePropertyAll<Color>(Colors.pink),
            activeColor: const Color.fromARGB(255, 228, 125, 159),
            onChanged: (bool value) {
              // This is called when the user toggles the switch.
              setState(() {
                alarmEnable = value;
              });
            },
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Aqui você pode adicionar a lógica de login
                clickBtnAddAlarm();
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: Colors.pink,

                //primary: Colors.blue,
              ),
              child: (isLoading)
                  ? SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  : Text(
                      widget.alarm == null ? 'Salvar Alarme' : "Editar Alarme",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  clickBtnAddAlarm() {
    setState(() {
      isLoading = true;
    });

    //String segunda = _days.indexOf(element);
    /*String laboratory = _laboratoryController.text;
    String quantity = _quantityController.text;*/

    AlarmModel alrmModel = AlarmModel(
      id: widget.medicine.id,
      segunda: _segundaController,
      terca: _tercaController,
      quarta: _quartaController,
      quinta: _quintaController,
      sexta: _sextaController,
      sabado: _sabadoController,
      domingo: _domingoController,
      enableAlarm: alarmEnable,
      hourOfDay: time == null ? 0 : time!.hour,
      minuteOfDay: time == null ? 0 : time!.minute,
    );

    /*if (widget.medicineModel != null) {
      medicineModel.id = widget.medicine!.id;
    }*/

    _alarmService.addAlarm(widget.medicine.id, alrmModel).then((
      String? message,
    ) {
      if (message != null) {
        showSnackBar(context: context, text: message);
      } else {
        showSnackBar(
          context: context,
          text: widget.alarm != null
              ? "Alarme editado com sucesso!"
              : "Alarme salvo com sucesso!",
          isErro: false,
        );
        /*_medicineNameController.clear();
        _activeIngredientController.clear();
        _laboratoryController.clear();
        _quantityController.clear();*/

        if (alarmEnable) {
          //Timestamp t = time as Timestamp;
          //DateTime date =
          //DateTime.fromMicrosecondsSinceEpoch(t.microsecondsSinceEpoch);
          //String formatTime = DateFormat.jm().format(date);

          DateTime date = DateTime(2025, 1, 27, time!.hour, time!.minute);

          NotificationLogic.showNotifications(
            datetime: date,
            id: 0,
            title: "Prescript - Lembrete para tomar remédio",
            body: "Está na hora de tomar o ${widget.medicine.medicineName}",
          );
        }

        Navigator.of(context).pop();
        setState(() {
          isLoading = false;
        });
      }
    });
    //if (_formKey.currentState!.validate()) {
    /*_medicineService
        .addMedicine(medicineModel)
        .loginUser(
            email: _emailController.text, password: _passwordController.text)
        .then((String? message) {
      if (message != null) {
        showSnackBar(context: context, text: message);
      } else {
        _emailController.clear();
        _passwordController.clear();*/

    /*Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileScreen()),
          );*/
  }
}
