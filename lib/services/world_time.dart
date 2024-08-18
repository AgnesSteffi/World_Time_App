import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  late String location; //location name for the UI
  late String time; //time in that location
git  late String flag; //url to an asset flag icon
  late String url; //location url for api endpoint
  bool? isDaytime; //true or false if day time or not

  WorldTime({ required this.location,required this.flag,required this.url });

  Future<void> getTime() async {

    try {
      //make the request
      Response response = await get(Uri.parse('https://www.timeapi.io/api/Time/current/zone?timeZone=$url'));
      Map data = jsonDecode(response.body);
      print(data);

      //get properties from data
      String datetime = data['dateTime'] ?? 'Unknown Time';

      //create a datetime object
      DateTime now = DateTime.parse(datetime);

      //set the time property
      isDaytime = now.hour >= 6 && now.hour < 18;
      time = DateFormat.jm().format(now);
    }
    catch (e) {
      print('caught error: $e');
      time = 'could not get the time';
    }
  }
}

