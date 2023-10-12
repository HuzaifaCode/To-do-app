import 'dart:convert';

import 'package:http/http.dart' as http;

class FirebaseAPIServices {
  sendPushNotifications({required String title,
    required String body,
    required List<String> token,}) async {
    final String apiUrl = 'https://fcm.googleapis.com/fcm/send';

    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'key=AAAA_wcUUuk:APA91bGtjYoLQmACQ3mYzl5l5PWquFVuoFw-Wj4kkq5x_zEmi9LnBgnWYZCw4eX4UKC2E8rxzYB17o5N9UDwamyt-O8LFgHv8HeebToGDaGwj8wcYkGpqnunYNbcAFv5vvDahKDRC_jm',
    };

    final Map<String, dynamic> data = {
      'priority': 'high',
      'data': <String, dynamic>{
        'click_action': 'FLUTTER_NOTIFICATION_CLICK',
        'status': 'done',
        'title': title,
        'body': body
      },
      'notification': <String, dynamic>{
        'title': title,
        'body': body,
        'android_channel_id': 'huzaifa'
      },
      'registration_ids': token
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // The request was successful, and you can parse the response data.
        print('Response data: ${response.body}');
      }
    } catch (e) {
      // Handle network and other errors here.
      print('Error: $e');
    }
  }
}
