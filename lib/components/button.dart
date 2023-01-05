import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final Function()? onTap;
  final String text;
  const Button({Key? key, required this.onTap, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onLongPress: onTap,
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color.fromRGBO(0, 255, 194, 100)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
                color: Color.fromRGBO(0, 255, 194, 100),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
