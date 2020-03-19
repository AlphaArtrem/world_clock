import 'package:flutter/material.dart';
import 'package:worldclock/src/timezones.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {

  TimeZones tz = TimeZones();

  void setup() async{
    tz.getTimeZones();
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
        child: ListView.builder(
          itemCount: tz.timezones.length,
          itemBuilder: (context, index){
            return Card(
              color: Colors.deepPurpleAccent,
              child: ListTile(
                onTap: () {
                  setState(() {
                    Navigator.of(context).pushReplacementNamed('/', arguments: {'timezone' : tz.timezones[index], 'location' : tz.locations[index]});
                  });
                },
                title: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text('${tz.locations[index]}', style: TextStyle(color: Colors.white, fontSize: 16, letterSpacing: 1.2, fontWeight: FontWeight.w300),),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}

