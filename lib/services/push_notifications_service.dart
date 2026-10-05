import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static String? token;
  static StreamController<String> _messageStreamController =
      new StreamController.broadcast();

  static Stream<String> get messagesStream => _messageStreamController.stream;

  static Future _onBackgroundHandler(RemoteMessage message) async {
    // print('onBackground handler ${message.messageId} ');
    _messageStreamController.add(message.data['idUser']?? 'No User');
    print(message.data);
  }

  static Future _onMessageHandler(RemoteMessage message) async {
    //print('onMessageHandler handler ${message.messageId} ');
    _messageStreamController.add(message.data['idUser']?? 'No User');
        print(message.data);

  }

  static Future _onMessageOpenApp(RemoteMessage message) async {
    // print('onMessageOpenApp handler ${message.messageId} ');
    _messageStreamController.add(message.data['idUser']?? 'No User');
        //print(message.data);

  }

  static Future initializeApp() async {
    //push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();

    FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    //local notifications
    print(token);
  }

  static closeStreamController() {
    _messageStreamController.close();
  }
}
