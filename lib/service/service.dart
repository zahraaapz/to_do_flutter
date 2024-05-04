import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotifHelper {
  final flutterLocalNotifPlugin = FlutterLocalNotificationsPlugin();

  final _initializationSetting = const InitializationSettings(
      android: AndroidInitializationSettings('app_icon'));

  init() async {
    await flutterLocalNotifPlugin.initialize(_initializationSetting);
    tz.initializeTimeZones();
  }

  static final _androidNotificationDetails = const AndroidNotificationDetails(
      'channelId', 'channelName',
      importance: Importance.max, priority: Priority.high);

  static final NotificationDetails _notificationDetails =
      NotificationDetails(android: _androidNotificationDetails);

  setNotification(DateTime dateTime, int id ,title,body) async {
    await flutterLocalNotifPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          dateTime,
          tz.local),
        _notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  cancelNotif(int id) async {
    await flutterLocalNotifPlugin.cancel(id);
  }
}








