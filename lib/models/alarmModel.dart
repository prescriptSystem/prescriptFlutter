class AlarmModel {
  String id;
  bool segunda;
  bool terca;
  bool quarta;
  bool quinta;
  bool sexta;
  bool sabado;
  bool domingo;

  bool enableAlarm;

  int hourOfDay;

  int minuteOfDay;

  String? alarmTitle;

  AlarmModel({
    required this.id,
    required this.segunda,
    required this.terca,
    required this.quarta,
    required this.quinta,
    required this.sexta,
    required this.sabado,
    required this.domingo,
    required this.enableAlarm,
    required this.hourOfDay,
    required this.minuteOfDay,
    this.alarmTitle,
  });

  AlarmModel.fromMap(Map<String, dynamic> map)
      : id = map["id"],
        segunda = map["segunda"],
        terca = map["terca"],
        quarta = map["quarta"],
        quinta = map["quinta"],
        sexta = map["sexta"],
        sabado = map["sabado"],
        domingo = map["domingo"],
        enableAlarm = map["enableAlarm"],
        hourOfDay = map["hourOfDay"],
        minuteOfDay = map["minuteOfDay"],
        alarmTitle = map["alarmTitle"];

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "segunda": segunda,
      "terca": terca,
      "quarta": quarta,
      "quinta": quinta,
      "sexta": sexta,
      "sabado": sabado,
      "domingo": domingo,
      "enableAlarm": enableAlarm,
      "hourOfDay": hourOfDay,
      "minuteOfDay": minuteOfDay,
      "alarmTitle": alarmTitle
    };
  }
}
