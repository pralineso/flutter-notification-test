
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_notification_test/plugin/notification_plugin.dart';
import 'package:flutter_notification_test/pages/create_notification_page.dart';
import 'package:flutter_notification_test/data/notification_data.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  final _notificationPlugin =  new NotificationPlugin();
  Future<List<PendingNotificationRequest>> notificationFuture;
  int id = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationFuture = _notificationPlugin.getScheduledNotifications();
    id = id++;
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
            FutureBuilder<List<PendingNotificationRequest>>(
                future:  notificationFuture,
                initialData: [],
                builder: (context, snapshot){
                  final notifications = snapshot.data;
                  return Expanded(
                      child: ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index){
                            final notification = notifications[index];
                            return NotificationTile(
                                notification: notification,
                                deleteNotification: dismissNotification,
                            );
                          }
                      )
                  );
                }
            ),
            FlatButton(
                padding: EdgeInsets.all(1),
                onPressed: navigateToNotificationCreation,
                shape: RoundedRectangleBorder(
                    borderRadius:  BorderRadius.only(
                      bottomLeft:  Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    )
                ),
                color: Colors.blue,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: double.infinity,
                  child: Text('Create',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),),
                )
            )
          ],
        ),
      ),
    );
  }


  Future<void> dismissNotification(int id) async{
    await _notificationPlugin.cancelNotification(id);
    refreshNotification();
  }

  void refreshNotification(){
    setState(() {
      notificationFuture = _notificationPlugin.getScheduledNotifications();
    });
  }

  Future<void> navigateToNotificationCreation() async{
    NotificationData notificationData = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CreateNotificationPage(),
        )
    );
    if (notificationData != null){
      print("dentro do if notificationdata != null");
//      final notificationList = await _notificationPlugin.getScheduledNotifications();

//      for (var i = 0; i < 100; i++){
//        _notificationPlugin.showDailyAtTime(time, id, title, description)
//        bool exists = _notificationPlugin.checkIfIdExists(notificationList, i);
//        if(!exists){
//          id = i;
//        }
//      }
    }

    print("notificationData.time: "+ notificationData.time.toString());
    print("notificationData.title: "+ notificationData.title);
    print("notificationData.descricao: "+ notificationData.description);

    await _notificationPlugin.showDailyAtTime(
        notificationData.time,
        id,
        notificationData.title,
        notificationData.description
    );

    print("antes do refreshnotification");
     refreshNotification();
  }

}


class NotificationTile extends StatelessWidget {
  const NotificationTile({
    Key key,
    @required this.notification,
    @required this.deleteNotification,
}): super(key: key);

  final PendingNotificationRequest notification;
  final Function(int id) deleteNotification;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(notification.title),
        subtitle: Text(notification.body),
        trailing: IconButton(
          onPressed: () => deleteNotification(notification.id),
          icon: Icon(Icons.delete),
        ),
      ),
    );
  }
}


