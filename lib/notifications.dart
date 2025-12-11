import 'package:flutter/material.dart';
import 'package:newprojectfirebase/main.dart';

class Notifications extends StatelessWidget {
  NotificationsPayload ? notificationsPayload;
  Notifications({super.key, this.notificationsPayload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Column(
        
        children: [
          Card(

            child: Column(
            children: [
              Text("${notificationsPayload?.title}"),
              Text("${notificationsPayload?.body}")
            ],
                      )),
        ],
      ),
    );
  }
}