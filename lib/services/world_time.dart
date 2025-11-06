import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time = '';
  String flag;
  String url;
  bool isDaytime = true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      final response = await http.get(
        Uri.parse('http://worldtimeapi.org/api/timezone/$url'),
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        time = 'Error ${response.statusCode}';
        return;
      }

      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offset = data['utc_offset'];

      DateTime now = DateTime.parse(datetime);
      int offsetHours = int.parse(offset.substring(1, 3));
      int offsetMinutes = int.parse(offset.substring(4, 6));
      if (offset.startsWith('-')) {
        now = now.subtract(Duration(hours: offsetHours, minutes: offsetMinutes));
      } else {
        now = now.add(Duration(hours: offsetHours, minutes: offsetMinutes));
      }

      isDaytime = now.hour >= 6 && now.hour < 18;
      time = DateFormat.jm().format(now);
    } catch (e) {
      time = 'Error';
      isDaytime = false;
    }
  }
}