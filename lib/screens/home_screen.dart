import 'package:flutter/material.dart';
import 'package:form/screens/gesture_screen.dart';
import 'package:form/screens/user_screen.dart';
import 'package:form/widgets/custom_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter', style: TextStyle(color: Colors.white)),
        leading: const Icon(Icons.access_alarm, color: Color(0xFFFF00FF)),
        elevation: 10.0,
        centerTitle: true,
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(30.0),
          width: 400,
          child: Column(
            children: [
              const MyCustomForm(),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const GestureScreen()),
                    );}
              , child: const Text("Gesture screen")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const UserScreen()),
                    );}
                  , child: const Text("User screen"))
            ],
          )

          ),
        )
    );
  }
}
