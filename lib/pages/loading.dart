import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void setupWorldTime() async {
    try {
      WorldTime instance = WorldTime(
        location: 'Chicago',
        flag: 'usa.png',
        url: 'America/Chicago',
      );

      await instance.getTime();

      if (!mounted) return; // prevent calling Navigator after widget disposed
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'isDaytime': instance.isDaytime,
      });
    } catch (e) {
      debugPrint('Error in setupWorldTime: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load time data')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 60.0,
        ),
      ),
    );
  }
}
