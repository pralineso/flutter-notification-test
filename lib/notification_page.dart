import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notification_test/plugin/notification_plugin.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  final _notificationPlugin =  new NotificationPlugin();
  Future<List<PendingNotificationRequest>> notificationFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationFuture = _notificationPlugin.getScheduledNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          FutureBuilder<List<PendingNotificationRequest>>(
              future:  notificationFuture,
              initialData: [],
              builder: (context, snapshot){
                final notifications = snapshot.data;
                return Expanded(
                    child: ListView.builder(
                        itemCount:  notifications.length,
                        itemBuilder: (context, index){
                          final notificaion = notifications[index];
                          return Text(notificaion.title);
                        }
                    )
                );
              }
          ),
          FlatButton(
              padding: EdgeInsets.all(1),
              onPressed: () async {
                await _notificationPlugin.showWeeKlyAtDayAndTime(
                    Time(12, 0, 0),
                    Day.Friday,
                    0, 'Primeira notificacao',
                    'Descrição da primeira notificação'
                );
                setState(() {
                  notificationFuture = _notificationPlugin.getScheduledNotifications();
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius:  BorderRadius.only(
                  bottomLeft:  Radius.circular(5),
                  bottomRight: Radius.circular(5),
                )
              ),
              color: Colors.blue.shade300,
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                child: Text('Create',
                style: TextStyle(
                  color: Colors.blue.shade900,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
              )
          )
        ],
      ),
    );
  }
}
