import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_notification_test/data/notification_data.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class CreateNotificationPage extends StatefulWidget {
  @override
  _CreateNotificationPageState createState() => _CreateNotificationPageState();
}

class _CreateNotificationPageState extends State<CreateNotificationPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //iconTheme:  IconThemeData(color:  Colors.black),
        title: Text("Create Notification"),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: _titleController,
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: "Title"
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _descriptionController,
                      autofocus: true,decoration: InputDecoration(
                        labelText: "Description"
                    ),
                    ),
                    SizedBox(height: 12),
                    FlatButton(
                      color: Colors.blue,
                      onPressed: selectTime,
                      child: Text(selectedTime.format(context),
                        style: TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ),
                  ],
                ),
              )
          ),
          FlatButton(
              padding: EdgeInsets.all(1),
              onPressed: createNotification,
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
          ),
        ],
      ),
    );
  }

  Future<void> selectTime() async{
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    setState(() {
      selectedTime = time;
    });
  }

  void createNotification(){
    final title = _titleController.text;
    final description = _descriptionController.text;
    final time = Time(selectedTime.hour, selectedTime.minute, 0);

    print("dentro do create_notificatio_page time= "+ time.hour.toString());

    final notificationData = NotificationData(title, description, time);

    print("dentro do create notification");
    Navigator.of(context).pop(notificationData);
  }

}
