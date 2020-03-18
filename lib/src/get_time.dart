import 'dart:convert';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class GetTime{
  String location;
  String time;
  String zone;

  GetTime({this.location, this.zone});

  Future<void> getTime() async {
    try{

      Response response = await get('http://worldtimeapi.org/api/timezone/$zone');
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      int hoffset = int.parse(data['utc_offset'].substring(1,3));
      int moffset = int.parse(data['utc_offset'].substring(4,6));

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: hoffset, minutes: moffset));

      time = DateFormat.jm().format(now);
    }
    catch(e){
      time = "Can't Load Time";
      location = 'Try Again';
    }
  }
}