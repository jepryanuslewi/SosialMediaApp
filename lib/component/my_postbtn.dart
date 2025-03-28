import 'package:flutter/material.dart';

class MyPostbtn extends StatelessWidget {
  final void Function()? onTap;
  const MyPostbtn({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 23, 63, 96),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.send, color: Colors.blue),
      ),
    );
  }
}
