import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AudioPlayerClass extends StatefulWidget {
  const AudioPlayerClass({Key? key}) : super(key: key);


  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}
class _AudioPlayerState extends State<AudioPlayerClass> {

 AudioPlayer audioPlayer = new AudioPlayer();

  Duration duration = new Duration();
  bool playing = false;
  Duration positon = new Duration();
  void initState(){
   super.initState();
   _checkConnectivity();
 }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('AudioPlayer',
        style: TextStyle(
          color: Colors.white,

        ),),
      ),
      body: Column(
        children: <Widget>[
          Center(child: Image(image:AssetImage('assets/playbtn.png'),
          height: 300,width: 300,)),
          slider(),
          InkWell(
            onTap: (){
              getAudio();
            },
            child: Icon(
             playing == false ? Icons.play_circle_outline :Icons.pause_circle_outline,
              size: 64,
              color: Colors.cyan,

            ),
          )

        ],
      ),
    );

  }
  Widget slider(){
    return Slider.adaptive(
        min:0.0,
        value: positon.inSeconds.toDouble(),
        max:duration.inSeconds.toDouble(),
        onChanged: (double value){
           setState(() {
             audioPlayer.seek(new Duration(seconds: value.toInt()));
           });
        });
  }
  void getAudio() async {
    var url = 'https://dns2.vippendu.com/128k/33144/19773/Yaara-Mamta-Sharma.mp3';
  // var url= 'http://www.calixto.com/mp3/ManhaDeCarnaval.mp3';
    //var url = 'http://drive.funados-radio.fr/playlist/HITS%20DU%20MOMENT/Alan%20Walker%20-%20Faded.mp3';
    if(playing){
      var res  = await audioPlayer.pause();
      if(res == 1 ){
        setState(() {
          playing==false;
        });
      }

    }
    else{
      var res = await audioPlayer.play(url,isLocal: true);
      if(res == 1){
        setState(() {
          playing ==true;
        });


      }
    }

    audioPlayer.onDurationChanged.listen((Duration dd ){
      setState(() {
        duration = dd;
      });
    });
    audioPlayer.onAudioPositionChanged.listen((Duration dd) {
      setState(() {
        positon == dd;
      });
    });

  }

  void _checkConnectivity() async{
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

       // print('connected');
      }
    } on SocketException catch (_) {
      print('No internet');
      Fluttertoast.showToast(
          msg: "no internet",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

     // print('not connected');
    }
  }
}
