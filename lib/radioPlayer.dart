import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'data/data.dart';
import 'homeScreen.dart';

class RadioPlayer extends StatefulWidget {
  const RadioPlayer({Key? key}) : super(key: key);

  @override
  State<RadioPlayer> createState() => _RadioPlayerState();
}

class _RadioPlayerState extends State<RadioPlayer> {
  late Future<Aduio> futureAduio;

  @override
  @override
  void initState() {
    super.initState();
    futureAduio = loaddata();
    setUpTimedFetch();
  }
   setUpTimedFetch() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        futureAduio = loaddata();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home:  FutureBuilder<Aduio>(
              future: futureAduio,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Home_Screen(url: snapshot.data!.data[0].track.imageurl, title: snapshot.data!.data[0].track.title, artist: snapshot.data!.data[0].track.artist);
         } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              strokeWidth: 5.0);
        }, 
      ),
    );
  }
}
