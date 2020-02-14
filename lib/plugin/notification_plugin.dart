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

  Future<List<PendingNotificationRequest>> getScheduledNotifications() async{
    final pendingNotifications = await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotifications;
  }

  Future canceNotification(int id) async{
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}