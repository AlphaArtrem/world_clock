import 'package:flutter/material.dart';
import 'package:worldclock/src/timezones.dart';
import 'package:worldclock/src/get_time.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {

  TimeZones tz = TimeZones();
  List<String> locations, zones;

  void setup() async{
    tz.getTimeZones();
    locations = tz.locations;
    zones = tz.timezones;
  }

  void newTime(index, context) async {
    GetTime timer = GetTime(location: locations[index], zone: zones[index]);
    await timer.getTime();
    setState(() {
      Navigator.pop(
          context , {'time': timer.time, 'location': timer.location, 'datetime' : timer.now});
    });
  }

  @override
  void initState(){
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change Location'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        margin: EdgeInsets.fromLTRB(2, 5, 2, 2),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
              child: TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 2),),
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple, width: 1),),
                  hintText: "Search By Time Zone",
                ),
                onChanged: (val){
                  setState(() {
                    locations = tz.locations.where((zone){
                      zone = zone.toLowerCase();
                      return zone.contains(val.toLowerCase());
                    }).toList();

                    zones = tz.timezones.where((zone){
                      zone = zone.toLowerCase();
                      return zone.contains(val.toLowerCase());
                    }).toList();
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (context, index){
                  return Card(
                    color: Colors.deepPurpleAccent,
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          newTime(index, context);
                        });
                      },
                      title: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text('${locations[index]}', style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 1.2, fontWeight: FontWeight.w300),),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

