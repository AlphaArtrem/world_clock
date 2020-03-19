import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:worldclock/src/get_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setup({String location = 'India' ,String zone = 'Asia/Kolkata'}) async{
    GetTime timer = GetTime(location: location, zone: zone);
    await timer.getTime();
    setState(() {
      Navigator.of(context).pushReplacementNamed('/home', arguments: {'time': timer.time, 'location': timer.location});
    });
  }

  @override
  void initState(){
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    if(data != null)
      {
        setup(location : data['location'], zone : data['timezone']);
      }
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

