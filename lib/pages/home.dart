import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map? ?? {};

    String location = data['location'] ?? 'Unknown';
    String time = data['time'] ?? '--:--';
    bool isDaytime = data['isDaytime'] ?? true;
    String bgImage = isDaytime ? 'DayTime.png' : 'NightTime.jpg';
    Color bgColor = isDaytime ? Colors.blue : Colors.indigo[900]!;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
              onError: (_, __) {}, // Prevent crash
            ),
            color: bgColor, // Fallback
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                ElevatedButton.icon(
                  onPressed: () async {
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    if (result != null) {
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDaytime': result['isDaytime'],
                          'flag': result['flag'],
                        };
                      });
                    }
                  },
                  icon: const Icon(Icons.edit_location, color: Colors.black),
                  label: const Text('Edit Location', style: TextStyle(color: Colors.black)),
                ),
                const SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      location,
                      style: const TextStyle(fontSize: 28.0, letterSpacing: 2.0, color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Text(
                  time,
                  style: const TextStyle(fontSize: 66.0, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}