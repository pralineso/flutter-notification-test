import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class NotificationPlugin {
  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  NotificationPlugin(){
    _initializeNotifications();
  }

  void _initializeNotifications(){
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    _flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
      onSelectNotification: onSelectNotification

    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null){
      print('notification payload: '+payload);
    }
    print('entrou aki no onselect notification');
  }

  Future<void> showWeeKlyAtDayAndTime(Time time, Day day, int id, String title, String description) async{
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'show weekly channel id',
        'show weekly channel name',
        'show weekly description'
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics,
        iOSPlatformChannelSpecifics
    );
    await _flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        id,
        title,
        description,
        day,
        time,
        platformChannelSpecifics
    );
  }

  Future<void> showDailyAtTime(Time time, int id, String title, String description) async{
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails('repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name', 'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics,
        iOSPlatformChannelSpecifics
    );
    await _flutterLocalNotificationsPlugin.showDailyAtTime(
        id,
        title,
        description,
        time,
        platformChannelSpecifics
    );
  }

  Future<List<PendingNotificationRequest>> getScheduledNotifications() async{
    final pendingNotifications = await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    print("entrou no getSchedule");
    return pendingNotifications;
  }

  Future cancelNotification(int id) async{
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}