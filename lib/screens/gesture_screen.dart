import 'package:flutter/material.dart';
import 'package:form/widgets/colorful_card.dart';
import 'package:form/widgets/custom_form.dart';

class GestureScreen extends StatefulWidget {
  const GestureScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GestureScreen();
  }
}

class _GestureScreen extends State<GestureScreen> {
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
              child: const ColorfulCard()
          ),
        )
    );
  }
}
