import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime now;
  Map data = {};
  double font = 55;
  bool twelveHour = false;
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    if( data['time'] == "Can't Load Time"){
      font = 25;
    }
    now = data['datetime'];
    return Scaffold(
      appBar: AppBar(
        title: Text('World Clock'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.access_time),
            onPressed: (){
              twelveHour = !twelveHour;
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: timeStream(),
        builder: (context, snapshot) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('${data['time']}', style: TextStyle(color: Colors.deepPurpleAccent, fontSize: font),),
                SizedBox(height: 5),
                Text('${data['location']}\n\n', style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25, letterSpacing: 2),),
                RaisedButton.icon(
                  onPressed: () async{
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time' : result['time'],
                        'location' : result['location'],
                        'datetime' : result['datetime']
                      };
                    });
                  },
                  icon: Icon(Icons.edit_location, color: Colors.white,),
                  label: Text('Change Location', style: TextStyle(color: Colors.white, fontSize: 18),),
                  color: Colors.deepPurpleAccent,
                  elevation: 20,
                ),
              ],
            ),
          );
        }
      ),
    );
  }

  void updateTime(int i){
    now = now.add(Duration(seconds : 1));
    data['time'] = twelveHour ? DateFormat.jms().format(now) : DateFormat.Hms().format(now);
  }

  Stream timeStream(){
    Duration duration = Duration(seconds: 1);
    Stream stream = Stream.periodic(duration, updateTime);
    return stream;
  }
}

