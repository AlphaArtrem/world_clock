import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};
  double font = 65;
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    if( data['time'] == "Can't Load Time"){
      font = 25;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('World Clock'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('${data['time']}', style: TextStyle(color: Colors.deepPurpleAccent, fontSize: font),),
            SizedBox(height: 5),
            Text('${data['location']}\n\n', style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 25, letterSpacing: 2),),
            RaisedButton.icon(
              onPressed: () async{
                dynamic result = await Navigator.pushNamed(context, '/location');
                print(result);
                setState(() {
                  data = {
                    'time' : result['time'],
                    'location' : result['location']
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
      ),
    );
  }
}

