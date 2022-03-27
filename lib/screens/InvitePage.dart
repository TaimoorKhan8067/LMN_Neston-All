import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lmn_neston/configs/constant.dart';
import 'package:http/http.dart' as http;
import 'package:lmn_neston/database/user_local_data.dart';
import 'package:lmn_neston/models/users.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lmn_neston/widgets/custom_toast.dart';
import '../database/user_api.dart';

class InvitePage extends StatefulWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  State<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends State<InvitePage> {
  final TextEditingController _email = TextEditingController();
  int points = 1345;
  void initState() {
    super.initState();

    requestPermission();

    loadFCM();

    listenFCM();

    FirebaseMessaging.instance.subscribeToTopic("Animal");
  }

  String constructFCMPayload(String? token) {
    return jsonEncode({
      'token': token,
      'data': {
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'id': '1',
        'status': 'done'
      },
      'notification': {
        'title': 'Hello User!',
        'body': '${UserLocalData.getUserEmail} send you invite',
      },
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
      CustomToast.errorToast(
        message: 'Permission Isuue',
      );
    } else {
      CustomToast.errorToast(
        message: 'Permission Isuue',
      );
      print('User declined or has not accepted permission');
    }
  }

  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  void listenFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );
      }
    });
  }

  Future<void> sendPushMessage(String _token) async {
    if (_token == null) {
      CustomToast.errorToast(
        message: 'Unable to send FCM message, no token exists.',
      );
      // print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(_token),
      );
      // print('FCM request for device sent!');
      CustomToast.successToast(
        message: 'FCM request for device sent!',
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            const Text(
              "Invite",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 50,
              ),
            ),
            const Text(
              "Enter the email address below: ",
              style: TextStyle(
                // fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            makeInput(label: "", all_controller: _email),
            //
            MaterialButton(
              minWidth: double.infinity,
              height: 60,
              onPressed: () async {
                final QuerySnapshot<Map<String, dynamic>> query =
                    await UserAPI().getUidFromEmail(email: _email.text);
                final AppUserModel appUser =
                    AppUserModel.fromDocument(query.docs[0]);

                sendPushMessage(appUser.NotificationToken!);
              },
              color: appPrimaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60)),
              child: const Text(
                "Invite/Submit",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
              ),
            ),

            ///
            ///
            const Divider(color: Colors.black, indent: 20, endIndent: 20),
            // const Spacer(),
            const Center(
              child: Text(
                "Your Points ",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
            Center(
              child: Text(
                '$points',
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 80,
                  color: appPrimaryColor,
                ),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

Widget makeInput({label, obsureText = false, required all_controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
      ),
      const SizedBox(
        height: 5,
      ),
      TextField(
        obscureText: obsureText,
        controller: all_controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          border:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
      const SizedBox(
        height: 30,
      )
    ],
  );
}
