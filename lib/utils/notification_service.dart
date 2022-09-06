import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static showNotification({
    String? title,
    String? body,
  }) {
    return AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 10,
        channelKey: 'battery_alert',
        title: title ?? '[No Title]',
        body: title ?? '[No Desc]',
        locked: true,
        wakeUpScreen: true,
      ),
    );
  }
}
