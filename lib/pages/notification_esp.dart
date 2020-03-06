import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationEsp extends StatefulWidget {
  @override
  _NotificationEspState createState() => _NotificationEspState();
}

class _NotificationEspState extends State<NotificationEsp> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setupNotificationPlugin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Test"),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              child: Text('teste'),
            ),
            FlatButton(onPressed:(){
              setupNotificationPlugin();
            }, child: Icon(Icons.access_alarm))
          ],
        ),
      ),
    );
  }

  void setupNotificationPlugin() {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
// initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    var initializationSettingsAndroid = AndroidInitializationSettings(
        '@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
//        onSelectNotification: onSelectNotification
        onSelectNotification: onSelectNotification).then((init) {
          setupNotification();
    }
    );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationEsp()),
    );
//    print('entrou aki no onselect notification');
  }

  void setupNotification() async {
    var time = Time(20, 0, 58);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'daily-notification',
        'Daily Notifications',
        'Daily Notifications');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
        0,
        'show daily title',
        'Daily notification shown at approximately ',
        time,
        platformChannelSpecifics);
  }


  Future onDidReceiveLocalNotification(int id, String title, String body,
      String payload) async {
    showDialog(
        context: context,
      builder: (context) => AlertDialog(
        content:  Text("Notificacao do onDidReceiveLocalNotification"),
        actions: <Widget>[
          FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text('ok'))
        ],
      ),
    );
  }
}

