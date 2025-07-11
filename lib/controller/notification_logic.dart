import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationLogic {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationsDatails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        "Lembrete Prescript",
        "Não esqueça",
        importance: Importance.max,
        priority: Priority.max,
      ),
    );
  }

  static Future init(BuildContext context, String uid) async {
    tz.initializeTimeZones();
    final android = AndroidInitializationSettings("time_work");

    var initializationSettings = InitializationSettings(android: android);
    _notifications.initialize(initializationSettings);
  }

  static Future showNotifications({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime datetime,
  }) async {
    if (datetime.isBefore(DateTime.now())) {
      datetime = datetime.add(Duration(days: 1));
    }

    _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(datetime, tz.local),
      await _notificationsDatails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidScheduleMode: AndroidScheduleMode.alarmClock,
    );
  }
}
