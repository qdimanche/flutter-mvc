import 'package:flutter/material.dart';

class ColorfulCard extends StatefulWidget {
  const ColorfulCard({super.key});

 @override
 _ColorfulCardState createState() => _ColorfulCardState();
}

class _ColorfulCardState extends State<ColorfulCard> {
  Color cardColor = Colors.blue;

  void changeColor() {
    setState(() {
      cardColor = cardColor == Colors.blue ? Colors.red : Colors.blue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: changeColor,
      child: Card(
        color: cardColor,
        child: const SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: Text(
              'Cliquez Moi!',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
