import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldclock/src/get_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setup() async{
    GetTime timer = GetTime(location: 'India', zone: 'Asia/Kolkata');
    await timer.getTime();
    setState(() {
      Navigator.of(context).pushReplacementNamed('/home', arguments: {'time': timer.time, 'location': timer.location, 'datetime' : timer.now});
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
      body: Center(
          child: SpinKitDoubleBounce(
            color: Colors.deepPurpleAccent,
            size: 100,
          ),
      ),
    );
  }
}

